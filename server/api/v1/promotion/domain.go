package promotion

import (
	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/request"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/response"
	"github.com/flipped-aurora/gin-vue-admin/server/model/promotion"
	"github.com/flipped-aurora/gin-vue-admin/server/utils"
	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
)

type DomainApi struct{}

func (a *DomainApi) CreatePromotionDomain(c *gin.Context) {
	var e promotion.PromotionDomain
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := domainService.CreatePromotionDomain(e); err != nil {
		global.GVA_LOG.Error("create failed", zap.Error(err))
		response.FailWithMessage("创建失败", c)
		return
	}
	response.OkWithMessage("创建成功", c)
}

func (a *DomainApi) DeletePromotionDomain(c *gin.Context) {
	var e promotion.PromotionDomain
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := utils.Verify(e.GVA_MODEL, utils.IdVerify); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := domainService.DeletePromotionDomain(e); err != nil {
		global.GVA_LOG.Error("delete failed", zap.Error(err))
		response.FailWithMessage("删除失败", c)
		return
	}
	response.OkWithMessage("删除成功", c)
}

func (a *DomainApi) UpdatePromotionDomain(c *gin.Context) {
	var e promotion.PromotionDomain
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := utils.Verify(e.GVA_MODEL, utils.IdVerify); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := domainService.UpdatePromotionDomain(&e); err != nil {
		global.GVA_LOG.Error("update failed", zap.Error(err))
		response.FailWithMessage("更新失败", c)
		return
	}
	response.OkWithMessage("更新成功", c)
}

func (a *DomainApi) FindPromotionDomain(c *gin.Context) {
	var e promotion.PromotionDomain
	if err := c.ShouldBindQuery(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := utils.Verify(e.GVA_MODEL, utils.IdVerify); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	data, err := domainService.FindPromotionDomain(e.ID)
	if err != nil {
		global.GVA_LOG.Error("find failed", zap.Error(err))
		response.FailWithMessage("获取失败", c)
		return
	}
	response.OkWithDetailed(gin.H{"data": data}, "获取成功", c)
}

func (a *DomainApi) GetPromotionDomainList(c *gin.Context) {
	var pageInfo request.PageInfo
	if err := c.ShouldBindQuery(&pageInfo); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := utils.Verify(pageInfo, utils.PageInfoVerify); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	list, total, err := domainService.GetPromotionDomainList(pageInfo)
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

