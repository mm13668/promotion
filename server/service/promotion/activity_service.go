package promotion

import (
	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/request"
	"github.com/flipped-aurora/gin-vue-admin/server/model/promotion"
)

type ActivityService struct{}

func (s *ActivityService) CreateMarket(e promotion.ActivityMarket) error {
	return global.GVA_DB.Create(&e).Error
}
func (s *ActivityService) UpdateMarket(e *promotion.ActivityMarket) error {
	return global.GVA_DB.Save(e).Error
}
func (s *ActivityService) DeleteMarket(e promotion.ActivityMarket) error {
	return global.GVA_DB.Delete(&e).Error
}
func (s *ActivityService) GetMarketList(info request.PageInfo) (list []promotion.ActivityMarket, total int64, err error) {
	limit := info.PageSize
	offset := info.PageSize * (info.Page - 1)
	db := global.GVA_DB.Model(&promotion.ActivityMarket{})
	err = db.Count(&total).Error
	if err != nil {
		return
	}
	err = db.Limit(limit).Offset(offset).Order("sort desc,id desc").Find(&list).Error
	return
}

func (s *ActivityService) CreatePackage(e promotion.ActivityPackage) error {
	return global.GVA_DB.Create(&e).Error
}
func (s *ActivityService) UpdatePackage(e *promotion.ActivityPackage) error {
	return global.GVA_DB.Save(e).Error
}
func (s *ActivityService) DeletePackage(e promotion.ActivityPackage) error {
	return global.GVA_DB.Delete(&e).Error
}
func (s *ActivityService) GetPackageList(info request.PageInfo) (list []promotion.ActivityPackage, total int64, err error) {
	limit := info.PageSize
	offset := info.PageSize * (info.Page - 1)
	db := global.GVA_DB.Model(&promotion.ActivityPackage{})
	err = db.Count(&total).Error
	if err != nil {
		return
	}
	err = db.Limit(limit).Offset(offset).Order("sort desc,id desc").Find(&list).Error
	return
}

func (s *ActivityService) CreateActivity(e promotion.ActivityData) error {
	return global.GVA_DB.Create(&e).Error
}
func (s *ActivityService) UpdateActivity(e *promotion.ActivityData) error {
	return global.GVA_DB.Save(e).Error
}
func (s *ActivityService) DeleteActivity(e promotion.ActivityData) error {
	return global.GVA_DB.Delete(&e).Error
}
type ActivityFilter struct {
	MarketID *uint
	PackageID *uint
	Keyword string
}
func (s *ActivityService) GetActivityList(info request.PageInfo, f ActivityFilter) (list []promotion.ActivityData, total int64, err error) {
	limit := info.PageSize
	offset := info.PageSize * (info.Page - 1)
	db := global.GVA_DB.Model(&promotion.ActivityData{})
	if f.MarketID != nil {
		db = db.Where("market_id = ?", *f.MarketID)
	}
	if f.PackageID != nil {
		db = db.Where("package_id = ?", *f.PackageID)
	}
	if f.Keyword != "" {
		k := "%" + f.Keyword + "%"
		db = db.Where("name_cn LIKE ? OR name_en LIKE ?", k, k)
	}
	err = db.Count(&total).Error
	if err != nil {
		return
	}
	err = db.Limit(limit).Offset(offset).Order("sort desc,id desc").Find(&list).Error
	return
}
