package promotion

import (
	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/request"
)

type LandingMessage struct {
	global.GVA_MODEL
	LinkID    string `json:"linkId" gorm:"column:link_id;comment:推广链接ID"`
	Name      string `json:"name" gorm:"column:name;comment:留言人姓名"`
	Phone     string `json:"phone" gorm:"column:phone;comment:留言人手机号"`
	Content   string `json:"content" gorm:"column:content;comment:留言内容"`
	Email     string `json:"email" gorm:"column:email;comment:留言人邮箱"`
	Ip        string `json:"ip" gorm:"column:ip;comment:访问IP"`
	UserAgent string `json:"userAgent" gorm:"column:user_agent;comment:访问UA"`
}

func (LandingMessage) TableName() string {
	return "landing_messages"
}

type LandingMessageSearch struct {
	LinkID    string `json:"linkId" form:"linkId"`
	Ip        string `json:"ip" form:"ip"`
	Phone     string `json:"phone" form:"phone"`
	StartTime string `json:"startTime" form:"startTime"`
	EndTime   string `json:"endTime" form:"endTime"`
	request.PageInfo
}
