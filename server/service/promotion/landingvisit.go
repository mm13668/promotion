package promotion

import (
	"context"
	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/promotion"
	"gorm.io/gorm"
	"time"
)

type LandingVisitService struct{}

var LandingVisitServiceApp = new(LandingVisitService)

// CreateLandingVisit 初始化创建访问记录
func (l *LandingVisitService) CreateLandingVisit(ctx context.Context, visit *promotion.LandingVisit) (err error) {
	// 先查询是否存在相同IP和LinkId的记录
	var existingVisit promotion.LandingVisit
	err = global.GVA_DB.Where("ip = ? AND link_id = ?", visit.Ip, visit.LinkId).First(&existingVisit).Error
	if err == nil {
		// 存在记录，直接返回已有ID
		visit.ID = existingVisit.ID
		return nil
	}
	// 不存在记录，创建新记录
	err = global.GVA_DB.Create(visit).Error
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

	// 更新访问记录的复制信息
	err = global.GVA_DB.Model(&promotion.LandingVisit{}).Where("id = ?", id).
		Updates(map[string]interface{}{
			"is_copied":               true,
			"copied_service_phone":    phone,
			"copied_service_nickname": nickname,
		}).Error
	if err != nil {
		return err
	}

	// 更新推广链接的复制次数
	err = global.GVA_DB.Model(&promotion.PromotionLink{}).Where("id = ?", visit.LinkId).
		Update("copy_count", gorm.Expr("copy_count + 1")).Error
	return err
}

// GetLandingVisitList 分页查询访问记录列表
func (l *LandingVisitService) GetLandingVisitList(info promotion.LandingVisitSearch) (list []promotion.LandingVisit, total int64, err error) {
	limit := info.PageSize
	offset := info.PageSize * (info.Page - 1)
	db := global.GVA_DB.Model(&promotion.LandingVisit{})

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
