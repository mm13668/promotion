package promotion

import (
	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/response"
	"github.com/flipped-aurora/gin-vue-admin/server/model/promotion"
	"github.com/flipped-aurora/gin-vue-admin/server/service"
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
	// 自动获取IP和UA
	landingMessage.Ip = c.ClientIP()
	landingMessage.UserAgent = c.Request.UserAgent()

	err = landingMessageService.CreateLandingMessage(&landingMessage)
	if err != nil {
		global.GVA_LOG.Error("提交失败!", zap.Error(err))
		response.FailWithMessage("提交失败", c)
		return
	}
	response.OkWithMessage("提交成功", c)
}
