package promotion

import "github.com/flipped-aurora/gin-vue-admin/server/global"

type RegionCategory struct {
	global.GVA_MODEL
	Name     string `json:"name" gorm:"type:varchar(64);uniqueIndex:uk_region_name"`
	ParentID *uint  `json:"parentId" gorm:"index:idx_region_parent"`
	Sort     int    `json:"sort" gorm:"index:idx_region_sort"`
	Remark   string `json:"remark" gorm:"type:varchar(255)"`
}

func (RegionCategory) TableName() string {
	return "region_category"
}

type PromotionGroup struct {
	global.GVA_MODEL
	Name     string `json:"name" gorm:"type:varchar(64);uniqueIndex:uk_group_name"`
	RegionID uint   `json:"regionId" gorm:"index:idx_group_region"`
	Sort     int    `json:"sort" gorm:"index:idx_group_sort"`
	Remark   string `json:"remark" gorm:"type:varchar(255)"`
}

func (PromotionGroup) TableName() string {
	return "promotion_group"
}

type GroupMember struct {
	global.GVA_MODEL
	Nickname string `json:"nickname" gorm:"type:varchar(64)"`
	RegionID uint   `json:"regionId" gorm:"index:idx_member_region"`
	GroupID  uint   `json:"groupId" gorm:"index:idx_member_group"`
	RealName string `json:"realName" gorm:"type:varchar(64)"`
	Wechat   string `json:"wechat" gorm:"type:varchar(64)"`
	Mobile   string `json:"mobile" gorm:"type:varchar(20)"`
	Gender   string `json:"gender" gorm:"type:enum('男','女','未知');default:'未知'"`
	Sort     int    `json:"sort" gorm:"index:idx_member_sort"`
	Remark   string `json:"remark" gorm:"type:varchar(255)"`
}

func (GroupMember) TableName() string {
	return "group_member"
}

