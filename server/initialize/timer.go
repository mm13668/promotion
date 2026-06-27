package initialize

import (
	"context"
	"fmt"
	"net/url"
	"github.com/flipped-aurora/gin-vue-admin/server/task"

	"github.com/robfig/cron/v3"

	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/promotion"
	"github.com/flipped-aurora/gin-vue-admin/server/utils/callback"
	"go.uber.org/zap"
	"gorm.io/gorm"
	"time"
)

// autoOcpcCallback 自动OCPC回传任务
func autoOcpcCallback(db *gorm.DB) {
	var visits []promotion.LandingVisit
	oneHourAgo := time.Now().Add(-1 * time.Hour)

	// 查询符合条件的访问记录：最近1小时、未回传、已触发该链接配置的转化类型
	err := db.Debug().
		Model(&promotion.LandingVisit{}).
		Joins("JOIN promotion_link ON promotion_link.id = landing_visits.link_id").
		Where("landing_visits.created_at >= ?", oneHourAgo).
		Where("landing_visits.is_ocpc_callback = ?", false).
		Where("landing_visits.conversion_type IS NOT NULL AND landing_visits.conversion_type != ''").
		Where("FIND_IN_SET(promotion_link.ocpc_conversion_type, landing_visits.conversion_type)").
		Where("landing_visits.duration > promotion_link.ocpc_min_duration").
		Where("promotion_link.ocpc_callback_type = ?", 2). // 自动回传
		Where("promotion_link.ocpc_key != ?", "").
		Where("promotion_link.ocpc_conversion_type != ?", 0).
		Select("landing_visits.*").
		Find(&visits).Error
	if err != nil {
		global.GVA_LOG.Error("auto ocpc callback query failed", zap.Error(err))
		return
	}

	if len(visits) == 0 {
		return
	}

	factory := callback.GetDefaultFactory()

	for _, visit := range visits {
		var link promotion.PromotionLink
		if err := db.Where("id = ?", visit.LinkId).First(&link).Error; err != nil {
			global.GVA_LOG.Error("auto ocpc callback find link failed", zap.Uint("linkId", visit.LinkId), zap.Error(err))
			continue
		}

		if visit.RefererUrl == "" {
			continue
		}

		// 从 ad_platform 获取 platform_key 作为 provider 名称
		var platform promotion.AdPlatform
		if err := db.Where("id = ?", link.PlatformID).First(&platform).Error; err != nil {
			global.GVA_LOG.Error("auto ocpc callback find platform failed", zap.Uint("platformId", link.PlatformID), zap.Error(err))
			continue
		}
		if platform.PlatformKey == "" {
			global.GVA_LOG.Error("auto ocpc callback platform has no key", zap.String("platform", platform.Name))
			continue
		}

		provider, err := factory.GetProvider(platform.PlatformKey)
		if err != nil {
			global.GVA_LOG.Error("auto ocpc callback get provider failed", zap.String("platformKey", platform.PlatformKey), zap.Error(err))
			continue
		}

		req := &callback.ConversionRequest{
			Token:          provider.GetToken(link.OcpcKey),
			Secret:         link.OcpcSecret,
			LogidUrl:       visit.RefererUrl,
			ClickId:        extractClickId(visit.RefererUrl),
			ConversionType: int(link.OcpcConversionType),
		}

		if err := provider.UploadConversion(context.Background(), req); err != nil {
			global.GVA_LOG.Error("auto ocpc callback upload failed",
				zap.Uint("visitId", visit.ID),
				zap.Error(err))
			continue
		}

		now := time.Now()
		db.Model(&promotion.LandingVisit{}).Where("id = ?", visit.ID).
			Updates(map[string]interface{}{
				"is_ocpc_callback": true,
				"ocpc_callback_at": now,
			})

		// 每次回传后短暂休眠，避免触发API限流
		time.Sleep(200 * time.Millisecond)
	}
}

// extractClickId 从URL中提取广告点击ID参数
// 优先提取 qhclickid(360), 降级到 clickid(百度/巨量引擎)
func extractClickId(rawUrl string) string {
	if rawUrl == "" {
		return ""
	}
	u, err := url.Parse(rawUrl)
	if err != nil {
		return ""
	}
	q := u.Query()
	if id := q.Get("qhclickid"); id != "" {
		return id
	}
	return q.Get("clickid")
}

func Timer() {
	go func() {
		var option []cron.Option
		option = append(option, cron.WithSeconds())
		// 清理DB定时任务
		_, err := global.GVA_Timer.AddTaskByFunc("ClearDB", "@daily", func() {
			err := task.ClearTable(global.GVA_DB) // 定时任务方法定在task文件包中
			if err != nil {
				fmt.Println("timer error:", err)
			}
		}, "定时清理数据库【日志，黑名单】内容", option...)
		if err != nil {
			fmt.Println("add timer error:", err)
		}

		// OCPC自动回传定时任务，每30分钟执行一次
		_, err = global.GVA_Timer.AddTaskByFunc("OcpcAutoCallback", "0 */30 * * * ?", func() {
			global.GVA_LOG.Info("ocpc auto callback timer start")
			autoOcpcCallback(global.GVA_DB)
			global.GVA_LOG.Info("ocpc auto callback timer end")
		}, "OCPC自动回传，每30分钟检查并回传符合条件的记录", option...)
		if err != nil {
			fmt.Println("add ocpc auto callback timer error:", err)
		}
	}()
}
