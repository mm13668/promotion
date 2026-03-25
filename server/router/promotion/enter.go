package promotion

import api "github.com/flipped-aurora/gin-vue-admin/server/api/v1"

type RouterGroup struct {
	RegionRouter
	LandingPhoneRouter
	LandingMessageRouter
}

var (
	promoApi = api.ApiGroupApp.PromotionApiGroup
)
