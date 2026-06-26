package promotion

import (
	"strconv"

	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/request"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/response"
	"github.com/flipped-aurora/gin-vue-admin/server/model/promotion"
	"github.com/flipped-aurora/gin-vue-admin/server/utils"
	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
	"go.uber.org/zap"
)

var superAdminUUID = uuid.MustParse(promotion.SuperAdminUUID)

type QAApi struct{}

func (a *QAApi) CreateQuestion(c *gin.Context) {
	var e promotion.QAQuestion
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	e.UUID = utils.GetUserUuid(c)
	if err := qaService.CreateQuestion(e); err != nil {
		global.GVA_LOG.Error("create failed", zap.Error(err))
		response.FailWithMessage("创建失败", c)
		return
	}
	response.OkWithMessage("创建成功", c)
}
func (a *QAApi) UpdateQuestion(c *gin.Context) {
	var e promotion.QAQuestion
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	e.UUID = utils.GetUserUuid(c)
	oneData, _ := qaService.GetQuestion(e.ID, e.UUID)
	if oneData.ID <= 0 {
		response.FailWithMessage("数据不存在", c)
		return
	}
	if err := utils.Verify(e.GVA_MODEL, utils.IdVerify); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := qaService.UpdateQuestion(&e); err != nil {
		response.FailWithMessage("更新失败", c)
		return
	}
	response.OkWithMessage("更新成功", c)
}
func (a *QAApi) DeleteQuestion(c *gin.Context) {
	var e promotion.QAQuestion
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	e.UUID = utils.GetUserUuid(c)
	oneData, _ := qaService.GetQuestion(e.ID, e.UUID)
	if oneData.ID <= 0 {
		response.FailWithMessage("数据不存在", c)
		return
	}
	if err := utils.Verify(e.GVA_MODEL, utils.IdVerify); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := qaService.DeleteQuestion(e); err != nil {
		response.FailWithMessage("删除失败", c)
		return
	}
	response.OkWithMessage("删除成功", c)
}

type QAQuestionSearch struct {
	request.PageInfo
	RegionID *uint  `form:"regionId"`
	Title    string `form:"title"`
}

func (a *QAApi) GetQuestionList(c *gin.Context) {
	var pageInfo QAQuestionSearch
	if err := c.ShouldBindQuery(&pageInfo); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := utils.Verify(pageInfo.PageInfo, utils.PageInfoVerify); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	list, total, err := qaService.GetQuestionList(promotion.QAQuestionSearch{
		Page:     pageInfo.Page,
		PageSize: pageInfo.PageSize,
		RegionID: pageInfo.RegionID,
		Title:    pageInfo.Title,
	}, utils.GetUserUuid(c))
	if err != nil {
		response.FailWithMessage("获取失败", c)
		return
	}
	response.OkWithDetailed(response.PageResult{List: list, Total: total, Page: pageInfo.Page, PageSize: pageInfo.PageSize}, "获取成功", c)
}

func (a *QAApi) GetQuestionDetail(c *gin.Context) {
	idStr := c.Param("id")
	id, err := strconv.ParseUint(idStr, 10, 64)
	if err != nil {
		response.FailWithMessage("参数错误", c)
		return
	}
	detail, err := qaService.GetQuestionDetail(uint(id))
	if err != nil {
		global.GVA_LOG.Error("获取问题详情失败", zap.Error(err))
		response.FailWithMessage("获取失败", c)
		return
	}
	response.OkWithDetailed(detail, "获取成功", c)
}

