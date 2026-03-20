package initialize

import (
	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/promotion"
)

func bizModel() error {
	db := global.GVA_DB
	err := db.AutoMigrate(
		promotion.RegionCategory{},
		promotion.PromotionGroup{},
		promotion.GroupMember{},
		promotion.PromotionDomain{},
		promotion.SSLCertificate{},
		promotion.DomainSSLBinding{},
		promotion.PromotionLink{},
		promotion.PromotionLinkBasic{},
		promotion.PromotionLinkCompany{},
		promotion.PromotionLinkCode{},
		promotion.PromotionLinkTheme{},
		promotion.PromotionLinkComment{},
		promotion.QAQuestion{},
		promotion.QAAnswer{},
		promotion.QAReply{},
		promotion.AdPlatform{},
		promotion.AdCampaign{},
		promotion.AdKeyword{},
		promotion.AdDailySummary{},
		promotion.ActivityMarket{},
		promotion.ActivityPackage{},
		promotion.ActivityData{},
	)
	if err != nil {
		return err
	}
	return nil
}
