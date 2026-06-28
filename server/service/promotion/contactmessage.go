package promotion

import (
	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/promotion"
)

type ContactMessageService struct{}

func (s *ContactMessageService) CreateContactMessage(msg *promotion.ContactMessage) (err error) {
	err = global.GVA_DB.Create(msg).Error
	return
}

func (s *ContactMessageService) GetContactMessageList(info promotion.ContactMessageSearch) (list []promotion.ContactMessage, total int64, err error) {
	limit := info.PageSize
	offset := info.PageSize * (info.Page - 1)
	db := global.GVA_DB.Model(&promotion.ContactMessage{})

	if info.Phone != "" {
		db = db.Where("phone LIKE ?", "%"+info.Phone+"%")
	}
	if info.IsProcessed != nil {
		db = db.Where("is_processed = ?", *info.IsProcessed)
	}
	if info.StartTime != "" {
		db = db.Where("message_time >= ?", info.StartTime)
	}
	if info.EndTime != "" {
		db = db.Where("message_time <= ?", info.EndTime)
	}

	err = db.Count(&total).Error
	if err != nil {
		return
	}
	err = db.Order("message_time desc").Limit(limit).Offset(offset).Find(&list).Error
	return
}

func (s *ContactMessageService) UpdateContactMessageProcessed(id uint, isProcessed bool) (err error) {
	err = global.GVA_DB.Model(&promotion.ContactMessage{}).Where("id = ?", id).Update("is_processed", isProcessed).Error
	return
}