func (a *QAApi) CreateAnswer(c *gin.Context) {
	var e promotion.QAAnswer
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	e.UUID = utils.GetUserUuid(c)
	if err := qaService.CreateAnswer(e); err != nil {
		response.FailWithMessage("创建失败", c)
		return
	}
	response.OkWithMessage("创建成功", c)
}
func (a *QAApi) UpdateAnswer(c *gin.Context) {
	var e promotion.QAAnswer
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	e.UUID = utils.GetUserUuid(c)
	oneData, _ := qaService.GetAnswer(e.ID, e.UUID)
	if oneData.ID <= 0 {
		response.FailWithMessage("数据不存在", c)
		return
	}
	if err := utils.Verify(e.GVA_MODEL, utils.IdVerify); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := qaService.UpdateAnswer(&e); err != nil {
		response.FailWithMessage("更新失败", c)
		return
	}
	response.OkWithMessage("更新成功", c)
}
func (a *QAApi) DeleteAnswer(c *gin.Context) {
	var e promotion.QAAnswer
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	e.UUID = utils.GetUserUuid(c)
	oneData, _ := qaService.GetAnswer(e.ID, e.UUID)
	if oneData.ID <= 0 {
		response.FailWithMessage("数据不存在", c)
		return
	}
	if err := utils.Verify(e.GVA_MODEL, utils.IdVerify); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := qaService.DeleteAnswer(e); err != nil {
		response.FailWithMessage("删除失败", c)
		return
	}
	response.OkWithMessage("删除成功", c)
}
func (a *QAApi) GetAnswerList(c *gin.Context) {
	var search promotion.AnswerSearch
	if err := c.ShouldBindQuery(&search); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := utils.Verify(search.PageInfo, utils.PageInfoVerify); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	list, total, err := qaService.GetAnswerList(search, utils.GetUserUuid(c))
	if err != nil {
		response.FailWithMessage("获取失败", c)
		return
	}
	response.OkWithDetailed(response.PageResult{List: list, Total: total, Page: search.Page, PageSize: search.PageSize}, "获取成功", c)
}

func (a *QAApi) BatchUpdateAnswerSort(c *gin.Context) {
	var items []promotion.SortItem
	if err := c.ShouldBindJSON(&items); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := qaService.BatchUpdateAnswerSort(items); err != nil {
		global.GVA_LOG.Error("batch update answer sort failed", zap.Error(err))
		response.FailWithMessage("更新排序失败", c)
		return
	}
	response.OkWithMessage("更新排序成功", c)
}

func (a *QAApi) BatchUpdateReplySort(c *gin.Context) {
	var items []promotion.SortItem
	if err := c.ShouldBindJSON(&items); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := qaService.BatchUpdateReplySort(items); err != nil {
		global.GVA_LOG.Error("batch update reply sort failed", zap.Error(err))
		response.FailWithMessage("更新排序失败", c)
		return
	}
	response.OkWithMessage("更新排序成功", c)
}

func (a *QAApi) GetAnswerDetail(c *gin.Context) {
	idStr := c.Param("id")
	id, err := strconv.ParseUint(idStr, 10, 64)
	if err != nil {
		response.FailWithMessage("参数错误", c)
		return
	}
	detail, err := qaService.GetAnswerDetail(uint(id))
	if err != nil {
		global.GVA_LOG.Error("获取回答详情失败", zap.Error(err))
		response.FailWithMessage("获取失败", c)
		return
	}
	response.OkWithDetailed(detail, "获取成功", c)
}

func (a *QAApi) CreateReply(c *gin.Context) {
	var e promotion.QAReply
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	e.UUID = utils.GetUserUuid(c)
	if err := qaService.CreateReply(e); err != nil {
		response.FailWithMessage("创建失败", c)
		return
	}
	response.OkWithMessage("创建成功", c)
}
func (a *QAApi) UpdateReply(c *gin.Context) {
	var e promotion.QAReply
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	e.UUID = utils.GetUserUuid(c)
	oneData, _ := qaService.GetReply(e.ID, e.UUID)
	if oneData.ID <= 0 {
		response.FailWithMessage("数据不存在", c)
		return
	}
	if err := utils.Verify(e.GVA_MODEL, utils.IdVerify); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := qaService.UpdateReply(&e); err != nil {
		response.FailWithMessage("更新失败", c)
		return
	}
	response.OkWithMessage("更新成功", c)
}
func (a *QAApi) DeleteReply(c *gin.Context) {
	var e promotion.QAReply
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	e.UUID = utils.GetUserUuid(c)
	oneData, _ := qaService.GetReply(e.ID, e.UUID)
	if oneData.ID <= 0 {
		response.FailWithMessage("数据不存在", c)
		return
	}
	if err := utils.Verify(e.GVA_MODEL, utils.IdVerify); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := qaService.DeleteReply(e); err != nil {
		response.FailWithMessage("删除失败", c)
		return
	}
	response.OkWithMessage("删除成功", c)
}
func (a *QAApi) GetReplyList(c *gin.Context) {
	var search promotion.ReplySearch
	if err := c.ShouldBindQuery(&search); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := utils.Verify(search.PageInfo, utils.PageInfoVerify); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	list, total, err := qaService.GetReplyList(search, utils.GetUserUuid(c))
	if err != nil {
		response.FailWithMessage("获取失败", c)
		return
	}
	response.OkWithDetailed(response.PageResult{List: list, Total: total, Page: search.Page, PageSize: search.PageSize}, "获取成功", c)
}

