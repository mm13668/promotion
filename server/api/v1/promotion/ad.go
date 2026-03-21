package promotion

import (
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/request"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/response"
	"github.com/flipped-aurora/gin-vue-admin/server/model/promotion"
	promoSvc "github.com/flipped-aurora/gin-vue-admin/server/service/promotion"
	"github.com/flipped-aurora/gin-vue-admin/server/utils"
	"github.com/gin-gonic/gin"
)

type AdApi struct{}

func (a *AdApi) CreatePlatform(c *gin.Context) {
	var e promotion.AdPlatform
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := adService.CreatePlatform(e); err != nil {
		response.FailWithMessage("创建失败", c)
		return
	}
	response.OkWithMessage("创建成功", c)
}
func (a *AdApi) UpdatePlatform(c *gin.Context) {
	var e promotion.AdPlatform
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := adService.UpdatePlatform(&e); err != nil {
		response.FailWithMessage("更新失败", c)
		return
	}
	response.OkWithMessage("更新成功", c)
}
func (a *AdApi) DeletePlatform(c *gin.Context) {
	var e promotion.AdPlatform
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := adService.DeletePlatform(e); err != nil {
		response.FailWithMessage("删除失败", c)
		return
	}
	response.OkWithMessage("删除成功", c)
}
func (a *AdApi) GetPlatformList(c *gin.Context) {
	var pageInfo request.PageInfo
	if err := c.ShouldBindQuery(&pageInfo); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	list, total, err := adService.GetPlatformList(pageInfo)
	if err != nil {
		response.FailWithMessage("获取失败", c)
		return
	}
	response.OkWithDetailed(response.PageResult{List: list, Total: total, Page: pageInfo.Page, PageSize: pageInfo.PageSize}, "获取成功", c)
}

func (a *AdApi) CreateCampaign(c *gin.Context) {
	var e promotion.AdCampaign
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := adService.CreateCampaign(e); err != nil {
		response.FailWithMessage("创建失败", c)
		return
	}
	response.OkWithMessage("创建成功", c)
}
func (a *AdApi) UpdateCampaign(c *gin.Context) {
	var e promotion.AdCampaign
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := utils.Verify(e.GVA_MODEL, utils.IdVerify); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := adService.UpdateCampaign(&e); err != nil {
		response.FailWithMessage("更新失败", c)
		return
	}
	response.OkWithMessage("更新成功", c)
}
func (a *AdApi) DeleteCampaign(c *gin.Context) {
	var e promotion.AdCampaign
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := utils.Verify(e.GVA_MODEL, utils.IdVerify); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := adService.DeleteCampaign(e); err != nil {
		response.FailWithMessage("删除失败", c)
		return
	}
	response.OkWithMessage("删除成功", c)
}
func (a *AdApi) GetCampaignList(c *gin.Context) {
	var pageInfo request.PageInfo
	if err := c.ShouldBindQuery(&pageInfo); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	var q struct {
		PlatformID *uint  `form:"platformId"`
		LinkID     *uint  `form:"linkId"`
		RegionID   *uint  `form:"regionId"`
		GroupID    *uint  `form:"groupId"`
		Keyword    string `form:"keyword"`
	}
	_ = c.ShouldBindQuery(&q)
	list, total, err := adService.GetCampaignList(pageInfo, promoSvc.CampaignFilter{
		PlatformID: q.PlatformID,
		LinkID:     q.LinkID,
		RegionID:   q.RegionID,
		GroupID:    q.GroupID,
		Keyword:    q.Keyword,
	})
	if err != nil {
		response.FailWithMessage("获取失败", c)
		return
	}
	response.OkWithDetailed(response.PageResult{List: list, Total: total, Page: pageInfo.Page, PageSize: pageInfo.PageSize}, "获取成功", c)
}

func (a *AdApi) CreateKeyword(c *gin.Context) {
	var e promotion.AdKeyword
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := adService.CreateKeyword(e); err != nil {
		response.FailWithMessage("创建失败", c)
		return
	}
	response.OkWithMessage("创建成功", c)
}
func (a *AdApi) UpdateKeyword(c *gin.Context) {
	var e promotion.AdKeyword
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := utils.Verify(e.GVA_MODEL, utils.IdVerify); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := adService.UpdateKeyword(&e); err != nil {
		response.FailWithMessage("更新失败", c)
		return
	}
	response.OkWithMessage("更新成功", c)
}
func (a *AdApi) DeleteKeyword(c *gin.Context) {
	var e promotion.AdKeyword
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := utils.Verify(e.GVA_MODEL, utils.IdVerify); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := adService.DeleteKeyword(e); err != nil {
		response.FailWithMessage("删除失败", c)
		return
	}
	response.OkWithMessage("删除成功", c)
}
func (a *AdApi) GetKeywordList(c *gin.Context) {
	var pageInfo request.PageInfo
	if err := c.ShouldBindQuery(&pageInfo); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	list, total, err := adService.GetKeywordList(pageInfo)
	if err != nil {
		response.FailWithMessage("获取失败", c)
		return
	}
	response.OkWithDetailed(response.PageResult{List: list, Total: total, Page: pageInfo.Page, PageSize: pageInfo.PageSize}, "获取成功", c)
}

func (a *AdApi) GetDailySummaryList(c *gin.Context) {
	var pageInfo request.PageInfo
	if err := c.ShouldBindQuery(&pageInfo); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	var q struct {
		PlatformID *uint   `form:"platformId"`
		StartDate  *string `form:"startDate"`
		EndDate    *string `form:"endDate"`
	}
	_ = c.ShouldBindQuery(&q)
	list, total, err := adService.GetDailySummaryList(pageInfo, promoSvc.DailySummaryFilter{
		PlatformID: q.PlatformID,
		StartDate:  q.StartDate,
		EndDate:    q.EndDate,
	})
	if err != nil {
		response.FailWithMessage("获取失败", c)
		return
	}
	response.OkWithDetailed(response.PageResult{List: list, Total: total, Page: pageInfo.Page, PageSize: pageInfo.PageSize}, "获取成功", c)
}
