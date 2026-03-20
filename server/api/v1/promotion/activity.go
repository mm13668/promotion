package promotion

import (
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/request"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/response"
	"github.com/flipped-aurora/gin-vue-admin/server/model/promotion"
	"github.com/flipped-aurora/gin-vue-admin/server/utils"
	"github.com/gin-gonic/gin"
)

type ActivityApi struct{}

func (a *ActivityApi) CreateMarket(c *gin.Context) {
	var e promotion.ActivityMarket
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := activityService.CreateMarket(e); err != nil {
		response.FailWithMessage("创建失败", c)
		return
	}
	response.OkWithMessage("创建成功", c)
}
func (a *ActivityApi) UpdateMarket(c *gin.Context) {
	var e promotion.ActivityMarket
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := utils.Verify(e.GVA_MODEL, utils.IdVerify); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := activityService.UpdateMarket(&e); err != nil {
		response.FailWithMessage("更新失败", c)
		return
	}
	response.OkWithMessage("更新成功", c)
}
func (a *ActivityApi) DeleteMarket(c *gin.Context) {
	var e promotion.ActivityMarket
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := utils.Verify(e.GVA_MODEL, utils.IdVerify); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := activityService.DeleteMarket(e); err != nil {
		response.FailWithMessage("删除失败", c)
		return
	}
	response.OkWithMessage("删除成功", c)
}
func (a *ActivityApi) GetMarketList(c *gin.Context) {
	var pageInfo request.PageInfo
	if err := c.ShouldBindQuery(&pageInfo); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	list, total, err := activityService.GetMarketList(pageInfo)
	if err != nil {
		response.FailWithMessage("获取失败", c)
		return
	}
	response.OkWithDetailed(response.PageResult{List: list, Total: total, Page: pageInfo.Page, PageSize: pageInfo.PageSize}, "获取成功", c)
}

func (a *ActivityApi) CreatePackage(c *gin.Context) {
	var e promotion.ActivityPackage
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := activityService.CreatePackage(e); err != nil {
		response.FailWithMessage("创建失败", c)
		return
	}
	response.OkWithMessage("创建成功", c)
}
func (a *ActivityApi) UpdatePackage(c *gin.Context) {
	var e promotion.ActivityPackage
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := utils.Verify(e.GVA_MODEL, utils.IdVerify); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := activityService.UpdatePackage(&e); err != nil {
		response.FailWithMessage("更新失败", c)
		return
	}
	response.OkWithMessage("更新成功", c)
}
func (a *ActivityApi) DeletePackage(c *gin.Context) {
	var e promotion.ActivityPackage
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := utils.Verify(e.GVA_MODEL, utils.IdVerify); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := activityService.DeletePackage(e); err != nil {
		response.FailWithMessage("删除失败", c)
		return
	}
	response.OkWithMessage("删除成功", c)
}
func (a *ActivityApi) GetPackageList(c *gin.Context) {
	var pageInfo request.PageInfo
	if err := c.ShouldBindQuery(&pageInfo); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	list, total, err := activityService.GetPackageList(pageInfo)
	if err != nil {
		response.FailWithMessage("获取失败", c)
		return
	}
	response.OkWithDetailed(response.PageResult{List: list, Total: total, Page: pageInfo.Page, PageSize: pageInfo.PageSize}, "获取成功", c)
}

func (a *ActivityApi) CreateActivity(c *gin.Context) {
	var e promotion.ActivityData
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := activityService.CreateActivity(e); err != nil {
		response.FailWithMessage("创建失败", c)
		return
	}
	response.OkWithMessage("创建成功", c)
}
func (a *ActivityApi) UpdateActivity(c *gin.Context) {
	var e promotion.ActivityData
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := utils.Verify(e.GVA_MODEL, utils.IdVerify); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := activityService.UpdateActivity(&e); err != nil {
		response.FailWithMessage("更新失败", c)
		return
	}
	response.OkWithMessage("更新成功", c)
}
func (a *ActivityApi) DeleteActivity(c *gin.Context) {
	var e promotion.ActivityData
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := utils.Verify(e.GVA_MODEL, utils.IdVerify); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := activityService.DeleteActivity(e); err != nil {
		response.FailWithMessage("删除失败", c)
		return
	}
	response.OkWithMessage("删除成功", c)
}
func (a *ActivityApi) GetActivityList(c *gin.Context) {
	var pageInfo request.PageInfo
	if err := c.ShouldBindQuery(&pageInfo); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	list, total, err := activityService.GetActivityList(pageInfo)
	if err != nil {
		response.FailWithMessage("获取失败", c)
		return
	}
	response.OkWithDetailed(response.PageResult{List: list, Total: total, Page: pageInfo.Page, PageSize: pageInfo.PageSize}, "获取成功", c)
}

