package promotion

import (
	"github.com/gin-gonic/gin"
)

type LandingMessageRouter struct{}

func (s *LandingMessageRouter) InitLandingMessageRouter(PublicRouter *gin.RouterGroup) {
	// 公开接口，不需要认证
	landingMessagePublicRouter := PublicRouter.Group("promotion/landingMessage")
	{
		landingMessagePublicRouter.POST("create", promoApi.CreateLandingMessage)
	}
}
