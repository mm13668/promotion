package promotion

import (
	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/request"
	"github.com/flipped-aurora/gin-vue-admin/server/model/promotion"
)

type AdService struct{}

func (s *AdService) CreatePlatform(e promotion.AdPlatform) error {
	return global.GVA_DB.Create(&e).Error
}
func (s *AdService) UpdatePlatform(e *promotion.AdPlatform) error {
	return global.GVA_DB.Save(e).Error
}
func (s *AdService) DeletePlatform(e promotion.AdPlatform) error {
	return global.GVA_DB.Delete(&e).Error
}
func (s *AdService) GetPlatformList(info request.PageInfo) (list []promotion.AdPlatform, total int64, err error) {
	limit := info.PageSize
	offset := info.PageSize * (info.Page - 1)
	db := global.GVA_DB.Model(&promotion.AdPlatform{})
	err = db.Count(&total).Error
	if err != nil {
		return
	}
	err = db.Limit(limit).Offset(offset).Order("id desc").Find(&list).Error
	return
}

func (s *AdService) CreateCampaign(e promotion.AdCampaign) error {
	return global.GVA_DB.Create(&e).Error
}
func (s *AdService) UpdateCampaign(e *promotion.AdCampaign) error {
	return global.GVA_DB.Save(e).Error
}
func (s *AdService) DeleteCampaign(e promotion.AdCampaign) error {
	return global.GVA_DB.Delete(&e).Error
}
func (s *AdService) GetCampaignList(info request.PageInfo) (list []promotion.AdCampaign, total int64, err error) {
	limit := info.PageSize
	offset := info.PageSize * (info.Page - 1)
	db := global.GVA_DB.Model(&promotion.AdCampaign{})
	err = db.Count(&total).Error
	if err != nil {
		return
	}
	err = db.Limit(limit).Offset(offset).Order("id desc").Find(&list).Error
	return
}

func (s *AdService) CreateKeyword(e promotion.AdKeyword) error {
	return global.GVA_DB.Create(&e).Error
}
func (s *AdService) UpdateKeyword(e *promotion.AdKeyword) error {
	return global.GVA_DB.Save(e).Error
}
func (s *AdService) DeleteKeyword(e promotion.AdKeyword) error {
	return global.GVA_DB.Delete(&e).Error
}
func (s *AdService) GetKeywordList(info request.PageInfo) (list []promotion.AdKeyword, total int64, err error) {
	limit := info.PageSize
	offset := info.PageSize * (info.Page - 1)
	db := global.GVA_DB.Model(&promotion.AdKeyword{})
	err = db.Count(&total).Error
	if err != nil {
		return
	}
	err = db.Limit(limit).Offset(offset).Order("id desc").Find(&list).Error
	return
}

func (s *AdService) GetDailySummaryList(info request.PageInfo) (list []promotion.AdDailySummary, total int64, err error) {
	limit := info.PageSize
	offset := info.PageSize * (info.Page - 1)
	db := global.GVA_DB.Model(&promotion.AdDailySummary{})
	err = db.Count(&total).Error
	if err != nil {
		return
	}
	err = db.Limit(limit).Offset(offset).Order("summary_date desc,id desc").Find(&list).Error
	return
}

