package promotion

import "github.com/flipped-aurora/gin-vue-admin/server/service"

type ApiGroup struct {
	RegionApi
	GroupApi
	MemberApi
	DomainApi
	LinkApi
	QAApi
	AdApi
	ActivityApi
}

var (
	regionService   = service.ServiceGroupApp.PromotionServiceGroup.RegionService
	groupService    = service.ServiceGroupApp.PromotionServiceGroup.GroupService
	memberService   = service.ServiceGroupApp.PromotionServiceGroup.MemberService
	domainService   = service.ServiceGroupApp.PromotionServiceGroup.DomainService
	linkService     = service.ServiceGroupApp.PromotionServiceGroup.LinkService
	qaService       = service.ServiceGroupApp.PromotionServiceGroup.QAService
	adService       = service.ServiceGroupApp.PromotionServiceGroup.AdService
	activityService = service.ServiceGroupApp.PromotionServiceGroup.ActivityService
)
