package promotion

import (
	"github.com/gin-gonic/gin"
)

type LandingVisitRouter struct{}

func (s *LandingVisitRouter) InitLandingVisitRouter(PublicRouter *gin.RouterGroup, PrivateRouter *gin.RouterGroup) {
	// 公开接口，不需要认证
	landingVisitPublicRouter := PublicRouter.Group("promotion/landingVisit")
	{
		landingVisitPublicRouter.POST("init", promoApi.CreateLandingVisit)
		landingVisitPublicRouter.POST("reportDuration", promoApi.ReportDuration)
		landingVisitPublicRouter.POST("reportCopy", promoApi.ReportCopy)
	}

	// 管理后台接口，需要认证
	landingVisitPrivateRouter := PrivateRouter.Group("promotion/landingVisit")
	{
		landingVisitPrivateRouter.GET("list", promoApi.GetLandingVisitList)
	}
}
