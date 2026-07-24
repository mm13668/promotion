package promotion

import (
	"github.com/google/uuid"
	"time"

	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/request"
)

// 转化类型常量（与百度OCPC枚举值对齐）
const (
	ConversionTypeCopy       = "35" // 微信复制按钮点击
	ConversionTypeFormSubmit = "3"  // 表单提交成功
	ConversionTypeRegister   = "49" // 注册激活后登录（注册转化）
)

type LandingVisit struct {
	global.GVA_MODEL
	LinkId                uint      `json:"linkId" gorm:"column:link_id;comment:推广链接ID"`
	UUID                  uuid.UUID `json:"uuid" gorm:"type:varchar(100);index:idx_landing_visit_uuid;comment:用户UUID"`
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
	CopiedAt              *time.Time `json:"copiedAt" gorm:"column:copied_at;comment:复制时间"`
	IsOcpcCallback        bool      `json:"isOcpcCallback" gorm:"column:is_ocpc_callback;default:false;comment:是否已OCPC回传"`
	OcpcCallbackAt        *time.Time `json:"ocpcCallbackAt" gorm:"column:ocpc_callback_at;comment:OCPC回传时间"`
	RefererUrl            string     `json:"refererUrl" gorm:"column:referer_url;type:varchar(1024);comment:访问落地页完整URL(含bd_vid)"`
	LastReportAt          time.Time  `json:"lastReportAt" gorm:"column:last_report_at;comment:最后上报时间"`
	WechatFollowedAt      *time.Time `json:"wechatFollowedAt" gorm:"column:wechat_followed_at;comment:企业微信添加时间"`
	IsClickedAssist       bool       `json:"isClickedAssist" gorm:"column:is_clicked_assist;default:false;comment:是否点击获客助手链接"`
	ClickedAssistAt       *time.Time `json:"clickedAssistAt" gorm:"column:clicked_assist_at;comment:点击获客助手时间"`
	ConversionType        string    `json:"conversionType" gorm:"column:conversion_type;type:varchar(32);comment:转化类型(多个用逗号分隔):35=微信复制 3=表单提交 49=注册转化"`
	CategoryName          string    `json:"categoryName" gorm:"-"`
	DomainName            string    `json:"domainName" gorm:"-"`
}

func (LandingVisit) TableName() string {
	return "landing_visits"
}

type LandingVisitSearch struct {
	LinkId          *uint  `json:"linkId" form:"linkId"`
	Region          string `json:"region" form:"region"`
	IsCopied         *bool  `json:"isCopied" form:"isCopied"`
	IsOcpcCallback   *bool  `json:"isOcpcCallback" form:"isOcpcCallback"`
	IsClickedAssist    *bool  `json:"isClickedAssist" form:"isClickedAssist"`
	CopiedAtStart     string `json:"copiedAtStart" form:"copiedAtStart"`
	CopiedAtEnd       string `json:"copiedAtEnd" form:"copiedAtEnd"`
	OcpcCallbackAtStart string `json:"ocpcCallbackAtStart" form:"ocpcCallbackAtStart"`
	OcpcCallbackAtEnd   string `json:"ocpcCallbackAtEnd" form:"ocpcCallbackAtEnd"`
	ClickedAssistAtStart string `json:"clickedAssistAtStart" form:"clickedAssistAtStart"`
	ClickedAssistAtEnd   string `json:"clickedAssistAtEnd" form:"clickedAssistAtEnd"`
	DomainID             *uint  `json:"domainId" form:"domainId"`
	StartTime       string `json:"startTime" form:"startTime"`
	EndTime         string `json:"endTime" form:"endTime"`
	request.PageInfo
}
