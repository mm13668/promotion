package promotion

import (
	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/promotion"
)

type LandingMessageService struct{}

// CreateLandingMessage 创建落地页留言记录
func (l *LandingMessageService) CreateLandingMessage(landingMessage *promotion.LandingMessage) (err error) {
	err = global.GVA_DB.Create(landingMessage).Error
	return err
}

// GetLandingMessageList 分页获取落地页留言列表
func (l *LandingMessageService) GetLandingMessageList(info promotion.LandingMessageSearch) (list []promotion.LandingMessage, total int64, err error) {
	limit := info.PageSize
	offset := info.PageSize * (info.Page - 1)
	db := global.GVA_DB.Model(&promotion.LandingMessage{})

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
