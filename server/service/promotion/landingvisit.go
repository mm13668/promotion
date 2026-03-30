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
	err = global.GVA_DB.Create(visit).Error
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
	err = global.GVA_DB.Model(&promotion.LandingVisit{}).Where("id = ?", id).
		Updates(map[string]interface{}{
			"is_copied":               true,
			"copied_service_phone":    phone,
			"copied_service_nickname": nickname,
		}).Error
	return err
}

// GetLandingVisitList 分页查询访问记录
func (l *LandingVisitService) GetLandingVisitList(info promotion.LandingVisitSearch) (list []promotion.LandingVisit, total int64, err error) {
	limit := info.PageSize
	offset := info.PageSize * (info.Page - 1)
	db := global.GVA_DB.Model(&promotion.LandingVisit{})

	if info.Ip != "" {
		db = db.Where("ip LIKE ?", "%"+info.Ip+"%")
	}
	if info.IsCopied != nil {
		db = db.Where("is_copied = ?", *info.IsCopied)
	}
	if info.StartTime != "" {
		db = db.Where("created_at >= ?", info.StartTime)
	}
	if info.EndTime != "" {
		db = db.Where("created_at <= ?", info.EndTime)
	}

	err = db.Count(&total).Error
	if err != nil {
		return
	}
	err = db.Order("created_at desc").Limit(limit).Offset(offset).Find(&list).Error
	return
}
