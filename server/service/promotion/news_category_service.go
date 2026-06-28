package promotion

import (
	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/promotion"
)

type NewsCategoryService struct{}

var NewsCategoryServiceApp = new(NewsCategoryService)

func (s *NewsCategoryService) Create(e promotion.NewsCategory) (err error) {
	err = global.GVA_DB.Create(&e).Error
	return
}

func (s *NewsCategoryService) Delete(e promotion.NewsCategory) (err error) {
	err = global.GVA_DB.Delete(&e).Error
	return
}

func (s *NewsCategoryService) Update(e *promotion.NewsCategory) (err error) {
	err = global.GVA_DB.Save(e).Error
	return
}

func (s *NewsCategoryService) Find(id uint) (category promotion.NewsCategory, err error) {
	err = global.GVA_DB.Where("id = ?", id).First(&category).Error
	return
}

func (s *NewsCategoryService) GetList(info promotion.NewsCategorySearch) (list []promotion.NewsCategory, total int64, err error) {
	limit := info.PageSize
	offset := info.PageSize * (info.Page - 1)
	db := global.GVA_DB.Model(&promotion.NewsCategory{})

	if info.Name != "" {
		db = db.Where("name LIKE ?", "%"+info.Name+"%")
	}
	if info.Status != nil {
		db = db.Where("status = ?", *info.Status)
	}
	err = db.Count(&total).Error
	if err != nil {
		return
	}
	err = db.Order("sort asc, id desc").Limit(limit).Offset(offset).Find(&list).Error
	return
}

// GetAllEnabled 获取所有启用的分类（供下拉选择）
func (s *NewsCategoryService) GetAllEnabled() (list []promotion.NewsCategory, err error) {
	err = global.GVA_DB.Where("status = 1").Order("sort asc, id asc").Find(&list).Error
	return
}
