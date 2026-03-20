package promotion

import "github.com/flipped-aurora/gin-vue-admin/server/global"

type ActivityMarket struct {
	global.GVA_MODEL
	Code    string `json:"code" gorm:"type:varchar(32);uniqueIndex:uk_market_code"`
	NameCn  string `json:"nameCn" gorm:"type:varchar(64)"`
	NameEn  string `json:"nameEn" gorm:"type:varchar(64)"`
	Status  uint8  `json:"status" gorm:"index:idx_market_status"`
	Sort    int    `json:"sort" gorm:"index:idx_market_sort"`
	Remark  string `json:"remark" gorm:"type:varchar(255)"`
}

func (ActivityMarket) TableName() string {
	return "activity_market"
}

type ActivityPackage struct {
	global.GVA_MODEL
	Name              string   `json:"name" gorm:"type:varchar(128);uniqueIndex:uk_package_name"`
	DefaultTotalAmount *float64 `json:"defaultTotalAmount" gorm:"type:decimal(14,2)"`
	Status            uint8    `json:"status" gorm:"index:idx_package_status"`
	Sort              int      `json:"sort" gorm:"index:idx_package_sort"`
	Remark            string   `json:"remark" gorm:"type:varchar(255)"`
}

func (ActivityPackage) TableName() string {
	return "activity_package"
}

type ActivityData struct {
	global.GVA_MODEL
	NameCn     string  `json:"nameCn" gorm:"type:varchar(128)"`
	NameEn     string  `json:"nameEn" gorm:"type:varchar(128)"`
	MarketID   *uint   `json:"marketId" gorm:"index:idx_activity_market"`
	TotalAmount float64 `json:"totalAmount" gorm:"type:decimal(14,2)"`
	PackageID  *uint   `json:"packageId" gorm:"index:idx_activity_package"`
	ImageURL   string  `json:"imageUrl" gorm:"type:varchar(255)"`
	Status     uint8   `json:"status" gorm:"index:idx_activity_status"`
	Sort       int     `json:"sort" gorm:"index:idx_activity_sort"`
	Remark     string  `json:"remark" gorm:"type:varchar(255)"`
	CreatedBy  *uint   `json:"createdBy"`
	UpdatedBy  *uint   `json:"updatedBy"`
}

func (ActivityData) TableName() string {
	return "activity_data"
}

