package promotion

import (
	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/response"
	"github.com/flipped-aurora/gin-vue-admin/server/model/promotion"
	requestModel "github.com/flipped-aurora/gin-vue-admin/server/model/promotion/request"
	"github.com/flipped-aurora/gin-vue-admin/server/service"
	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
)

type ContactMessageApi struct{}

var contactMessageService = service.ServiceGroupApp.PromotionServiceGroup.ContactMessageService

func (p *ContactMessageApi) CreateContactMessage(c *gin.Context) {
	var msg promotion.ContactMessage
	err := c.ShouldBindJSON(&msg)
	if err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	err = contactMessageService.CreateContactMessage(&msg)
	if err != nil {
		global.GVA_LOG.Error("提交失败!", zap.Error(err))
		response.FailWithMessage("提交失败", c)
		return
	}
	response.OkWithMessage("提交成功", c)
}

func (p *ContactMessageApi) GetContactMessageList(c *gin.Context) {
	var pageInfo promotion.ContactMessageSearch
	err := c.ShouldBindQuery(&pageInfo)
	if err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	list, total, err := contactMessageService.GetContactMessageList(pageInfo)
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

func (p *ContactMessageApi) UpdateContactMessageProcessed(c *gin.Context) {
	var req requestModel.UpdateContactMessageProcessedReq
	err := c.ShouldBindJSON(&req)
	if err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	err = contactMessageService.UpdateContactMessageProcessed(req.ID, req.IsProcessed)
	if err != nil {
		global.GVA_LOG.Error("更新失败!", zap.Error(err))
		response.FailWithMessage("更新失败", c)
		return
	}
	response.OkWithMessage("更新成功", c)
}
