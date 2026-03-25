package promotion

import (
	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/response"
	"github.com/flipped-aurora/gin-vue-admin/server/model/promotion"
	"github.com/flipped-aurora/gin-vue-admin/server/service"
	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
)

var landingPhoneService = service.ServiceGroupApp.PromotionServiceGroup.LandingPhoneService

// CreateLandingPhone 提交落地页手机号
// @Tags LandingPhone
// @Summary 提交落地页手机号
// @accept application/json
// @Produce application/json
// @Param data body promotion.LandingPhone true "提交落地页手机号"
// @Success 200 {object} response.Response{msg=string} "提交成功"
// @Router /promotion/landingPhone/create [post]
func (p *ApiGroup) CreateLandingPhone(c *gin.Context) {
	var landingPhone promotion.LandingPhone
	err := c.ShouldBindJSON(&landingPhone)
	if err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	// 自动获取IP和UA
	landingPhone.Ip = c.ClientIP()
	landingPhone.UserAgent = c.Request.UserAgent()

	err = landingPhoneService.CreateLandingPhone(&landingPhone)
	if err != nil {
		global.GVA_LOG.Error("提交失败!", zap.Error(err))
		response.FailWithMessage("提交失败", c)
		return
	}
	response.OkWithMessage("提交成功", c)
}
