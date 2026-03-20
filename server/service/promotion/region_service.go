package promotion

import (
	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/request"
	"github.com/flipped-aurora/gin-vue-admin/server/model/promotion"
)

type RegionService struct{}
type GroupService struct{}
type MemberService struct{}

func (s *RegionService) CreateRegionCategory(e promotion.RegionCategory) error {
	return global.GVA_DB.Create(&e).Error
}

func (s *RegionService) DeleteRegionCategory(e promotion.RegionCategory) error {
	return global.GVA_DB.Delete(&e).Error
}

func (s *RegionService) UpdateRegionCategory(e *promotion.RegionCategory) error {
	return global.GVA_DB.Save(e).Error
}

func (s *RegionService) FindRegionCategory(id uint) (promotion.RegionCategory, error) {
	var data promotion.RegionCategory
	err := global.GVA_DB.Where("id = ?", id).First(&data).Error
	return data, err
}

func (s *RegionService) GetRegionCategoryList(info request.PageInfo) (list []promotion.RegionCategory, total int64, err error) {
	limit := info.PageSize
	offset := info.PageSize * (info.Page - 1)
	db := global.GVA_DB.Model(&promotion.RegionCategory{})
	err = db.Count(&total).Error
	if err != nil {
		return
	}
	err = db.Limit(limit).Offset(offset).Order("sort desc,id desc").Find(&list).Error
	return
}

func (s *GroupService) CreatePromotionGroup(e promotion.PromotionGroup) error {
	return global.GVA_DB.Create(&e).Error
}

func (s *GroupService) DeletePromotionGroup(e promotion.PromotionGroup) error {
	return global.GVA_DB.Delete(&e).Error
}

func (s *GroupService) UpdatePromotionGroup(e *promotion.PromotionGroup) error {
	return global.GVA_DB.Save(e).Error
}

func (s *GroupService) FindPromotionGroup(id uint) (promotion.PromotionGroup, error) {
	var data promotion.PromotionGroup
	err := global.GVA_DB.Where("id = ?", id).First(&data).Error
	return data, err
}

func (s *GroupService) GetPromotionGroupList(info request.PageInfo) (list []promotion.PromotionGroup, total int64, err error) {
	limit := info.PageSize
	offset := info.PageSize * (info.Page - 1)
	db := global.GVA_DB.Model(&promotion.PromotionGroup{})
	err = db.Count(&total).Error
	if err != nil {
		return
	}
	err = db.Limit(limit).Offset(offset).Order("sort desc,id desc").Find(&list).Error
	return
}

func (s *MemberService) CreateGroupMember(e promotion.GroupMember) error {
	return global.GVA_DB.Create(&e).Error
}

func (s *MemberService) DeleteGroupMember(e promotion.GroupMember) error {
	return global.GVA_DB.Delete(&e).Error
}

func (s *MemberService) UpdateGroupMember(e *promotion.GroupMember) error {
	return global.GVA_DB.Save(e).Error
}

func (s *MemberService) FindGroupMember(id uint) (promotion.GroupMember, error) {
	var data promotion.GroupMember
	err := global.GVA_DB.Where("id = ?", id).First(&data).Error
	return data, err
}

func (s *MemberService) GetGroupMemberList(info request.PageInfo) (list []promotion.GroupMember, total int64, err error) {
	limit := info.PageSize
	offset := info.PageSize * (info.Page - 1)
	db := global.GVA_DB.Model(&promotion.GroupMember{})
	err = db.Count(&total).Error
	if err != nil {
		return
	}
	err = db.Limit(limit).Offset(offset).Order("sort desc,id desc").Find(&list).Error
	return
}

