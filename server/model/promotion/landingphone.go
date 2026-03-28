package promotion

import (
	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/request"
)

type LandingPhone struct {
	global.GVA_MODEL
	LinkID    string `json:"linkId" gorm:"column:link_id;comment:推广链接ID"`
	Phone     string `json:"phone" gorm:"column:phone;comment:登录手机号"`
	Ip        string `json:"ip" gorm:"column:ip;comment:访问IP"`
	UserAgent string `json:"userAgent" gorm:"column:user_agent;comment:访问UA"`
}

func (LandingPhone) TableName() string {
	return "landing_phones"
}

type LandingPhoneSearch struct {
	LinkID    string `json:"linkId" form:"linkId"`
	Ip        string `json:"ip" form:"ip"`
	Phone     string `json:"phone" form:"phone"`
	StartTime string `json:"startTime" form:"startTime"`
	EndTime   string `json:"endTime" form:"endTime"`
	request.PageInfo
}
