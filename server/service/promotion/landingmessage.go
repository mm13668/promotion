package promotion

import (
	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/promotion"
	"go.uber.org/zap"
	"gorm.io/gorm"
)

type LandingMessageService struct{}

// CreateLandingMessage 创建落地页留言记录
func (l *LandingMessageService) CreateLandingMessage(landingMessage *promotion.LandingMessage) (err error) {
	err = global.GVA_DB.Create(landingMessage).Error
	if err != nil {
		return err
	}

	if landingMessage.LandingVisitID != nil {
		if visitErr := global.GVA_DB.Model(&promotion.LandingVisit{}).
			Where("id = ?", *landingMessage.LandingVisitID).
			Update("conversion_type", gorm.Expr("CONCAT_WS(',', NULLIF(conversion_type, ''), ?)", promotion.ConversionTypeFormSubmit)).Error; visitErr != nil {
			global.GVA_LOG.Error("update landing visit conversion_type failed", zap.Error(visitErr))
		}
	}

	return nil
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
	if info.Processed != nil {
		db = db.Where("processed = ?", *info.Processed)
	}

	err = db.Count(&total).Error
	if err != nil {
		return
	}
	err = db.Order("created_at desc").Limit(limit).Offset(offset).Find(&list).Error
	return
}

// UpdateLandingMessageProcessed 更新留言处理状态
func (l *LandingMessageService) UpdateLandingMessageProcessed(id uint, processed bool) (err error) {
	err = global.GVA_DB.Model(&promotion.LandingMessage{}).Where("id = ?", id).Update("processed", processed).Error
	return
}

// BatchUpdateLandingMessageProcessed 批量更新留言处理状态
func (l *LandingMessageService) BatchUpdateLandingMessageProcessed(ids []uint, processed bool) (err error) {
	err = global.GVA_DB.Model(&promotion.LandingMessage{}).Where("id IN ?", ids).Update("processed", processed).Error
	return
}

// MarkAllLandingMessageProcessed 将某个链接的所有留言标记为已处理/未处理
func (l *LandingMessageService) MarkAllLandingMessageProcessed(linkID string, processed bool) (err error) {
	err = global.GVA_DB.Model(&promotion.LandingMessage{}).Where("link_id = ?", linkID).Update("processed", processed).Error
	return
}

// GetUnprocessedMessageCount 获取某个链接未处理的留言数量
func (l *LandingMessageService) GetUnprocessedMessageCount(linkID string) (count int64, err error) {
	err = global.GVA_DB.Model(&promotion.LandingMessage{}).Where("link_id = ? AND processed = 0", linkID).Count(&count).Error
	return
}
