package promotion

import (
	"github.com/flipped-aurora/gin-vue-admin/server/middleware"
	"github.com/gin-gonic/gin"
)

type ContactMessageRouter struct{}

func (s *ContactMessageRouter) InitContactMessageRouter(PublicRouter *gin.RouterGroup, PrivateRouter *gin.RouterGroup) {
	contactMessagePublicRouter := PublicRouter.Group("promotion/contactMessage")
	{
		contactMessagePublicRouter.POST("create", middleware.ContactFormRateLimit(), promoApi.CreateContactMessage)
	}

	contactMessagePrivateRouter := PrivateRouter.Group("promotion/contactMessage")
	{
		contactMessagePrivateRouter.GET("list", promoApi.GetContactMessageList)
		contactMessagePrivateRouter.PUT("updateProcessed", promoApi.UpdateContactMessageProcessed)
	}
}
