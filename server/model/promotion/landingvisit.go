package promotion

import (
	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/request"
	"time"
)

type LandingVisit struct {
	global.GVA_MODEL
	LinkId                uint      `json:"linkId" gorm:"column:link_id;comment:推广链接ID"`
	Ip                    string    `json:"ip" gorm:"column:ip;comment:访问IP"`
	Referer               string    `json:"referer" gorm:"column:referer;comment:来源链接(JSON body)"`
	UserAgent             string    `json:"userAgent" gorm:"column:user_agent;comment:浏览器UA(JSON body)"`
	RequestReferer        string    `json:"requestReferer" gorm:"column:request_referer;comment:来源链接(HTTP请求头)"`
	RequestUserAgent      string    `json:"requestUserAgent" gorm:"column:request_user_agent;comment:浏览器UA(HTTP请求头)"`
	DeviceType            string    `json:"deviceType" gorm:"column:device_type;comment:设备类型"`
	Os                    string    `json:"os" gorm:"column:os;comment:操作系统"`
	Browser               string    `json:"browser" gorm:"column:browser;comment:浏览器信息"`
	Region                string    `json:"region" gorm:"column:region;comment:IP解析地区"`
	Duration              int       `json:"duration" gorm:"column:duration;default:0;comment:总浏览时长(秒)"`
	IsCopied              bool      `json:"isCopied" gorm:"column:is_copied;default:false;comment:是否复制客服信息"`
	CopiedServicePhone    string    `json:"copiedServicePhone" gorm:"column:copied_service_phone;comment:复制的客服号码"`
	CopiedServiceNickname string    `json:"copiedServiceNickname" gorm:"column:copied_service_nickname;comment:复制的客服昵称"`
	LastReportAt          time.Time `json:"lastReportAt" gorm:"column:last_report_at;comment:最后上报时间"`
}

func (LandingVisit) TableName() string {
	return "landing_visits"
}

type LandingVisitSearch struct {
	Ip        string `json:"ip" form:"ip"`
	IsCopied  *bool  `json:"isCopied" form:"isCopied"`
	StartTime string `json:"startTime" form:"startTime"`
	EndTime   string `json:"endTime" form:"endTime"`
	request.PageInfo
}