// 头像昵称管理
func (a *QAApi) CreateAvatarNickname(c *gin.Context) {
	var e promotion.QAAvatarNickname
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	e.UUID = utils.GetUserUuid(c)
	if err := qaService.CreateAvatarNickname(e); err != nil {
		global.GVA_LOG.Error("create failed", zap.Error(err))
		response.FailWithMessage("创建失败", c)
		return
	}
	response.OkWithMessage("创建成功", c)
}
func (a *QAApi) UpdateAvatarNickname(c *gin.Context) {
	var e promotion.QAAvatarNickname
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	userUUID := utils.GetUserUuid(c)
	oneData, _ := qaService.FindAvatarNickname(e.ID)
	if oneData.ID <= 0 {
		response.FailWithMessage("数据不存在", c)
		return
	}
	if oneData.UUID == superAdminUUID {
		response.FailWithMessage("超级账号数据不允许编辑", c)
		return
	}
	if oneData.UUID != userUUID {
		response.FailWithMessage("无权操作该数据", c)
		return
	}
	e.UUID = userUUID
	if err := utils.Verify(e.GVA_MODEL, utils.IdVerify); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := qaService.UpdateAvatarNickname(&e); err != nil {
		response.FailWithMessage("更新失败", c)
		return
	}
	response.OkWithMessage("更新成功", c)
}
func (a *QAApi) DeleteAvatarNickname(c *gin.Context) {
	var e promotion.QAAvatarNickname
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	userUUID := utils.GetUserUuid(c)
	oneData, _ := qaService.FindAvatarNickname(e.ID)
	if oneData.ID <= 0 {
		response.FailWithMessage("数据不存在", c)
		return
	}
	if oneData.UUID == superAdminUUID {
		response.FailWithMessage("超级账号数据不允许删除", c)
		return
	}
	if oneData.UUID != userUUID {
		response.FailWithMessage("无权操作该数据", c)
		return
	}
	e.UUID = userUUID
	if err := utils.Verify(e.GVA_MODEL, utils.IdVerify); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := qaService.DeleteAvatarNickname(e); err != nil {
		response.FailWithMessage("删除失败", c)
		return
	}
	response.OkWithMessage("删除成功", c)
}
func (a *QAApi) GetAvatarNicknameList(c *gin.Context) {
	var search promotion.QAAvatarNicknameSearch
	if err := c.ShouldBindQuery(&search); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := utils.Verify(search.PageInfo, utils.PageInfoVerify); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	list, total, err := qaService.GetAvatarNicknameList(search, utils.GetUserUuid(c))
	if err != nil {
		response.FailWithMessage("获取失败", c)
		return
	}
	response.OkWithDetailed(response.PageResult{List: list, Total: total, Page: search.Page, PageSize: search.PageSize}, "获取成功", c)
}
func (a *QAApi) GetAllEnabledAvatarNickname(c *gin.Context) {
	list, err := qaService.GetAllEnabledAvatarNickname(utils.GetUserUuid(c))
	if err != nil {
		response.FailWithMessage("获取失败", c)
		return
	}
	response.OkWithDetailed(list, "获取成功", c)
}

