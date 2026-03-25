package promotion

import (
	"github.com/gin-gonic/gin"
)

type LandingPhoneRouter struct{}

func (s *LandingPhoneRouter) InitLandingPhoneRouter(PublicRouter *gin.RouterGroup) {
	// 公开接口，不需要认证
	landingPhonePublicRouter := PublicRouter.Group("promotion/landingPhone")
	{
		landingPhonePublicRouter.POST("create", promoApi.CreateLandingPhone)
	}
}
