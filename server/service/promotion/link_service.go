package promotion

import (
	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/request"
	"github.com/flipped-aurora/gin-vue-admin/server/model/promotion"
)

type LinkService struct{}

func (s *LinkService) CreatePromotionLink(e promotion.PromotionLink) error {
	return global.GVA_DB.Create(&e).Error
}

func (s *LinkService) DeletePromotionLink(e promotion.PromotionLink) error {
	return global.GVA_DB.Delete(&e).Error
}

func (s *LinkService) UpdatePromotionLink(e *promotion.PromotionLink) error {
	return global.GVA_DB.Save(e).Error
}

func (s *LinkService) FindPromotionLink(id uint) (promotion.PromotionLink, error) {
	var data promotion.PromotionLink
	err := global.GVA_DB.Where("id = ?", id).First(&data).Error
	return data, err
}

type LinkFilter struct {
	PlatformID *uint
	RegionID   *uint
	GroupID    *uint
	DomainID   *uint
}

func (s *LinkService) GetPromotionLinkList(info request.PageInfo, f LinkFilter) (list []promotion.PromotionLink, total int64, err error) {
	limit := info.PageSize
	offset := info.PageSize * (info.Page - 1)
	db := global.GVA_DB.Model(&promotion.PromotionLink{})
	if f.PlatformID != nil {
		db = db.Where("platform_id = ?", *f.PlatformID)
	}
	if f.RegionID != nil {
		db = db.Where("region_id = ?", *f.RegionID)
	}
	if f.GroupID != nil {
		db = db.Where("group_id = ?", *f.GroupID)
	}
	if f.DomainID != nil {
		db = db.Where("domain_id = ?", *f.DomainID)
	}
	err = db.Count(&total).Error
	if err != nil {
		return
	}
	err = db.Limit(limit).Offset(offset).Order("sort desc,id desc").Find(&list).Error
	return
}

func (s *LinkService) UpsertBasic(e *promotion.PromotionLinkBasic) error {
	var exist promotion.PromotionLinkBasic
	tx := global.GVA_DB.Where("link_id = ?", e.LinkID).First(&exist)
	if tx.Error == nil {
		e.ID = exist.ID
		return global.GVA_DB.Save(e).Error
	}
	return global.GVA_DB.Create(e).Error
}

func (s *LinkService) GetBasic(linkId uint) (promotion.PromotionLinkBasic, error) {
	var data promotion.PromotionLinkBasic
	err := global.GVA_DB.Where("link_id = ?", linkId).First(&data).Error
	return data, err
}

func (s *LinkService) UpsertCompany(e *promotion.PromotionLinkCompany) error {
	var exist promotion.PromotionLinkCompany
	tx := global.GVA_DB.Where("link_id = ?", e.LinkID).First(&exist)
	if tx.Error == nil {
		e.ID = exist.ID
		return global.GVA_DB.Save(e).Error
	}
	return global.GVA_DB.Create(e).Error
}

func (s *LinkService) GetCompany(linkId uint) (promotion.PromotionLinkCompany, error) {
	var data promotion.PromotionLinkCompany
	err := global.GVA_DB.Where("link_id = ?", linkId).First(&data).Error
	return data, err
}

func (s *LinkService) UpsertCode(e *promotion.PromotionLinkCode) error {
	var exist promotion.PromotionLinkCode
	tx := global.GVA_DB.Where("link_id = ?", e.LinkID).First(&exist)
	if tx.Error == nil {
		e.ID = exist.ID
		return global.GVA_DB.Save(e).Error
	}
	return global.GVA_DB.Create(e).Error
}

func (s *LinkService) GetCode(linkId uint) (promotion.PromotionLinkCode, error) {
	var data promotion.PromotionLinkCode
	err := global.GVA_DB.Where("link_id = ?", linkId).First(&data).Error
	return data, err
}

func (s *LinkService) UpsertTheme(e *promotion.PromotionLinkTheme) error {
	var exist promotion.PromotionLinkTheme
	tx := global.GVA_DB.Where("link_id = ?", e.LinkID).First(&exist)
	if tx.Error == nil {
		e.ID = exist.ID
		return global.GVA_DB.Save(e).Error
	}
	return global.GVA_DB.Create(e).Error
}

func (s *LinkService) GetTheme(linkId uint) (promotion.PromotionLinkTheme, error) {
	var data promotion.PromotionLinkTheme
	err := global.GVA_DB.Where("link_id = ?", linkId).First(&data).Error
	return data, err
}

func (s *LinkService) UpsertComment(e *promotion.PromotionLinkComment) error {
	var exist promotion.PromotionLinkComment
	tx := global.GVA_DB.Where("link_id = ?", e.LinkID).First(&exist)
	if tx.Error == nil {
		e.ID = exist.ID
		return global.GVA_DB.Save(e).Error
	}
	return global.GVA_DB.Create(e).Error
}

func (s *LinkService) GetComment(linkId uint) (promotion.PromotionLinkComment, error) {
	var data promotion.PromotionLinkComment
	err := global.GVA_DB.Where("link_id = ?", linkId).First(&data).Error
	return data, err
}

// 模板插件管理
func (s *LinkService) CreateTemplateWidget(e promotion.PromotionTemplateWidget) error {
	return global.GVA_DB.Create(&e).Error
}

func (s *LinkService) DeleteTemplateWidget(e promotion.PromotionTemplateWidget) error {
	return global.GVA_DB.Delete(&e).Error
}

func (s *LinkService) UpdateTemplateWidget(e *promotion.PromotionTemplateWidget) error {
	return global.GVA_DB.Save(e).Error
}

func (s *LinkService) FindTemplateWidget(id uint) (promotion.PromotionTemplateWidget, error) {
	var data promotion.PromotionTemplateWidget
	err := global.GVA_DB.Where("id = ?", id).First(&data).Error
	return data, err
}

type TemplateWidgetFilter struct {
	Type *uint8
}

func (s *LinkService) GetTemplateWidgetList(info request.PageInfo, f TemplateWidgetFilter) (list []promotion.PromotionTemplateWidget, total int64, err error) {
	limit := info.PageSize
	offset := info.PageSize * (info.Page - 1)
	db := global.GVA_DB.Model(&promotion.PromotionTemplateWidget{})
	if f.Type != nil {
		db = db.Where("type = ?", *f.Type)
	}
	err = db.Count(&total).Error
	if err != nil {
		return
	}
	err = db.Limit(limit).Offset(offset).Order("id desc").Find(&list).Error
	return
}
