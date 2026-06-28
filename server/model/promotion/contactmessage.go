package promotion

import (
	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/request"
	"time"
)

type ContactMessage struct {
	global.GVA_MODEL
	Phone       string    `json:"phone" gorm:"column:phone;comment:手机号;size:20"`
	Message     string    `json:"message" gorm:"column:message;comment:留言信息;size:500"`
	IsProcessed bool      `json:"isProcessed" gorm:"column:is_processed;default:0;comment:是否已处理"`
	MessageTime time.Time `json:"messageTime" gorm:"column:message_time;comment:留言时间"`
}

func (ContactMessage) TableName() string {
	return "contact_messages"
}

type ContactMessageSearch struct {
	Phone       string `json:"phone" form:"phone"`
	IsProcessed *bool  `json:"isProcessed" form:"isProcessed"`
	StartTime   string `json:"startTime" form:"startTime"`
	EndTime     string `json:"endTime" form:"endTime"`
	request.PageInfo
}