// 称号管理
func (a *QAApi) CreateTitle(c *gin.Context) {
	var e promotion.QATitle
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	e.UUID = utils.GetUserUuid(c)
	if err := qaService.CreateTitle(e); err != nil {
		global.GVA_LOG.Error("create failed", zap.Error(err))
		response.FailWithMessage("创建失败", c)
		return
	}
	response.OkWithMessage("创建成功", c)
}
func (a *QAApi) UpdateTitle(c *gin.Context) {
	var e promotion.QATitle
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	userUUID := utils.GetUserUuid(c)
	oneData, _ := qaService.FindTitle(e.ID)
	if oneData.ID <= 0 {
		response.FailWithMessage("数据不存在", c)
		return
	}
	if oneData.UUID == superAdminUUID {
		response.FailWithMessage("超级账号数据不允许编辑", c)
		return
	}
	if oneData.UUID != userUUID {
		response.FailWithMessage("无权操作该数据", c)
		return
	}
	e.UUID = userUUID
	if err := utils.Verify(e.GVA_MODEL, utils.IdVerify); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := qaService.UpdateTitle(&e); err != nil {
		response.FailWithMessage("更新失败", c)
		return
	}
	response.OkWithMessage("更新成功", c)
}
func (a *QAApi) DeleteTitle(c *gin.Context) {
	var e promotion.QATitle
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	userUUID := utils.GetUserUuid(c)
	oneData, _ := qaService.FindTitle(e.ID)
	if oneData.ID <= 0 {
		response.FailWithMessage("数据不存在", c)
		return
	}
	if oneData.UUID == superAdminUUID {
		response.FailWithMessage("超级账号数据不允许删除", c)
		return
	}
	if oneData.UUID != userUUID {
		response.FailWithMessage("无权操作该数据", c)
		return
	}
	e.UUID = userUUID
	if err := utils.Verify(e.GVA_MODEL, utils.IdVerify); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := qaService.DeleteTitle(e); err != nil {
		response.FailWithMessage("删除失败", c)
		return
	}
	response.OkWithMessage("删除成功", c)
}
func (a *QAApi) GetTitleList(c *gin.Context) {
	var search promotion.QATitleSearch
	if err := c.ShouldBindQuery(&search); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := utils.Verify(search.PageInfo, utils.PageInfoVerify); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	list, total, err := qaService.GetTitleList(search, utils.GetUserUuid(c))
	if err != nil {
		response.FailWithMessage("获取失败", c)
		return
	}
	response.OkWithDetailed(response.PageResult{List: list, Total: total, Page: search.Page, PageSize: search.PageSize}, "获取成功", c)
}
func (a *QAApi) GetAllEnabledTitle(c *gin.Context) {
	list, err := qaService.GetAllEnabledTitle(utils.GetUserUuid(c))
	if err != nil {
		response.FailWithMessage("获取失败", c)
		return
	}
	response.OkWithDetailed(list, "获取成功", c)
}

// 个性签名管理
func (a *QAApi) CreateSignature(c *gin.Context) {
	var e promotion.QASignature
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	e.UUID = utils.GetUserUuid(c)
	if err := qaService.CreateSignature(e); err != nil {
		global.GVA_LOG.Error("create failed", zap.Error(err))
		response.FailWithMessage("创建失败", c)
		return
	}
	response.OkWithMessage("创建成功", c)
}
func (a *QAApi) UpdateSignature(c *gin.Context) {
	var e promotion.QASignature
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	userUUID := utils.GetUserUuid(c)
	oneData, _ := qaService.FindSignature(e.ID)
	if oneData.ID <= 0 {
		response.FailWithMessage("数据不存在", c)
		return
	}
	if oneData.UUID == superAdminUUID {
		response.FailWithMessage("超级账号数据不允许编辑", c)
		return
	}
	if oneData.UUID != userUUID {
		response.FailWithMessage("无权操作该数据", c)
		return
	}
	e.UUID = userUUID
	if err := utils.Verify(e.GVA_MODEL, utils.IdVerify); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := qaService.UpdateSignature(&e); err != nil {
		response.FailWithMessage("更新失败", c)
		return
	}
	response.OkWithMessage("更新成功", c)
}
func (a *QAApi) DeleteSignature(c *gin.Context) {
	var e promotion.QASignature
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	userUUID := utils.GetUserUuid(c)
	oneData, _ := qaService.FindSignature(e.ID)
	if oneData.ID <= 0 {
		response.FailWithMessage("数据不存在", c)
		return
	}
	if oneData.UUID == superAdminUUID {
		response.FailWithMessage("超级账号数据不允许删除", c)
		return
	}
	if oneData.UUID != userUUID {
		response.FailWithMessage("无权操作该数据", c)
		return
	}
	e.UUID = userUUID
	if err := utils.Verify(e.GVA_MODEL, utils.IdVerify); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := qaService.DeleteSignature(e); err != nil {
		response.FailWithMessage("删除失败", c)
		return
	}
	response.OkWithMessage("删除成功", c)
}
func (a *QAApi) GetSignatureList(c *gin.Context) {
	var search promotion.QASignatureSearch
	if err := c.ShouldBindQuery(&search); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := utils.Verify(search.PageInfo, utils.PageInfoVerify); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	list, total, err := qaService.GetSignatureList(search, utils.GetUserUuid(c))
	if err != nil {
		response.FailWithMessage("获取失败", c)
		return
	}
	response.OkWithDetailed(response.PageResult{List: list, Total: total, Page: search.Page, PageSize: search.PageSize}, "获取成功", c)
}
func (a *QAApi) GetAllEnabledSignature(c *gin.Context) {
	list, err := qaService.GetAllEnabledSignature(utils.GetUserUuid(c))
	if err != nil {
		response.FailWithMessage("获取失败", c)
		return
	}
	response.OkWithDetailed(list, "获取成功", c)
}

