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
	VisitCount         uint                  `json:"visitCount" gorm:"comment:访问次数"`
	CopyCount          uint                  `json:"copyCount" gorm:"comment:复制次数"`
	InquiryCount       uint                  `json:"inquiryCount" gorm:"comment:咨询次数"`
	ConversionCount    uint                  `json:"conversionCount" gorm:"comment:转化次数"`
	FollowCount        uint                  `json:"followCount" gorm:"comment:到粉次数"`
	MobileUrl          string                `json:"mobileUrl" gorm:"type:varchar(255);comment:移动端推广链接"`
	PcUrl              string                `json:"pcUrl" gorm:"type:varchar(255);comment:PC端推广链接"`
	RandomCode         string                `json:"randomCode" gorm:"type:varchar(32);uniqueIndex:uk_random_code;comment:随机编号，用于静态页面路径"`
	OcpcKey            string                `json:"ocpcKey" gorm:"type:varchar(128);comment:OCPC Key"`
	OcpcSecret         string                `json:"ocpcSecret" gorm:"type:varchar(128);comment:OCPC Secret"`
	OcpcConversionType uint8                 `json:"ocpcConversionType" gorm:"comment:OCPC转化类型 1=表单提交 2=有效电话拨打 3=一句话咨询 4=订单 5=注册 6=创建角色 7=自定义"`
	OcpcCallbackType   uint8                 `json:"ocpcCallbackType" gorm:"comment:OCPC回传方式 1=手动回传 2=自动回传"`
	HttpsEnabled       bool                  `json:"httpsEnabled"`
	Sort               int                   `json:"sort"`
	Remark             string                `json:"remark" gorm:"type:varchar(255)"`
	CreatedBy          *uint                 `json:"createdBy"`
	UpdatedBy          *uint                 `json:"updatedBy"`
	Basic              *PromotionLinkBasic   `json:"basic" gorm:"-"`
	Company            *PromotionLinkCompany `json:"company" gorm:"-"`
	CodeCfg            *PromotionLinkCode    `json:"codeCfg" gorm:"-"`
	Theme              *PromotionLinkTheme   `json:"theme" gorm:"-"`
	Comment            *PromotionLinkComment `json:"comment" gorm:"-"`
}

func (PromotionLink) TableName() string {
	return "promotion_link"
}

type PromotionLinkBasic struct {
	global.GVA_MODEL
	LinkID               uint  `json:"linkId" gorm:"uniqueIndex:uk_basic_link"`
	TemplateMobileId     *uint `json:"templateMobileId" gorm:"comment:手机端模板ID（关联promotion_template_widget.id）"`
	TemplatePcId         *uint `json:"templatePcId" gorm:"comment:电脑端模板ID（关联promotion_template_widget.id）"`
	MobileCopyWidgetId   *uint `json:"mobileCopyWidgetId" gorm:"comment:手机复制插件ID（关联promotion_template_widget.id）"`
	MobileBottomWidgetId *uint `json:"mobileBottomWidgetId" gorm:"comment:手机底部插件ID（关联promotion_template_widget.id）"`
	PcQrcodeWidgetId     *uint `json:"pcQrcodeWidgetId" gorm:"comment:电脑端二维码插件ID（关联promotion_template_widget.id）"`
	Show12301Phone       bool  `json:"show12301Phone" gorm:"comment:显示12301投诉电话"`
	MobileShowQrcode     bool  `json:"mobileShowQrcode" gorm:"comment:移动端显示二维码"`
	PcShowRightQrcode    bool  `json:"pcShowRightQrcode" gorm:"comment:电脑端右侧二维码"`
	AutoDetectDevice     bool  `json:"autoDetectDevice" gorm:"comment:自动判断移动电脑端"`
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
	ColorWechatPhone string `json:"colorWechatPhone" gorm:"type:varchar(32)"`
	ColorServiceName string `json:"colorServiceName" gorm:"type:varchar(32)"`
	ColorCopyright   string `json:"colorCopyright" gorm:"type:varchar(32)"`
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

type PromotionTemplateWidget struct {
	global.GVA_MODEL
	Name string `json:"name" gorm:"type:varchar(128);comment:名称"`
	Type uint8  `json:"type" gorm:"index:idx_widget_type;comment:类型 1=手机端模板 2=电脑端模板 3=手机复制插件 4=手机底部插件 5=电脑端二维码插件"`
}

func (PromotionTemplateWidget) TableName() string {
	return "promotion_template_widget"
}
