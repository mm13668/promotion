package promotion

import (
	"time"

	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/request"
	"github.com/flipped-aurora/gin-vue-admin/server/model/promotion"
	"github.com/google/uuid"
)

type DomainService struct{}

var DomainServiceObj DomainService = DomainService{}

func (s *DomainService) CreatePromotionDomain(e promotion.PromotionDomain) error {
	return global.GVA_DB.Create(&e).Error
}

func (s *DomainService) DeletePromotionDomain(e promotion.PromotionDomain) error {
	return global.GVA_DB.Delete(&e).Error
}

func (s *DomainService) GetPromotionDomain(id uint, userUUID uuid.UUID) (promotion.PromotionDomain, error) {
	var data promotion.PromotionDomain
	db := global.GVA_DB.Where("id = ?", id)
	if userUUID != uuid.Nil {
		db = db.Where("uuid = ?", userUUID)
	}
	err := db.First(&data).Error
	return data, err
}

func (s *DomainService) UpdatePromotionDomain(e *promotion.PromotionDomain) error {
	var old promotion.PromotionDomain
	if err := global.GVA_DB.Where("id = ?", e.ID).First(&old).Error; err != nil {
		return err
	}
	if e.HttpsStatus == 1 && (old.HttpsStatus != 1 || old.HttpsEnableTime == nil) {
		now := time.Now().Unix()
		e.HttpsEnableTime = &now
	} else if e.HttpsStatus != 1 {
		e.HttpsEnableTime = nil
	} else {
		e.HttpsEnableTime = old.HttpsEnableTime
	}
	return global.GVA_DB.Save(e).Error
}

func (s *DomainService) FindPromotionDomain(id uint) (promotion.PromotionDomain, error) {
	var data promotion.PromotionDomain
	err := global.GVA_DB.Where("id = ?", id).First(&data).Error
	return data, err
}

func (s *DomainService) GetPromotionDomainList(info request.PageInfo, userUUID uuid.UUID) (list []promotion.PromotionDomain, total int64, err error) {
	limit := info.PageSize
	offset := info.PageSize * (info.Page - 1)
	db := global.GVA_DB.Model(&promotion.PromotionDomain{})
	if userUUID != uuid.Nil {
		db = db.Where("uuid = ?", userUUID)
	}
	err = db.Count(&total).Error
	if err != nil {
		return
	}
	err = db.Limit(limit).Offset(offset).Order("id desc").Find(&list).Error
	return
}
