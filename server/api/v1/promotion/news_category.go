package promotion

import (
	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/request"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/response"
	"github.com/flipped-aurora/gin-vue-admin/server/model/promotion"
	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
)

type NewsCategoryApi struct{}

func (a *NewsCategoryApi) Create(c *gin.Context) {
	var e promotion.NewsCategory
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := newsCategoryService.Create(e); err != nil {
		global.GVA_LOG.Error("创建分类失败", zap.Error(err))
		response.FailWithMessage("创建失败", c)
		return
	}
	response.OkWithMessage("创建成功", c)
}

func (a *NewsCategoryApi) Delete(c *gin.Context) {
	var e promotion.NewsCategory
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := newsCategoryService.Delete(e); err != nil {
		global.GVA_LOG.Error("删除分类失败", zap.Error(err))
		response.FailWithMessage("删除失败", c)
		return
	}
	response.OkWithMessage("删除成功", c)
}

func (a *NewsCategoryApi) Update(c *gin.Context) {
	var e promotion.NewsCategory
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := newsCategoryService.Update(&e); err != nil {
		global.GVA_LOG.Error("更新分类失败", zap.Error(err))
		response.FailWithMessage("更新失败", c)
		return
	}
	response.OkWithMessage("更新成功", c)
}

func (a *NewsCategoryApi) Find(c *gin.Context) {
	var e request.GetById
	if err := c.ShouldBindQuery(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	data, err := newsCategoryService.Find(uint(e.ID))
	if err != nil {
		global.GVA_LOG.Error("查询分类失败", zap.Error(err))
		response.FailWithMessage("获取失败", c)
		return
	}
	response.OkWithDetailed(gin.H{"data": data}, "获取成功", c)
}

func (a *NewsCategoryApi) GetList(c *gin.Context) {
	var pageInfo promotion.NewsCategorySearch
	if err := c.ShouldBindQuery(&pageInfo); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	list, total, err := newsCategoryService.GetList(pageInfo)
	if err != nil {
		global.GVA_LOG.Error("查询分类列表失败", zap.Error(err))
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

// GetAllEnabledCategories 获取所有启用的分类（供下拉选择）
func (a *NewsCategoryApi) GetAllEnabledCategories(c *gin.Context) {
	list, err := newsCategoryService.GetAllEnabled()
	if err != nil {
		global.GVA_LOG.Error("获取分类列表失败", zap.Error(err))
		response.FailWithMessage("获取失败", c)
		return
	}
	response.OkWithDetailed(gin.H{"categories": list}, "获取成功", c)
}
