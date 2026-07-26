package promotion

import (
	"github.com/flipped-aurora/gin-vue-admin/server/middleware"
	"github.com/gin-gonic/gin"
)

type NewsRouter struct{}

func (s *NewsRouter) InitNewsRouter(Router *gin.RouterGroup) {
	newsRouter := Router.Group("promotion").Use(middleware.OperationRecord())
	{
		newsRouter.POST("createNews", promoApi.NewsApi.CreateNews)
		newsRouter.DELETE("deleteNews", promoApi.NewsApi.DeleteNews)
		newsRouter.PUT("updateNews", promoApi.NewsApi.UpdateNews)
		newsRouter.GET("findNews", promoApi.NewsApi.FindNews)
		newsRouter.GET("getNewsList", promoApi.NewsApi.GetNewsList)
		newsRouter.POST("publishNews", promoApi.NewsApi.PublishNews)
		newsRouter.POST("batchPublishNews", promoApi.NewsApi.BatchPublishNews)
		newsRouter.POST("publishNewsCenter", promoApi.NewsApi.PublishNewsCenter)
		newsRouter.POST("submitToBaidu", promoApi.NewsApi.SubmitToBaidu)
		// 新闻分类
		newsRouter.POST("createNewsCategory", promoApi.NewsCategoryApi.Create)
		newsRouter.DELETE("deleteNewsCategory", promoApi.NewsCategoryApi.Delete)
		newsRouter.PUT("updateNewsCategory", promoApi.NewsCategoryApi.Update)
		newsRouter.GET("findNewsCategory", promoApi.NewsCategoryApi.Find)
		newsRouter.GET("getNewsCategoryList", promoApi.NewsCategoryApi.GetList)
		newsRouter.GET("getAllEnabledNewsCategories", promoApi.NewsCategoryApi.GetAllEnabledCategories)
	}
}

// InitNewsPublicRouter 公开的新闻路由（无需认证）
func (s *NewsRouter) InitNewsPublicRouter(publicRouter *gin.RouterGroup) {
	newsPublic := publicRouter.Group("promotion")
	{
		newsPublic.POST("incrementNewsViewCount", promoApi.NewsApi.IncrementViewCount)
	}
}
