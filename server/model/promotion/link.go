package promotion

import "github.com/flipped-aurora/gin-vue-admin/server/global"

type PromotionLink struct {
	global.GVA_MODEL
	PlatformID uint  `json:"platformId" gorm:"index:idx_link_platform"`
	AccountID  *uint `json:"accountId"`
	RegionID   *uint `json:"regionId" gorm:"index:idx_link_region"`
	GroupID    *uint `json:"groupId" gorm:"index:idx_link_group"`
	DomainID   *uint `json:"domainId" gorm:"index:idx_link_domain"`
	QuestionID *uint `json:"questionId"`
	//TagsJSON     string                `json:"tagsJson" gorm:"type:json"`
	VisitCount   uint                  `json:"visitCount"`
	InquiryCount uint                  `json:"inquiryCount"`
	Status       uint8                 `json:"status" gorm:"index:idx_link_status"`
	HttpsEnabled bool                  `json:"httpsEnabled"`
	Sort         int                   `json:"sort"`
	Remark       string                `json:"remark" gorm:"type:varchar(255)"`
	CreatedBy    *uint                 `json:"createdBy"`
	UpdatedBy    *uint                 `json:"updatedBy"`
	Basic        *PromotionLinkBasic   `json:"basic" gorm:"-"`
	Company      *PromotionLinkCompany `json:"company" gorm:"-"`
	CodeCfg      *PromotionLinkCode    `json:"codeCfg" gorm:"-"`
	Theme        *PromotionLinkTheme   `json:"theme" gorm:"-"`
	Comment      *PromotionLinkComment `json:"comment" gorm:"-"`
}

func (PromotionLink) TableName() string {
	return "promotion_link"
}

type PromotionLinkBasic struct {
	global.GVA_MODEL
	LinkID              uint   `json:"linkId" gorm:"uniqueIndex:uk_basic_link"`
	TemplateMobileKey   string `json:"templateMobileKey" gorm:"type:varchar(64);comment:手机端模板"`
	TemplatePcKey       string `json:"templatePcKey" gorm:"type:varchar(64);comment:电脑端模板"`
	MobileCopyWidgetKey string `json:"mobileCopyWidgetKey" gorm:"type:varchar(64);comment:手机复制插件"`
	MobileBottomWidgetKey string `json:"mobileBottomWidgetKey" gorm:"type:varchar(64);comment:手机底部插件"`
	PcQrcodeWidgetKey   string `json:"pcQrcodeWidgetKey" gorm:"type:varchar(64);comment:电脑端二维码插件"`
	Show12301Phone      bool   `json:"show12301Phone" gorm:"comment:显示12301投诉电话"`
	MobileShowQrcode    bool   `json:"mobileShowQrcode" gorm:"comment:移动端显示二维码"`
	PcShowRightQrcode   bool   `json:"pcShowRightQrcode" gorm:"comment:电脑端右侧二维码"`
	AutoDetectDevice    bool   `json:"autoDetectDevice" gorm:"comment:自动判断移动电脑端"`
}

func (PromotionLinkBasic) TableName() string {
	return "promotion_link_basic"
}

type PromotionLinkCompany struct {
	global.GVA_MODEL
	LinkID        uint   `json:"linkId" gorm:"uniqueIndex:uk_company_link"`
	CompanyName   string `json:"companyName" gorm:"type:varchar(128)"`
	IcpRecordNo   string `json:"icpRecordNo" gorm:"type:varchar(64)"`
	LicenseNo     string `json:"licenseNo" gorm:"type:varchar(64)"`
	HomepageURL   string `json:"homepageUrl" gorm:"type:varchar(255)"`
	AboutURL      string `json:"aboutUrl" gorm:"type:varchar(255)"`
	LogoPcURL     string `json:"logoPcUrl" gorm:"type:varchar(255)"`
	LogoMobileURL string `json:"logoMobileUrl" gorm:"type:varchar(255)"`
}

func (PromotionLinkCompany) TableName() string {
	return "promotion_link_company"
}

type PromotionLinkCode struct {
	global.GVA_MODEL
	LinkID           uint   `json:"linkId" gorm:"uniqueIndex:uk_code_link"`
	StatHeaderHTML   string `json:"statHeaderHtml" gorm:"type:mediumtext"`
	StatFooterHTML   string `json:"statFooterHtml" gorm:"type:mediumtext"`
	ConversionScript string `json:"conversionScript" gorm:"type:mediumtext"`
	CssStyleText     string `json:"cssStyleText" gorm:"type:mediumtext"`
}

func (PromotionLinkCode) TableName() string {
	return "promotion_link_code"
}

type PromotionLinkTheme struct {
	global.GVA_MODEL
	LinkID           uint   `json:"linkId" gorm:"uniqueIndex:uk_theme_link"`
	ColorWechatPhone string `json:"colorWechatPhone" gorm:"type:varchar(16)"`
	ColorServiceName string `json:"colorServiceName" gorm:"type:varchar(16)"`
	ColorCopyright   string `json:"colorCopyright" gorm:"type:varchar(16)"`
	BoldAll          bool   `json:"boldAll"`
}

func (PromotionLinkTheme) TableName() string {
	return "promotion_link_theme"
}

type PromotionLinkComment struct {
	global.GVA_MODEL
	LinkID        uint   `json:"linkId" gorm:"uniqueIndex:uk_comment_link"`
	EnableComment bool   `json:"enableComment"`
	Permission    string `json:"permission" gorm:"type:enum('mobile_login','guest');default:'mobile_login'"`
}

func (PromotionLinkComment) TableName() string {
	return "promotion_link_comment"
}
