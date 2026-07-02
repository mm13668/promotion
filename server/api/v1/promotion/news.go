package promotion

import (
	"fmt"

	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/request"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/response"
	"github.com/flipped-aurora/gin-vue-admin/server/model/promotion"
	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
)

type NewsApi struct{}

func (a *NewsApi) CreateNews(c *gin.Context) {
	var e promotion.News
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := newsService.CreateNews(e); err != nil {
		global.GVA_LOG.Error("创建新闻失败", zap.Error(err))
		response.FailWithMessage("创建失败", c)
		return
	}
	response.OkWithMessage("创建成功", c)
}

func (a *NewsApi) DeleteNews(c *gin.Context) {
	var e promotion.News
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := newsService.DeleteNews(e); err != nil {
		global.GVA_LOG.Error("删除新闻失败", zap.Error(err))
		response.FailWithMessage("删除失败", c)
		return
	}
	response.OkWithMessage("删除成功", c)
}

func (a *NewsApi) UpdateNews(c *gin.Context) {
	var e promotion.News
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := newsService.UpdateNews(&e); err != nil {
		global.GVA_LOG.Error("更新新闻失败", zap.Error(err))
		response.FailWithMessage("更新失败", c)
		return
	}
	response.OkWithMessage("更新成功", c)
}

func (a *NewsApi) FindNews(c *gin.Context) {
	var e request.GetById
	if err := c.ShouldBindQuery(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	data, err := newsService.FindNewsWithCategory(uint(e.ID))
	if err != nil {
		global.GVA_LOG.Error("查询新闻失败", zap.Error(err))
		response.FailWithMessage("获取失败", c)
		return
	}
	response.OkWithDetailed(gin.H{"data": data}, "获取成功", c)
}

func (a *NewsApi) GetNewsList(c *gin.Context) {
	var pageInfo promotion.NewsSearch
	if err := c.ShouldBindQuery(&pageInfo); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	list, total, err := newsService.GetNewsList(pageInfo)
	if err != nil {
		global.GVA_LOG.Error("查询新闻列表失败", zap.Error(err))
		response.FailWithMessage("获取失败", c)
		return
	}
	response.OkWithDetailed(response.PageResult{
		List:     list,
		Total:    total,
		Page:     pageInfo.Page,
		PageSize: pageInfo.PageSize,
	}, "获取成功", c)
}

// IncrementViewCount 增加浏览次数（公开接口，供H5页面调用）
func (a *NewsApi) IncrementViewCount(c *gin.Context) {
	var e request.GetById
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	count, err := newsService.IncrementViewCount(uint(e.ID))
	if err != nil {
		global.GVA_LOG.Error("增加浏览次数失败", zap.Error(err))
		response.FailWithMessage("操作失败", c)
		return
	}
	response.OkWithDetailed(gin.H{"viewCount": count}, "ok", c)
}

// BatchPublishNews 一键重新发布所有已发布的新闻
func (a *NewsApi) BatchPublishNews(c *gin.Context) {
	success, failed, err := newsService.BatchPublishNews()
	if err != nil {
		global.GVA_LOG.Error("批量发布新闻失败", zap.Error(err))
		response.FailWithMessage("批量发布失败："+err.Error(), c)
		return
	}
	response.OkWithDetailed(gin.H{
		"success": success,
		"failed":  failed,
	}, fmt.Sprintf("批量发布完成：成功 %d 条，失败 %d 条", success, failed), c)
}

// PublishNewsCenter 生成新闻中心页面
func (a *NewsApi) PublishNewsCenter(c *gin.Context) {
	publishedPath, err := newsService.PublishNewsCenter()
	if err != nil {
		global.GVA_LOG.Error("生成新闻中心失败", zap.Error(err))
		response.FailWithMessage("生成失败："+err.Error(), c)
		return
	}
	response.OkWithDetailed(gin.H{"publishedPath": publishedPath}, "生成成功", c)
}

// PublishNews 发布新闻，生成静态HTML页面
func (a *NewsApi) PublishNews(c *gin.Context) {
	var e request.GetById
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	publishedPath, err := newsService.PublishNews(uint(e.ID))
	if err != nil {
		global.GVA_LOG.Error("发布新闻失败", zap.Error(err))
		response.FailWithMessage("发布失败："+err.Error(), c)
		return
	}
	response.OkWithDetailed(gin.H{"publishedPath": publishedPath}, "发布成功", c)
}


