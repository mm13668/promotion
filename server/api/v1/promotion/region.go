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

type RegionApi struct{}
type GroupApi struct{}
type MemberApi struct{}

func (a *RegionApi) CreateRegionCategory(c *gin.Context) {
	var e promotion.RegionCategory
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := regionService.CreateRegionCategory(e); err != nil {
		global.GVA_LOG.Error("create failed", zap.Error(err))
		response.FailWithMessage("创建失败", c)
		return
	}
	response.OkWithMessage("创建成功", c)
}

func (a *RegionApi) DeleteRegionCategory(c *gin.Context) {
	var e promotion.RegionCategory
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := utils.Verify(e.GVA_MODEL, utils.IdVerify); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := regionService.DeleteRegionCategory(e); err != nil {
		global.GVA_LOG.Error("delete failed", zap.Error(err))
		response.FailWithMessage("删除失败", c)
		return
	}
	response.OkWithMessage("删除成功", c)
}

func (a *RegionApi) UpdateRegionCategory(c *gin.Context) {
	var e promotion.RegionCategory
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := utils.Verify(e.GVA_MODEL, utils.IdVerify); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := regionService.UpdateRegionCategory(&e); err != nil {
		global.GVA_LOG.Error("update failed", zap.Error(err))
		response.FailWithMessage("更新失败", c)
		return
	}
	response.OkWithMessage("更新成功", c)
}

func (a *RegionApi) FindRegionCategory(c *gin.Context) {
	var e promotion.RegionCategory
	if err := c.ShouldBindQuery(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := utils.Verify(e.GVA_MODEL, utils.IdVerify); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	data, err := regionService.FindRegionCategory(e.ID)
	if err != nil {
		global.GVA_LOG.Error("find failed", zap.Error(err))
		response.FailWithMessage("获取失败", c)
		return
	}
	response.OkWithDetailed(gin.H{"data": data}, "获取成功", c)
}

func (a *RegionApi) GetRegionCategoryList(c *gin.Context) {
	var pageInfo request.PageInfo
	if err := c.ShouldBindQuery(&pageInfo); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := utils.Verify(pageInfo, utils.PageInfoVerify); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	list, total, err := regionService.GetRegionCategoryList(pageInfo)
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

func (a *GroupApi) CreatePromotionGroup(c *gin.Context) {
	var e promotion.PromotionGroup
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := groupService.CreatePromotionGroup(e); err != nil {
		global.GVA_LOG.Error("create failed", zap.Error(err))
		response.FailWithMessage("创建失败", c)
		return
	}
	response.OkWithMessage("创建成功", c)
}

func (a *GroupApi) DeletePromotionGroup(c *gin.Context) {
	var e promotion.PromotionGroup
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := utils.Verify(e.GVA_MODEL, utils.IdVerify); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := groupService.DeletePromotionGroup(e); err != nil {
		global.GVA_LOG.Error("delete failed", zap.Error(err))
		response.FailWithMessage("删除失败", c)
		return
	}
	response.OkWithMessage("删除成功", c)
}

func (a *GroupApi) UpdatePromotionGroup(c *gin.Context) {
	var e promotion.PromotionGroup
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := utils.Verify(e.GVA_MODEL, utils.IdVerify); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := groupService.UpdatePromotionGroup(&e); err != nil {
		global.GVA_LOG.Error("update failed", zap.Error(err))
		response.FailWithMessage("更新失败", c)
		return
	}
	response.OkWithMessage("更新成功", c)
}

func (a *GroupApi) FindPromotionGroup(c *gin.Context) {
	var e promotion.PromotionGroup
	if err := c.ShouldBindQuery(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := utils.Verify(e.GVA_MODEL, utils.IdVerify); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	data, err := groupService.FindPromotionGroup(e.ID)
	if err != nil {
		global.GVA_LOG.Error("find failed", zap.Error(err))
		response.FailWithMessage("获取失败", c)
		return
	}
	response.OkWithDetailed(gin.H{"data": data}, "获取成功", c)
}

func (a *GroupApi) GetPromotionGroupList(c *gin.Context) {
	var pageInfo request.PageInfo
	if err := c.ShouldBindQuery(&pageInfo); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := utils.Verify(pageInfo, utils.PageInfoVerify); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	list, total, err := groupService.GetPromotionGroupList(pageInfo)
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

func (a *MemberApi) CreateGroupMember(c *gin.Context) {
	var e promotion.GroupMember
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := memberService.CreateGroupMember(e); err != nil {
		global.GVA_LOG.Error("create failed", zap.Error(err))
		response.FailWithMessage("创建失败", c)
		return
	}
	response.OkWithMessage("创建成功", c)
}

func (a *MemberApi) DeleteGroupMember(c *gin.Context) {
	var e promotion.GroupMember
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := utils.Verify(e.GVA_MODEL, utils.IdVerify); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := memberService.DeleteGroupMember(e); err != nil {
		global.GVA_LOG.Error("delete failed", zap.Error(err))
		response.FailWithMessage("删除失败", c)
		return
	}
	response.OkWithMessage("删除成功", c)
}

func (a *MemberApi) UpdateGroupMember(c *gin.Context) {
	var e promotion.GroupMember
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := utils.Verify(e.GVA_MODEL, utils.IdVerify); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := memberService.UpdateGroupMember(&e); err != nil {
		global.GVA_LOG.Error("update failed", zap.Error(err))
		response.FailWithMessage("更新失败", c)
		return
	}
	response.OkWithMessage("更新成功", c)
}

func (a *MemberApi) FindGroupMember(c *gin.Context) {
	var e promotion.GroupMember
	if err := c.ShouldBindQuery(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := utils.Verify(e.GVA_MODEL, utils.IdVerify); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	data, err := memberService.FindGroupMember(e.ID)
	if err != nil {
		global.GVA_LOG.Error("find failed", zap.Error(err))
		response.FailWithMessage("获取失败", c)
		return
	}
	response.OkWithDetailed(gin.H{"data": data}, "获取成功", c)
}

func (a *MemberApi) GetGroupMemberList(c *gin.Context) {
	var pageInfo request.PageInfo
	if err := c.ShouldBindQuery(&pageInfo); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := utils.Verify(pageInfo, utils.PageInfoVerify); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	list, total, err := memberService.GetGroupMemberList(pageInfo)
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

