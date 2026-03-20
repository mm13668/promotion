package promotion

import "github.com/flipped-aurora/gin-vue-admin/server/global"

type AdPlatform struct {
	global.GVA_MODEL
	PlatformKey string `json:"platformKey" gorm:"type:varchar(32);uniqueIndex:uk_platform_key"`
	Name        string `json:"name" gorm:"type:varchar(64)"`
	Status      uint8  `json:"status" gorm:"index:idx_platform_status"`
	Remark      string `json:"remark" gorm:"type:varchar(255)"`
}

func (AdPlatform) TableName() string {
	return "ad_platform"
}

type AdCampaign struct {
	global.GVA_MODEL
	PlatformID   uint   `json:"platformId"`
	LinkID       *uint  `json:"linkId"`
	CampaignCode string `json:"campaignCode" gorm:"type:varchar(64)"`
	CampaignName string `json:"campaignName" gorm:"type:varchar(128)"`
	AccountName  string `json:"accountName" gorm:"type:varchar(128)"`
	RegionID     *uint  `json:"regionId"`
	GroupID      *uint  `json:"groupId"`
	Status       uint8  `json:"status" gorm:"index:idx_campaign_status"`
	Remark       string `json:"remark" gorm:"type:varchar(255)"`
}

func (AdCampaign) TableName() string {
	return "ad_campaign"
}

type AdKeyword struct {
	global.GVA_MODEL
	CampaignID uint   `json:"campaignId" gorm:"index:idx_keyword_campaign"`
	Keyword    string `json:"keyword" gorm:"type:varchar(128)"`
	MatchType  string `json:"matchType" gorm:"type:enum('exact','phrase','broad','negative');default:'broad'"`
	LandingURL string `json:"landingUrl" gorm:"type:varchar(255)"`
	Ocpc       bool   `json:"ocpc"`
	Status     uint8  `json:"status" gorm:"index:idx_keyword_status"`
	Remark     string `json:"remark" gorm:"type:varchar(255)"`
}

func (AdKeyword) TableName() string {
	return "ad_keyword"
}

type AdDailySummary struct {
	global.GVA_MODEL
	SummaryDate string `json:"summaryDate" gorm:"type:date"`
	PlatformID  uint   `json:"platformId"`
	CampaignID  *uint  `json:"campaignId"`
	KeywordID   *uint  `json:"keywordId"`
	LinkID      *uint  `json:"linkId"`
	RegionID    *uint  `json:"regionId"`
	DeviceType  string `json:"deviceType" gorm:"type:enum('pc','mobile','tablet','other');default:'other'"`
	Impressions uint   `json:"impressions"`
	Clicks      uint   `json:"clicks"`
	UniqueIps   uint   `json:"uniqueIps"`
	Uv          uint   `json:"uv"`
	Pv          uint   `json:"pv"`
	Calls       uint   `json:"calls"`
	Leads       uint   `json:"leads"`
	Conversions uint   `json:"conversions"`
	Cost        float64 `json:"cost" gorm:"type:decimal(14,2)"`
	AvgRank     *float64 `json:"avgRank" gorm:"type:decimal(6,2)"`
	Ocpc        bool   `json:"ocpc"`
}

func (AdDailySummary) TableName() string {
	return "ad_daily_summary"
}

