package promotion

import (
	"context"
	"fmt"
	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/promotion"
	"github.com/flipped-aurora/gin-vue-admin/server/utils/callback"
	"github.com/google/uuid"
	"go.uber.org/zap"
	"gorm.io/gorm"
	"time"
)

type LandingVisitService struct{}

var LandingVisitServiceApp = new(LandingVisitService)

// CreateLandingVisit 初始化创建访问记录
func (l *LandingVisitService) CreateLandingVisit(ctx context.Context, visit *promotion.LandingVisit) (err error) {
	// 先查询是否存在相同IP和LinkId的记录
	var existingVisit promotion.LandingVisit
	err = global.GVA_DB.Debug().Where("ip = ? AND link_id = ?", visit.Ip, visit.LinkId).First(&existingVisit).Error
	if err == nil {
		// 存在记录，直接返回已有ID
		visit.ID = existingVisit.ID
		return nil
	}
	pl, err := new(LinkService).GetPromotionLink(visit.LinkId, uuid.Nil)
	if err != nil {
		global.GVA_LOG.Error("CreateLandingVisit GetPromotionLink err", zap.Error(err))
	}
	visit.UUID = pl.UUID

	// 不存在记录，创建新记录
	err = global.GVA_DB.Debug().Create(visit).Error
	if err != nil {
		return err
	}
	// 更新推广链接的访问次数
	err = global.GVA_DB.Model(&promotion.PromotionLink{}).Where("id = ?", visit.LinkId).
		Update("visit_count", gorm.Expr("visit_count + 1")).Error
	return err
}

// UpdateDuration 更新浏览时长
func (l *LandingVisitService) UpdateDuration(ctx context.Context, id uint, addDuration int) (err error) {
	err = global.GVA_DB.Model(&promotion.LandingVisit{}).Where("id = ?", id).
		Updates(map[string]interface{}{
			"duration":       gorm.Expr("duration + ?", addDuration),
			"last_report_at": time.Now(),
		}).Error
	return err
}

// UpdateCopyInfo 更新复制客服信息
func (l *LandingVisitService) UpdateCopyInfo(ctx context.Context, id uint, phone, nickname string) (err error) {
	// 查询访问记录
	var visit promotion.LandingVisit
	err = global.GVA_DB.Where("id = ?", id).First(&visit).Error
	if err != nil {
		return err
	}

	// 检查是否已经复制过
	if visit.IsCopied {
		return nil
	}

	now := time.Now()
	// 更新访问记录的复制信息
	err = global.GVA_DB.Model(&promotion.LandingVisit{}).Where("id = ?", id).
		Updates(map[string]interface{}{
			"is_copied":               true,
			"copied_service_phone":    phone,
			"copied_service_nickname": nickname,
			"copied_at":               now,
			"conversion_type":         gorm.Expr("CONCAT_WS(',', NULLIF(conversion_type, ''), ?)", promotion.ConversionTypeCopy),
		}).Error
	if err != nil {
		return err
	}

	// 更新推广链接的复制次数
	err = global.GVA_DB.Model(&promotion.PromotionLink{}).Where("id = ?", visit.LinkId).
		Update("copy_count", gorm.Expr("copy_count + 1")).Error
	return err
}

func (l *LandingVisitService) ReportManualOcpcCallback(visitId uint) error {
	var visit promotion.LandingVisit
	err := global.GVA_DB.Where("id = ?", visitId).First(&visit).Error
	if err != nil {
		return fmt.Errorf("landing visit not found: %w", err)
	}

	if visit.IsOcpcCallback {
		return fmt.Errorf("landing visit %d has already been called back", visitId)
	}

	var link promotion.PromotionLink
	err = global.GVA_DB.Where("id = ?", visit.LinkId).First(&link).Error
	if err != nil {
		return fmt.Errorf("promotion link not found: %w", err)
	}

	if link.OcpcKey == "" {
		return fmt.Errorf("promotion link %d has no OCPC key configured", visit.LinkId)
	}

	// 从 ad_platform 获取 platform_key 作为 provider 名称
	var platform promotion.AdPlatform
	err = global.GVA_DB.Where("id = ?", link.PlatformID).First(&platform).Error
	if err != nil {
		return fmt.Errorf("ad platform not found for link %d: %w", visit.LinkId, err)
	}
	if platform.PlatformKey == "" {
		return fmt.Errorf("ad platform %d has no platform_key configured", link.PlatformID)
	}

	factory := callback.GetDefaultFactory()
	provider, err := factory.GetProvider(platform.PlatformKey)
	if err != nil {
		return fmt.Errorf("get callback provider '%s' failed: %w", platform.PlatformKey, err)
	}

	req := &callback.ConversionRequest{
		Token:          provider.GetToken(link.OcpcKey),
		LogidUrl:       visit.RefererUrl,
		ConversionType: int(link.OcpcConversionType),
	}

	if req.LogidUrl == "" {
		return fmt.Errorf("landing visit %d has no referer URL (logidUrl required for OCPC)", visitId)
	}

	ctx := context.Background()
	if err := provider.UploadConversion(ctx, req); err != nil {
		return fmt.Errorf("ocpc callback failed: %w", err)
	}

	now := time.Now()
	err = global.GVA_DB.Model(&promotion.LandingVisit{}).Where("id = ?", visitId).
		Updates(map[string]interface{}{
			"is_ocpc_callback": true,
			"ocpc_callback_at": now,
		}).Error
	if err != nil {
		global.GVA_LOG.Error("update ocpc callback status failed", zap.Error(err))
		return err
	}

	return nil
}

// GetLandingVisitList 分页查询访问记录列表
func (l *LandingVisitService) GetLandingVisitList(info promotion.LandingVisitSearch, userUUID uuid.UUID) (list []promotion.LandingVisit, total int64, err error) {
	limit := info.PageSize
	offset := info.PageSize * (info.Page - 1)
	db := global.GVA_DB.Model(&promotion.LandingVisit{})

	// 按账号隔离：只能查询该账号的数据
	if userUUID != uuid.Nil {
		db = db.Where("uuid = ?", userUUID)
	}

	// 推广链接筛选
	if info.LinkId != nil {
		db = db.Where("link_id = ?", *info.LinkId)
	}

	// IP 精准搜索
	if info.Ip != "" {
		db = db.Where("ip = ?", info.Ip)
	}

	// referer 关键字搜索
	if info.Referer != "" {
		db = db.Where("referer LIKE ?", "%"+info.Referer+"%")
	}

	// request_referer 关键字搜索
	if info.RequestReferer != "" {
		db = db.Where("request_referer LIKE ?", "%"+info.RequestReferer+"%")
	}

	// 是否复制客服信息筛选
	if info.IsCopied != nil {
		db = db.Where("is_copied = ?", *info.IsCopied)
	}

	// 是否OCPC回传筛选
	if info.IsOcpcCallback != nil {
		db = db.Where("is_ocpc_callback = ?", *info.IsOcpcCallback)
	}

	// 创建时间范围筛选
	if info.StartTime != "" {
		db = db.Where("created_at >= ?", info.StartTime+" 00:00:00")
	}
	if info.EndTime != "" {
		db = db.Where("created_at <= ?", info.EndTime+" 23:59:59")
	}

	err = db.Count(&total).Error
	if err != nil {
		return
	}
	err = db.Order("created_at desc").Limit(limit).Offset(offset).Find(&list).Error
	return
}
