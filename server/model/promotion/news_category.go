package promotion

import (
	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/request"
)

type NewsCategory struct {
	global.GVA_MODEL
	Name   string `json:"name" form:"name" gorm:"type:varchar(100);not null;unique;comment:分类名称"`
	Sort   int    `json:"sort" form:"sort" gorm:"default:0;comment:排序"`
	Status int    `json:"status" form:"status" gorm:"type:tinyint(1);default:1;comment:状态 0-禁用 1-启用"`
	Remark string `json:"remark" form:"remark" gorm:"type:varchar(500);default:'';comment:备注"`
}

func (NewsCategory) TableName() string {
	return "news_categories"
}

type NewsCategorySearch struct {
	Name   string `json:"name" form:"name"`
	Status *int   `json:"status" form:"status"`
	request.PageInfo
}
