package promotion

import (
	"github.com/flipped-aurora/gin-vue-admin/server/middleware"
	"github.com/gin-gonic/gin"
)

type RegionRouter struct{}

func (r *RegionRouter) InitRegionRouter(Router *gin.RouterGroup) {
	group := Router.Group("promotion").Use(middleware.OperationRecord())
	{
		group.POST("createPromotionLink", promoApi.LinkApi.CreatePromotionLink)
		group.DELETE("deletePromotionLink", promoApi.LinkApi.DeletePromotionLink)
		group.PUT("updatePromotionLink", promoApi.LinkApi.UpdatePromotionLink)
		group.GET("findPromotionLink", promoApi.LinkApi.FindPromotionLink)
		group.GET("getPromotionLinkList", promoApi.LinkApi.GetPromotionLinkList)
		group.POST("upsertLinkBasic", promoApi.LinkApi.UpsertBasic)
		group.GET("getLinkBasic", promoApi.LinkApi.GetBasic)
		group.POST("upsertLinkCompany", promoApi.LinkApi.UpsertCompany)
		group.GET("getLinkCompany", promoApi.LinkApi.GetCompany)
		group.POST("upsertLinkCode", promoApi.LinkApi.UpsertCode)
		group.GET("getLinkCode", promoApi.LinkApi.GetCode)
		group.POST("upsertLinkTheme", promoApi.LinkApi.UpsertTheme)
		group.GET("getLinkTheme", promoApi.LinkApi.GetTheme)
		group.POST("upsertLinkComment", promoApi.LinkApi.UpsertComment)
		group.GET("getLinkComment", promoApi.LinkApi.GetComment)

		group.POST("createQAQuestion", promoApi.QAApi.CreateQuestion)
		group.PUT("updateQAQuestion", promoApi.QAApi.UpdateQuestion)
		group.DELETE("deleteQAQuestion", promoApi.QAApi.DeleteQuestion)
		group.GET("getQAQuestionList", promoApi.QAApi.GetQuestionList)
		group.POST("createQAAnswer", promoApi.QAApi.CreateAnswer)
		group.PUT("updateQAAnswer", promoApi.QAApi.UpdateAnswer)
		group.DELETE("deleteQAAnswer", promoApi.QAApi.DeleteAnswer)
		group.GET("getQAAnswerList", promoApi.QAApi.GetAnswerList)
		group.POST("createQAReply", promoApi.QAApi.CreateReply)
		group.PUT("updateQAReply", promoApi.QAApi.UpdateReply)
		group.DELETE("deleteQAReply", promoApi.QAApi.DeleteReply)
		group.GET("getQAReplyList", promoApi.QAApi.GetReplyList)

		group.POST("createAdPlatform", promoApi.AdApi.CreatePlatform)
		group.PUT("updateAdPlatform", promoApi.AdApi.UpdatePlatform)
		group.DELETE("deleteAdPlatform", promoApi.AdApi.DeletePlatform)
		group.GET("getAdPlatformList", promoApi.AdApi.GetPlatformList)
		group.POST("createAdCampaign", promoApi.AdApi.CreateCampaign)
		group.PUT("updateAdCampaign", promoApi.AdApi.UpdateCampaign)
		group.DELETE("deleteAdCampaign", promoApi.AdApi.DeleteCampaign)
		group.GET("getAdCampaignList", promoApi.AdApi.GetCampaignList)
		group.POST("createAdKeyword", promoApi.AdApi.CreateKeyword)
		group.PUT("updateAdKeyword", promoApi.AdApi.UpdateKeyword)
		group.DELETE("deleteAdKeyword", promoApi.AdApi.DeleteKeyword)
		group.GET("getAdKeywordList", promoApi.AdApi.GetKeywordList)
		group.GET("getAdDailySummaryList", promoApi.AdApi.GetDailySummaryList)

		group.POST("createActivityMarket", promoApi.ActivityApi.CreateMarket)
		group.PUT("updateActivityMarket", promoApi.ActivityApi.UpdateMarket)
		group.DELETE("deleteActivityMarket", promoApi.ActivityApi.DeleteMarket)
		group.GET("getActivityMarketList", promoApi.ActivityApi.GetMarketList)
		group.POST("createActivityPackage", promoApi.ActivityApi.CreatePackage)
		group.PUT("updateActivityPackage", promoApi.ActivityApi.UpdatePackage)
		group.DELETE("deleteActivityPackage", promoApi.ActivityApi.DeletePackage)
		group.GET("getActivityPackageList", promoApi.ActivityApi.GetPackageList)
		group.POST("createActivityData", promoApi.ActivityApi.CreateActivity)
		group.PUT("updateActivityData", promoApi.ActivityApi.UpdateActivity)
		group.DELETE("deleteActivityData", promoApi.ActivityApi.DeleteActivity)
		group.GET("getActivityDataList", promoApi.ActivityApi.GetActivityList)

		group.POST("createRegionCategory", promoApi.RegionApi.CreateRegionCategory)
		group.DELETE("deleteRegionCategory", promoApi.RegionApi.DeleteRegionCategory)
		group.PUT("updateRegionCategory", promoApi.RegionApi.UpdateRegionCategory)
		group.GET("findRegionCategory", promoApi.RegionApi.FindRegionCategory)
		group.GET("getRegionCategoryList", promoApi.RegionApi.GetRegionCategoryList)

		group.POST("createPromotionGroup", promoApi.GroupApi.CreatePromotionGroup)
		group.DELETE("deletePromotionGroup", promoApi.GroupApi.DeletePromotionGroup)
		group.PUT("updatePromotionGroup", promoApi.GroupApi.UpdatePromotionGroup)
		group.GET("findPromotionGroup", promoApi.GroupApi.FindPromotionGroup)
		group.GET("getPromotionGroupList", promoApi.GroupApi.GetPromotionGroupList)

		group.POST("createGroupMember", promoApi.MemberApi.CreateGroupMember)
		group.DELETE("deleteGroupMember", promoApi.MemberApi.DeleteGroupMember)
		group.PUT("updateGroupMember", promoApi.MemberApi.UpdateGroupMember)
		group.GET("findGroupMember", promoApi.MemberApi.FindGroupMember)
		group.GET("getGroupMemberList", promoApi.MemberApi.GetGroupMemberList)

		group.POST("createPromotionDomain", promoApi.DomainApi.CreatePromotionDomain)
		group.DELETE("deletePromotionDomain", promoApi.DomainApi.DeletePromotionDomain)
		group.PUT("updatePromotionDomain", promoApi.DomainApi.UpdatePromotionDomain)
		group.GET("findPromotionDomain", promoApi.DomainApi.FindPromotionDomain)
		group.GET("getPromotionDomainList", promoApi.DomainApi.GetPromotionDomainList)
	}
}
