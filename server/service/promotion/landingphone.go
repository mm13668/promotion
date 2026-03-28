package promotion

import (
	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/promotion"
)

type LandingPhoneService struct{}

// CreateLandingPhone 创建落地页手机号收集记录
func (l *LandingPhoneService) CreateLandingPhone(landingPhone *promotion.LandingPhone) (err error) {
	err = global.GVA_DB.Create(landingPhone).Error
	return err
}

// GetLandingPhoneList 分页获取落地页手机号列表
func (l *LandingPhoneService) GetLandingPhoneList(info promotion.LandingPhoneSearch) (list []promotion.LandingPhone, total int64, err error) {
	limit := info.PageSize
	offset := info.PageSize * (info.Page - 1)
	db := global.GVA_DB.Model(&promotion.LandingPhone{})

	if info.LinkID != "" {
		db = db.Where("link_id = ?", info.LinkID)
	}
	if info.Ip != "" {
		db = db.Where("ip LIKE ?", "%"+info.Ip+"%")
	}
	if info.Phone != "" {
		db = db.Where("phone LIKE ?", "%"+info.Phone+"%")
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
