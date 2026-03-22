package promotion

import (
	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/request"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/response"
	"github.com/flipped-aurora/gin-vue-admin/server/model/promotion"
	promoService "github.com/flipped-aurora/gin-vue-admin/server/service/promotion"
	"github.com/flipped-aurora/gin-vue-admin/server/utils"
	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
)

type LinkApi struct{}

func (a *LinkApi) CreatePromotionLink(c *gin.Context) {
	var e promotion.PromotionLink
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := linkService.CreatePromotionLink(e); err != nil {
		global.GVA_LOG.Error("create failed", zap.Error(err))
		response.FailWithMessage("创建失败", c)
		return
	}
	response.OkWithMessage("创建成功", c)
}

func (a *LinkApi) DeletePromotionLink(c *gin.Context) {
	var e promotion.PromotionLink
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := utils.Verify(e.GVA_MODEL, utils.IdVerify); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := linkService.DeletePromotionLink(e); err != nil {
		global.GVA_LOG.Error("delete failed", zap.Error(err))
		response.FailWithMessage("删除失败", c)
		return
	}
	response.OkWithMessage("删除成功", c)
}

func (a *LinkApi) UpdatePromotionLink(c *gin.Context) {
	var e promotion.PromotionLink
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := utils.Verify(e.GVA_MODEL, utils.IdVerify); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := linkService.UpdatePromotionLink(&e); err != nil {
		global.GVA_LOG.Error("update failed", zap.Error(err))
		response.FailWithMessage("更新失败", c)
		return
	}
	response.OkWithMessage("更新成功", c)
}

