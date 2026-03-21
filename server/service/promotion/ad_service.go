package promotion

import (
	"time"

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

type CampaignFilter struct {
	PlatformID *uint
	LinkID     *uint
	RegionID   *uint
	GroupID    *uint
	Keyword    string
}

func (s *AdService) GetCampaignList(info request.PageInfo, f CampaignFilter) (list []promotion.AdCampaign, total int64, err error) {
	limit := info.PageSize
	offset := info.PageSize * (info.Page - 1)
	db := global.GVA_DB.Model(&promotion.AdCampaign{})
	if f.PlatformID != nil {
		db = db.Where("platform_id = ?", *f.PlatformID)
	}
	if f.LinkID != nil {
		db = db.Where("link_id = ?", *f.LinkID)
	}
	if f.RegionID != nil {
		db = db.Where("region_id = ?", *f.RegionID)
	}
	if f.GroupID != nil {
		db = db.Where("group_id = ?", *f.GroupID)
	}
	if f.Keyword != "" {
		k := "%" + f.Keyword + "%"
		db = db.Where("campaign_code LIKE ? OR campaign_name LIKE ?", k, k)
	}
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

type DailySummaryFilter struct {
	PlatformID *uint
	StartDate  *string // "YYYY-MM-DD"
	EndDate    *string // "YYYY-MM-DD"
}

func (s *AdService) GetDailySummaryList(info request.PageInfo, f DailySummaryFilter) (list []promotion.AdDailySummary, total int64, err error) {
	limit := info.PageSize
	offset := info.PageSize * (info.Page - 1)
	db := global.GVA_DB.Model(&promotion.AdDailySummary{})
	if f.PlatformID != nil {
		db = db.Where("platform_id = ?", *f.PlatformID)
	}
	if f.StartDate != nil && f.EndDate != nil && *f.StartDate != "" && *f.EndDate != "" {
		// ensure valid format
		if _, e1 := time.Parse("2006-01-02", *f.StartDate); e1 == nil {
			if _, e2 := time.Parse("2006-01-02", *f.EndDate); e2 == nil {
				db = db.Where("summary_date BETWEEN ? AND ?", *f.StartDate, *f.EndDate)
			}
		}
	}
	err = db.Count(&total).Error
	if err != nil {
		return
	}
	err = db.Limit(limit).Offset(offset).Order("summary_date desc,id desc").Find(&list).Error
	return
}
