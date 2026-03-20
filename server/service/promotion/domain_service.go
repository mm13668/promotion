package promotion

import (
	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/request"
	"github.com/flipped-aurora/gin-vue-admin/server/model/promotion"
)

type DomainService struct{}

func (s *DomainService) CreatePromotionDomain(e promotion.PromotionDomain) error {
	return global.GVA_DB.Create(&e).Error
}

func (s *DomainService) DeletePromotionDomain(e promotion.PromotionDomain) error {
	return global.GVA_DB.Delete(&e).Error
}

func (s *DomainService) UpdatePromotionDomain(e *promotion.PromotionDomain) error {
	return global.GVA_DB.Save(e).Error
}

func (s *DomainService) FindPromotionDomain(id uint) (promotion.PromotionDomain, error) {
	var data promotion.PromotionDomain
	err := global.GVA_DB.Where("id = ?", id).First(&data).Error
	return data, err
}

func (s *DomainService) GetPromotionDomainList(info request.PageInfo) (list []promotion.PromotionDomain, total int64, err error) {
	limit := info.PageSize
	offset := info.PageSize * (info.Page - 1)
	db := global.GVA_DB.Model(&promotion.PromotionDomain{})
	err = db.Count(&total).Error
	if err != nil {
		return
	}
	err = db.Limit(limit).Offset(offset).Order("id desc").Find(&list).Error
	return
}

