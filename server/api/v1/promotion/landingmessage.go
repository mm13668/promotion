package promotion

import (
	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/response"
	"github.com/flipped-aurora/gin-vue-admin/server/model/promotion"
	"github.com/flipped-aurora/gin-vue-admin/server/service"
	"github.com/flipped-aurora/gin-vue-admin/server/utils"
	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
)

var landingMessageService = service.ServiceGroupApp.PromotionServiceGroup.LandingMessageService

// CreateLandingMessage 提交落地页留言
// @Tags LandingMessage
// @Summary 提交落地页留言
// @accept application/json
// @Produce application/json
// @Param data body promotion.LandingMessage true "提交落地页留言"
// @Success 200 {object} response.Response{msg=string} "提交成功"
// @Router /promotion/landingMessage/create [post]
func (p *ApiGroup) CreateLandingMessage(c *gin.Context) {
	var landingMessage promotion.LandingMessage
	err := c.ShouldBindJSON(&landingMessage)
	if err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	// 自动获取IP、UA和访问链接
	landingMessage.Ip = utils.GetClientIP(c)
	landingMessage.UserAgent = c.Request.UserAgent()
	landingMessage.LinkUrl = c.Request.Header.Get("Referer")

	err = landingMessageService.CreateLandingMessage(&landingMessage)
	if err != nil {
		global.GVA_LOG.Error("提交失败!", zap.Error(err))
		response.FailWithMessage("提交失败", c)
		return
	}
	response.OkWithMessage("提交成功", c)
}

// GetLandingMessageList 获取落地页留言列表
// @Tags LandingMessage
// @Summary 获取落地页留言列表
// @accept application/json
// @Produce application/json
// @Param linkId query string false "推广链接ID"
// @Param ip query string false "IP地址"
// @Param phone query string false "手机号"
// @Param startTime query string false "开始时间"
// @Param endTime query string false "结束时间"
// @Param page query int false "页码"
// @Param pageSize query int false "每页数量"
// @Success 200 {object} response.Response{data=response.PageResult{list=[]promotion.LandingMessage,total=int}} "获取成功"
// @Router /promotion/landingMessage/list [get]
func (p *ApiGroup) GetLandingMessageList(c *gin.Context) {
	var pageInfo promotion.LandingMessageSearch
	err := c.ShouldBindQuery(&pageInfo)
	if err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	list, total, err := landingMessageService.GetLandingMessageList(pageInfo)
	if err != nil {
		global.GVA_LOG.Error("获取失败!", zap.Error(err))
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

// UpdateLandingMessageProcessed 更新留言处理状态
// @Tags LandingMessage
// @Summary 更新留言处理状态
// @accept application/json
// @Produce application/json
// @Param data body promotion.LandingMessage true "更新留言处理状态"
// @Success 200 {object} response.Response{msg=string} "更新成功"
// @Router /promotion/landingMessage/updateProcessed [put]
func (p *ApiGroup) UpdateLandingMessageProcessed(c *gin.Context) {
	var req struct {
		ID        uint `json:"id"`
		Processed bool `json:"processed"`
	}
	err := c.ShouldBindJSON(&req)
	if err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	err = landingMessageService.UpdateLandingMessageProcessed(req.ID, req.Processed)
	if err != nil {
		global.GVA_LOG.Error("更新失败!", zap.Error(err))
		response.FailWithMessage("更新失败", c)
		return
	}
	response.OkWithMessage("更新成功", c)
}

// BatchUpdateLandingMessageProcessed 批量更新留言处理状态
// @Tags LandingMessage
// @Summary 批量更新留言处理状态
// @accept application/json
// @Produce application/json
// @Param data body promotion.BatchProcessedReq true "批量更新留言处理状态"
// @Success 200 {object} response.Response{msg=string} "更新成功"
// @Router /promotion/landingMessage/batchUpdateProcessed [put]
func (p *ApiGroup) BatchUpdateLandingMessageProcessed(c *gin.Context) {
	var req promotion.BatchProcessedReq
	err := c.ShouldBindJSON(&req)
	if err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if len(req.IDs) == 0 {
		response.FailWithMessage("请选择留言", c)
		return
	}
	err = landingMessageService.BatchUpdateLandingMessageProcessed(req.IDs, req.Processed)
	if err != nil {
		global.GVA_LOG.Error("批量更新失败!", zap.Error(err))
		response.FailWithMessage("批量更新失败", c)
		return
	}
	response.OkWithMessage("更新成功", c)
}

// MarkAllLandingMessageProcessed 全部标记为已处理/未处理
// @Tags LandingMessage
// @Summary 全部标记为已处理/未处理
// @accept application/json
// @Produce application/json
// @Param data body promotion.AllProcessedReq true "全部标记"
// @Success 200 {object} response.Response{msg=string} "操作成功"
// @Router /promotion/landingMessage/markAllProcessed [put]
func (p *ApiGroup) MarkAllLandingMessageProcessed(c *gin.Context) {
	var req promotion.AllProcessedReq
	err := c.ShouldBindJSON(&req)
	if err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if req.LinkID == "" {
		response.FailWithMessage("链接ID不能为空", c)
		return
	}
	err = landingMessageService.MarkAllLandingMessageProcessed(req.LinkID, req.Processed)
	if err != nil {
		global.GVA_LOG.Error("操作失败!", zap.Error(err))
		response.FailWithMessage("操作失败", c)
		return
	}
	response.OkWithMessage("操作成功", c)
}

// GetUnprocessedMessageCount 获取未处理留言数量
// @Tags LandingMessage
// @Summary 获取未处理留言数量
// @accept application/json
// @Produce application/json
// @Param linkId query string true "推广链接ID"
// @Success 200 {object} response.Response{data=int64} "获取成功"
// @Router /promotion/landingMessage/unprocessedCount [get]
func (p *ApiGroup) GetUnprocessedMessageCount(c *gin.Context) {
	linkID := c.Query("linkId")
	if linkID == "" {
		response.FailWithMessage("链接ID不能为空", c)
		return
	}
	count, err := landingMessageService.GetUnprocessedMessageCount(linkID)
	if err != nil {
		global.GVA_LOG.Error("获取失败!", zap.Error(err))
		response.FailWithMessage("获取失败", c)
		return
	}
	response.OkWithDetailed(count, "获取成功", c)
}