func (a *LinkApi) FindPromotionLink(c *gin.Context) {
	var e promotion.PromotionLink
	if err := c.ShouldBindQuery(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := utils.Verify(e.GVA_MODEL, utils.IdVerify); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	data, err := linkService.FindPromotionLink(e.ID)
	if err != nil {
		global.GVA_LOG.Error("find failed", zap.Error(err))
		response.FailWithMessage("获取失败", c)
		return
	}
	response.OkWithDetailed(gin.H{"data": data}, "获取成功", c)
}

func (a *LinkApi) GetPromotionLinkList(c *gin.Context) {
	var pageInfo request.PageInfo
	if err := c.ShouldBindQuery(&pageInfo); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := utils.Verify(pageInfo, utils.PageInfoVerify); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	var q struct {
		PlatformID *uint `form:"platformId"`
		RegionID   *uint `form:"regionId"`
		GroupID    *uint `form:"groupId"`
		DomainID   *uint `form:"domainId"`
	}
	_ = c.ShouldBindQuery(&q)
	list, total, err := linkService.GetPromotionLinkList(pageInfo, promoService.LinkFilter{
		PlatformID: q.PlatformID,
		RegionID:   q.RegionID,
		GroupID:    q.GroupID,
		DomainID:   q.DomainID,
	})
	if err != nil {
		global.GVA_LOG.Error("list failed", zap.Error(err))
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

func (a *LinkApi) UpsertBasic(c *gin.Context) {
	var e promotion.PromotionLinkBasic
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := linkService.UpsertBasic(&e); err != nil {
		global.GVA_LOG.Error("save failed", zap.Error(err))
		response.FailWithMessage("保存失败", c)
		return
	}
	response.OkWithMessage("保存成功", c)
}
func (a *LinkApi) GetBasic(c *gin.Context) {
	var q struct {
		LinkID uint `form:"linkId"`
	}
	if err := c.ShouldBindQuery(&q); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	data, err := linkService.GetBasic(q.LinkID)
	if err != nil {
		response.FailWithMessage("获取失败", c)
		return
	}
	response.OkWithDetailed(gin.H{"data": data}, "获取成功", c)
}

func (a *LinkApi) UpsertCompany(c *gin.Context) {
	var e promotion.PromotionLinkCompany
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := linkService.UpsertCompany(&e); err != nil {
		global.GVA_LOG.Error("save failed", zap.Error(err))
		response.FailWithMessage("保存失败", c)
		return
	}
	response.OkWithMessage("保存成功", c)
}
func (a *LinkApi) GetCompany(c *gin.Context) {
	var q struct {
		LinkID uint `form:"linkId"`
	}
	if err := c.ShouldBindQuery(&q); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	data, err := linkService.GetCompany(q.LinkID)
	if err != nil {
		response.FailWithMessage("获取失败", c)
		return
	}
	response.OkWithDetailed(gin.H{"data": data}, "获取成功", c)
}

func (a *LinkApi) UpsertCode(c *gin.Context) {
	var e promotion.PromotionLinkCode
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := linkService.UpsertCode(&e); err != nil {
		global.GVA_LOG.Error("save failed", zap.Error(err))
		response.FailWithMessage("保存失败", c)
		return
	}
	response.OkWithMessage("保存成功", c)
}
func (a *LinkApi) GetCode(c *gin.Context) {
	var q struct {
		LinkID uint `form:"linkId"`
	}
	if err := c.ShouldBindQuery(&q); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	data, err := linkService.GetCode(q.LinkID)
	if err != nil {
		response.FailWithMessage("获取失败", c)
		return
	}
	response.OkWithDetailed(gin.H{"data": data}, "获取成功", c)
}

func (a *LinkApi) UpsertTheme(c *gin.Context) {
	var e promotion.PromotionLinkTheme
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := linkService.UpsertTheme(&e); err != nil {
		global.GVA_LOG.Error("save failed", zap.Error(err))
		response.FailWithMessage("保存失败", c)
		return
	}
	response.OkWithMessage("保存成功", c)
}
func (a *LinkApi) GetTheme(c *gin.Context) {
	var q struct {
		LinkID uint `form:"linkId"`
	}
	if err := c.ShouldBindQuery(&q); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	data, err := linkService.GetTheme(q.LinkID)
	if err != nil {
		response.FailWithMessage("获取失败", c)
		return
	}
	response.OkWithDetailed(gin.H{"data": data}, "获取成功", c)
}

func (a *LinkApi) UpsertComment(c *gin.Context) {
	var e promotion.PromotionLinkComment
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := linkService.UpsertComment(&e); err != nil {
		global.GVA_LOG.Error("save failed", zap.Error(err))
		response.FailWithMessage("保存失败", c)
		return
	}
	response.OkWithMessage("保存成功", c)
}
func (a *LinkApi) GetComment(c *gin.Context) {
	var q struct {
		LinkID uint `form:"linkId"`
	}
	if err := c.ShouldBindQuery(&q); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	data, err := linkService.GetComment(q.LinkID)
	if err != nil {
		response.FailWithMessage("获取失败", c)
		return
	}
	response.OkWithDetailed(gin.H{"data": data}, "获取成功", c)
}

// PublishPromotionLink 发布推广链接，生成移动端和PC端页面
func (a *LinkApi) PublishPromotionLink(c *gin.Context) {
	var e promotion.PromotionLink
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := utils.Verify(e.GVA_MODEL, utils.IdVerify); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := linkService.PublishPromotionLink(e.ID); err != nil {
		global.GVA_LOG.Error("publish failed", zap.Error(err))
		response.FailWithMessage("发布失败", c)
		return
	}
	response.OkWithMessage("发布成功", c)
}

// UpdatePromotionLinkOcpc 更新OCPC配置
func (a *LinkApi) UpdatePromotionLinkOcpc(c *gin.Context) {
	var e promotion.PromotionLink
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := utils.Verify(e.GVA_MODEL, utils.IdVerify); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	// 先查询已有记录，避免覆盖其他字段
	exist, err := linkService.FindPromotionLink(e.ID)
	if err != nil {
		global.GVA_LOG.Error("find link failed", zap.Error(err))
		response.FailWithMessage("推广链接不存在", c)
		return
	}
	// 只更新OCPC相关字段
	exist.OcpcKey = e.OcpcKey
	exist.OcpcSecret = e.OcpcSecret
	exist.OcpcConversionType = e.OcpcConversionType
	exist.OcpcCallbackType = e.OcpcCallbackType
	if err := linkService.UpdatePromotionLink(&exist); err != nil {
		global.GVA_LOG.Error("update ocpc failed", zap.Error(err))
		response.FailWithMessage("OCPC配置更新失败", c)
		return
	}
	response.OkWithMessage("OCPC配置保存成功", c)
}

// 模板插件管理API
func (a *LinkApi) CreateTemplateWidget(c *gin.Context) {
	var e promotion.PromotionTemplateWidget
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := linkService.CreateTemplateWidget(e); err != nil {
		global.GVA_LOG.Error("create failed", zap.Error(err))
		response.FailWithMessage("创建失败", c)
		return
	}
	response.OkWithMessage("创建成功", c)
}

func (a *LinkApi) DeleteTemplateWidget(c *gin.Context) {
	var e promotion.PromotionTemplateWidget
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := utils.Verify(e.GVA_MODEL, utils.IdVerify); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := linkService.DeleteTemplateWidget(e); err != nil {
		global.GVA_LOG.Error("delete failed", zap.Error(err))
		response.FailWithMessage("删除失败", c)
		return
	}
	response.OkWithMessage("删除成功", c)
}

func (a *LinkApi) UpdateTemplateWidget(c *gin.Context) {
	var e promotion.PromotionTemplateWidget
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := utils.Verify(e.GVA_MODEL, utils.IdVerify); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := linkService.UpdateTemplateWidget(&e); err != nil {
		global.GVA_LOG.Error("update failed", zap.Error(err))
		response.FailWithMessage("更新失败", c)
		return
	}
	response.OkWithMessage("更新成功", c)
}

func (a *LinkApi) FindTemplateWidget(c *gin.Context) {
	var e promotion.PromotionTemplateWidget
	if err := c.ShouldBindQuery(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := utils.Verify(e.GVA_MODEL, utils.IdVerify); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	data, err := linkService.FindTemplateWidget(e.ID)
	if err != nil {
		global.GVA_LOG.Error("find failed", zap.Error(err))
		response.FailWithMessage("获取失败", c)
		return
	}
	response.OkWithDetailed(gin.H{"data": data}, "获取成功", c)
}

func (a *LinkApi) GetTemplateWidgetList(c *gin.Context) {
	var pageInfo request.PageInfo
	if err := c.ShouldBindQuery(&pageInfo); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := utils.Verify(pageInfo, utils.PageInfoVerify); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	var q struct {
		Type *uint8 `form:"type"`
	}
	_ = c.ShouldBindQuery(&q)
	list, total, err := linkService.GetTemplateWidgetList(pageInfo, promoService.TemplateWidgetFilter{
		Type: q.Type,
	})
	if err != nil {
		global.GVA_LOG.Error("list failed", zap.Error(err))
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
