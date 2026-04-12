package promotion

import (
	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/response"
	"github.com/flipped-aurora/gin-vue-admin/server/model/promotion"
	promotionReq "github.com/flipped-aurora/gin-vue-admin/server/model/promotion/request"
	"github.com/flipped-aurora/gin-vue-admin/server/service"
	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
	"time"
)

type LandingVisitApi struct{}

var landingVisitService = service.ServiceGroupApp.PromotionServiceGroup.LandingVisitService

// CreateLandingVisit 初始化上报访问信息
func (l *LandingVisitApi) CreateLandingVisit(c *gin.Context) {
	var visit promotion.LandingVisit
	err := c.ShouldBindJSON(&visit)
	if err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	visit.Ip = c.ClientIP()
	// 保存 HTTP 请求头中的数据
	visit.RequestUserAgent = c.Request.UserAgent()
	visit.RequestReferer = c.Request.Referer()
	// JSON body 中的 UserAgent 和 Referer 已经通过 ShouldBindJSON 绑定
	visit.LastReportAt = time.Now()

	err = landingVisitService.CreateLandingVisit(c.Request.Context(), &visit)
	if err != nil {
		global.GVA_LOG.Error("创建访问记录失败!", zap.Error(err))
		response.FailWithMessage("创建失败", c)
		return
	}
	response.OkWithData(visit.ID, c)
}

// ReportDuration 上报浏览时长
func (l *LandingVisitApi) ReportDuration(c *gin.Context) {
	var req promotionReq.LandingVisitDurationReport
	err := c.ShouldBindJSON(&req)
	if err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	err = landingVisitService.UpdateDuration(c.Request.Context(), req.Id, req.AddDuration)
	if err != nil {
		global.GVA_LOG.Error("更新浏览时长失败!", zap.Error(err))
		response.FailWithMessage("更新失败", c)
		return
	}
	response.OkWithMessage("上报成功", c)
}

// ReportCopy 上报复制客服信息
func (l *LandingVisitApi) ReportCopy(c *gin.Context) {
	var req promotionReq.LandingVisitCopyReport
	err := c.ShouldBindJSON(&req)
	if err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	err = landingVisitService.UpdateCopyInfo(c.Request.Context(), req.Id, req.ServicePhone, req.ServiceNickname)
	if err != nil {
		global.GVA_LOG.Error("更新复制信息失败!", zap.Error(err))
		response.FailWithMessage("更新失败", c)
		return
	}
	response.OkWithMessage("上报成功", c)
}

// GetLandingVisitList 分页查询访问记录列表
func (l *LandingVisitApi) GetLandingVisitList(c *gin.Context) {
	var pageInfo promotion.LandingVisitSearch
	err := c.ShouldBindQuery(&pageInfo)
	if err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	list, total, err := landingVisitService.GetLandingVisitList(pageInfo)
	if err != nil {
		global.GVA_LOG.Error("获取列表失败!", zap.Error(err))
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