// 标签管理
func (a *QAApi) CreateTag(c *gin.Context) {
	var e promotion.QATag
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	e.UUID = utils.GetUserUuid(c)
	if err := qaService.CreateTag(e); err != nil {
		global.GVA_LOG.Error("create failed", zap.Error(err))
		response.FailWithMessage("创建失败", c)
		return
	}
	response.OkWithMessage("创建成功", c)
}
func (a *QAApi) UpdateTag(c *gin.Context) {
	var e promotion.QATag
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	userUUID := utils.GetUserUuid(c)
	oneData, _ := qaService.FindTag(e.ID)
	if oneData.ID <= 0 {
		response.FailWithMessage("数据不存在", c)
		return
	}
	if oneData.UUID == superAdminUUID {
		response.FailWithMessage("超级账号数据不允许编辑", c)
		return
	}
	if oneData.UUID != userUUID {
		response.FailWithMessage("无权操作该数据", c)
		return
	}
	e.UUID = userUUID
	if err := utils.Verify(e.GVA_MODEL, utils.IdVerify); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := qaService.UpdateTag(&e); err != nil {
		response.FailWithMessage("更新失败", c)
		return
	}
	response.OkWithMessage("更新成功", c)
}
func (a *QAApi) DeleteTag(c *gin.Context) {
	var e promotion.QATag
	if err := c.ShouldBindJSON(&e); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	userUUID := utils.GetUserUuid(c)
	oneData, _ := qaService.FindTag(e.ID)
	if oneData.ID <= 0 {
		response.FailWithMessage("数据不存在", c)
		return
	}
	if oneData.UUID == superAdminUUID {
		response.FailWithMessage("超级账号数据不允许删除", c)
		return
	}
	if oneData.UUID != userUUID {
		response.FailWithMessage("无权操作该数据", c)
		return
	}
	e.UUID = userUUID
	if err := utils.Verify(e.GVA_MODEL, utils.IdVerify); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := qaService.DeleteTag(e); err != nil {
		response.FailWithMessage("删除失败", c)
		return
	}
	response.OkWithMessage("删除成功", c)
}
func (a *QAApi) GetTagList(c *gin.Context) {
	var search promotion.QATagSearch
	if err := c.ShouldBindQuery(&search); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := utils.Verify(search.PageInfo, utils.PageInfoVerify); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	list, total, err := qaService.GetTagList(search, utils.GetUserUuid(c))
	if err != nil {
		response.FailWithMessage("获取失败", c)
		return
	}
	response.OkWithDetailed(response.PageResult{List: list, Total: total, Page: search.Page, PageSize: search.PageSize}, "获取成功", c)
}
func (a *QAApi) GetAllEnabledTag(c *gin.Context) {
	list, err := qaService.GetAllEnabledTag(utils.GetUserUuid(c))
	if err != nil {
		response.FailWithMessage("获取失败", c)
		return
	}
	response.OkWithDetailed(list, "获取成功", c)
}
