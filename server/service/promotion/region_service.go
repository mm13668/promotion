package promotion

import (
	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/request"
	"github.com/flipped-aurora/gin-vue-admin/server/model/promotion"
	"github.com/google/uuid"
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
func (s *RegionService) GetRegionCategory(id uint, userUUID uuid.UUID) (promotion.RegionCategory, error) {
	var data promotion.RegionCategory
	db := global.GVA_DB.Where("id = ?", id)
	if userUUID != uuid.Nil {
		db = db.Where("uuid = ?", userUUID)
	}
	err := db.First(&data).Error
	return data, err
}

func (s *RegionService) UpdateRegionCategory(e *promotion.RegionCategory) error {
	return global.GVA_DB.Save(e).Error
}

func (s *RegionService) FindRegionCategory(id uint, userUUID uuid.UUID) (promotion.RegionCategory, error) {
	var data promotion.RegionCategory
	db := global.GVA_DB.Where("id = ?", id)
	if userUUID != uuid.Nil {
		db = db.Where("uuid = ?", userUUID)
	}
	err := db.First(&data).Error
	return data, err
}

func (s *RegionService) GetRegionCategoryList(info request.PageInfo, userUUID uuid.UUID) (list []promotion.RegionCategory, total int64, err error) {
	limit := info.PageSize
	offset := info.PageSize * (info.Page - 1)
	db := global.GVA_DB.Model(&promotion.RegionCategory{})
	if userUUID != uuid.Nil {
		db = db.Where("uuid = ?", userUUID)
	}
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
func (s *GroupService) GetPromotionGroup(id uint, userUUID uuid.UUID) (promotion.PromotionGroup, error) {
	var data promotion.PromotionGroup
	db := global.GVA_DB.Where("id = ?", id)
	if userUUID != uuid.Nil {
		db = db.Where("uuid = ?", userUUID)
	}
	err := db.First(&data).Error
	return data, err
}

func (s *GroupService) UpdatePromotionGroup(e *promotion.PromotionGroup) error {
	return global.GVA_DB.Save(e).Error
}

func (s *GroupService) FindPromotionGroup(id uint, userUUID uuid.UUID) (promotion.PromotionGroup, error) {
	var data promotion.PromotionGroup
	db := global.GVA_DB.Where("id = ?", id)
	if userUUID != uuid.Nil {
		db = db.Where("uuid = ?", userUUID)
	}
	err := db.First(&data).Error
	return data, err
}

func (s *GroupService) GetPromotionGroupList(info request.PageInfo, userUUID uuid.UUID) (list []promotion.PromotionGroup, total int64, err error) {
	limit := info.PageSize
	offset := info.PageSize * (info.Page - 1)
	db := global.GVA_DB.Model(&promotion.PromotionGroup{})
	if userUUID != uuid.Nil {
		db = db.Where("uuid = ?", userUUID)
	}
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

func (s *MemberService) FindGroupMember(id uint, userUUID uuid.UUID) (promotion.GroupMember, error) {
	var data promotion.GroupMember
	db := global.GVA_DB.Where("id = ?", id)
	if userUUID != uuid.Nil {
		db = db.Where("uuid = ?", userUUID)
	}
	err := db.First(&data).Error
	return data, err
}

func (s *MemberService) GetGroupMemberList(info request.PageInfo, userUUID uuid.UUID) (list []promotion.GroupMember, total int64, err error) {
	limit := info.PageSize
	offset := info.PageSize * (info.Page - 1)
	db := global.GVA_DB.Model(&promotion.GroupMember{})
	if userUUID != uuid.Nil {
		db = db.Where("uuid = ?", userUUID)
	}
	err = db.Count(&total).Error
	if err != nil {
		return
	}
	err = db.Limit(limit).Offset(offset).Order("sort desc,id desc").Find(&list).Error
	return
}
