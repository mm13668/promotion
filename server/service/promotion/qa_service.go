package promotion

import (
	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/request"
	"github.com/flipped-aurora/gin-vue-admin/server/model/promotion"
	"github.com/google/uuid"
)

type QAService struct{}

func (s *QAService) CreateQuestion(e promotion.QAQuestion) error {
	return global.GVA_DB.Create(&e).Error
}
func (s *QAService) UpdateQuestion(e *promotion.QAQuestion) error {
	return global.GVA_DB.Save(e).Error
}

func (s *QAService) GetQuestion(id uint, userUUID uuid.UUID) (promotion.QAQuestion, error) {
	var data promotion.QAQuestion
	db := global.GVA_DB.Where("id = ?", id)
	if userUUID != uuid.Nil {
		db = db.Where("uuid = ?", userUUID)
	}
	err := db.First(&data).Error
	return data, err
}

func (s *QAService) DeleteQuestion(e promotion.QAQuestion) error {
	return global.GVA_DB.Delete(&e).Error
}
func (s *QAService) FindQuestion(id uint) (promotion.QAQuestion, error) {
	var data promotion.QAQuestion
	err := global.GVA_DB.Where("id = ?", id).First(&data).Error
	return data, err
}

type QAAnswerWithReply struct {
	promotion.QAAnswer
	Replies []promotion.QAReply `json:"replies"`
}

type QAQuestionDetail struct {
	promotion.QAQuestion
	Answers []QAAnswerWithReply `json:"answers"`
}

func (s *QAService) GetQuestionDetail(id uint) (QAQuestionDetail, error) {
	var detail QAQuestionDetail
	// 查询问题详情
	err := global.GVA_DB.Where("id = ?", id).First(&detail.QAQuestion).Error
	if err != nil {
		return detail, err
	}
	// 查询回答列表
	var answers []promotion.QAAnswer
	err = global.GVA_DB.Where("question_id = ?", id).Order("id asc").Find(&answers).Error
	if err != nil {
		return detail, err
	}
	// 查询每个回答的回复
	detail.Answers = make([]QAAnswerWithReply, len(answers))
	for i, answer := range answers {
		detail.Answers[i].QAAnswer = answer
		var replies []promotion.QAReply
		err = global.GVA_DB.Where("answer_id = ?", answer.ID).Order("id asc").Find(&replies).Error
		if err != nil {
			return detail, err
		}
		detail.Answers[i].Replies = replies
	}
	return detail, nil
}

func (s *QAService) GetQuestionList(info promotion.QAQuestionSearch, userUUID uuid.UUID) (list []promotion.QAQuestion, total int64, err error) {
	limit := info.PageSize
	offset := info.PageSize * (info.Page - 1)
	db := global.GVA_DB.Model(&promotion.QAQuestion{})

	if userUUID != uuid.Nil {
		db = db.Where("uuid = ?", userUUID)
	}
	if info.RegionID != nil {
		db = db.Where("region_id = ?", *info.RegionID)
	}
	if info.Title != "" {
		db = db.Where("title LIKE ?", "%"+info.Title+"%")
	}
	err = db.Count(&total).Error
	if err != nil {
		return
	}
	err = db.Limit(limit).Offset(offset).Order("sort desc,id desc").Find(&list).Error
	return
}

func (s *QAService) CreateAnswer(e promotion.QAAnswer) error {
	return global.GVA_DB.Create(&e).Error
}
func (s *QAService) UpdateAnswer(e *promotion.QAAnswer) error {
	return global.GVA_DB.Save(e).Error
}
func (s *QAService) GetAnswer(id uint, userUUID uuid.UUID) (promotion.QAAnswer, error) {
	var data promotion.QAAnswer
	db := global.GVA_DB.Where("id = ?", id)
	if userUUID != uuid.Nil {
		db = db.Where("uuid = ?", userUUID)
	}
	err := db.First(&data).Error
	return data, err
}
func (s *QAService) DeleteAnswer(e promotion.QAAnswer) error {
	return global.GVA_DB.Delete(&e).Error
}
func (s *QAService) FindAnswer(id uint) (promotion.QAAnswer, error) {
	var data promotion.QAAnswer
	err := global.GVA_DB.Where("id = ?", id).First(&data).Error
	return data, err
}
func (s *QAService) GetAnswerDetail(id uint) (QAAnswerWithReply, error) {
	var detail QAAnswerWithReply
	err := global.GVA_DB.Where("id = ?", id).First(&detail.QAAnswer).Error
	if err != nil {
		return detail, err
	}
	var replies []promotion.QAReply
	err = global.GVA_DB.Where("answer_id = ?", id).Order("id asc").Find(&replies).Error
	if err != nil {
		return detail, err
	}
	detail.Replies = replies
	return detail, nil
}

func (s *QAService) GetAnswerList(info request.PageInfo, userUUID uuid.UUID) (list []promotion.QAAnswer, total int64, err error) {
	limit := info.PageSize
	offset := info.PageSize * (info.Page - 1)
	db := global.GVA_DB.Model(&promotion.QAAnswer{})
	if userUUID != uuid.Nil {
		db = db.Where("uuid = ?", userUUID)
	}
	err = db.Count(&total).Error
	if err != nil {
		return
	}
	err = db.Limit(limit).Offset(offset).Order("id desc").Find(&list).Error
	return
}

func (s *QAService) CreateReply(e promotion.QAReply) error {
	return global.GVA_DB.Create(&e).Error
}
func (s *QAService) UpdateReply(e *promotion.QAReply) error {
	return global.GVA_DB.Save(e).Error
}

func (s *QAService) GetReply(id uint, userUUID uuid.UUID) (promotion.QAReply, error) {
	var data promotion.QAReply
	db := global.GVA_DB.Where("id = ?", id)
	if userUUID != uuid.Nil {
		db = db.Where("uuid = ?", userUUID)
	}
	err := db.First(&data).Error
	return data, err
}
func (s *QAService) DeleteReply(e promotion.QAReply) error {
	return global.GVA_DB.Delete(&e).Error
}
func (s *QAService) FindReply(id uint) (promotion.QAReply, error) {
	var data promotion.QAReply
	err := global.GVA_DB.Where("id = ?", id).First(&data).Error
	return data, err
}
func (s *QAService) GetReplyList(info request.PageInfo, userUUID uuid.UUID) (list []promotion.QAReply, total int64, err error) {
	limit := info.PageSize
	offset := info.PageSize * (info.Page - 1)
	db := global.GVA_DB.Model(&promotion.QAReply{})
	if userUUID != uuid.Nil {
		db = db.Where("uuid = ?", userUUID)
	}
	err = db.Count(&total).Error
	if err != nil {
		return
	}
	err = db.Limit(limit).Offset(offset).Order("id desc").Find(&list).Error
	return
}

// 头像昵称管理
func (s *QAService) CreateAvatarNickname(e promotion.QAAvatarNickname) error {
	return global.GVA_DB.Create(&e).Error
}
func (s *QAService) UpdateAvatarNickname(e *promotion.QAAvatarNickname) error {
	return global.GVA_DB.Save(e).Error
}
func (s *QAService) GetAvatarNickname(id uint, userUUID uuid.UUID) (promotion.QAAvatarNickname, error) {
	var data promotion.QAAvatarNickname
	db := global.GVA_DB.Where("id = ?", id)
	if userUUID != uuid.Nil {
		db = db.Where("uuid = ?", userUUID)
	}
	err := db.First(&data).Error
	return data, err
}
func (s *QAService) DeleteAvatarNickname(e promotion.QAAvatarNickname) error {
	return global.GVA_DB.Delete(&e).Error
}
func (s *QAService) FindAvatarNickname(id uint) (promotion.QAAvatarNickname, error) {
	var data promotion.QAAvatarNickname
	err := global.GVA_DB.Where("id = ?", id).First(&data).Error
	return data, err
}
func (s *QAService) GetAvatarNicknameList(info request.PageInfo, userUUID uuid.UUID) (list []promotion.QAAvatarNickname, total int64, err error) {
	limit := info.PageSize
	offset := info.PageSize * (info.Page - 1)
	db := global.GVA_DB.Model(&promotion.QAAvatarNickname{})
	if userUUID != uuid.Nil {
		db = db.Where("uuid = ?", userUUID)
	}
	err = db.Count(&total).Error
	if err != nil {
		return
	}
	err = db.Limit(limit).Offset(offset).Order("sort desc,id desc").Find(&list).Error
	return
}
func (s *QAService) GetAllEnabledAvatarNickname(userUUID uuid.UUID) (list []promotion.QAAvatarNickname, err error) {
	err = global.GVA_DB.Where("uuid = ?", userUUID).Where("status = 1").Order("sort desc,id desc").Find(&list).Error
	return
}

// 称号管理
func (s *QAService) CreateTitle(e promotion.QATitle) error {
	return global.GVA_DB.Create(&e).Error
}
func (s *QAService) UpdateTitle(e *promotion.QATitle) error {
	return global.GVA_DB.Save(e).Error
}
func (s *QAService) GetTitle(id uint, userUUID uuid.UUID) (promotion.QATitle, error) {
	var data promotion.QATitle
	db := global.GVA_DB.Where("id = ?", id)
	if userUUID != uuid.Nil {
		db = db.Where("uuid = ?", userUUID)
	}
	err := db.First(&data).Error
	return data, err
}
func (s *QAService) DeleteTitle(e promotion.QATitle) error {
	return global.GVA_DB.Delete(&e).Error
}
func (s *QAService) FindTitle(id uint) (promotion.QATitle, error) {
	var data promotion.QATitle
	err := global.GVA_DB.Where("id = ?", id).First(&data).Error
	return data, err
}
func (s *QAService) GetTitleList(info request.PageInfo, userUUID uuid.UUID) (list []promotion.QATitle, total int64, err error) {
	limit := info.PageSize
	offset := info.PageSize * (info.Page - 1)
	db := global.GVA_DB.Model(&promotion.QATitle{})
	if userUUID != uuid.Nil {
		db = db.Where("uuid = ?", userUUID)
	}
	err = db.Count(&total).Error
	if err != nil {
		return
	}
	err = db.Limit(limit).Offset(offset).Order("sort desc,id desc").Find(&list).Error
	return
}
func (s *QAService) GetAllEnabledTitle(userUUID uuid.UUID) (list []promotion.QATitle, err error) {
	err = global.GVA_DB.Where("uuid = ?", userUUID).Where("status = 1").Order("sort desc,id desc").Find(&list).Error
	return
}

// 个性签名管理
func (s *QAService) CreateSignature(e promotion.QASignature) error {
	return global.GVA_DB.Create(&e).Error
}
func (s *QAService) UpdateSignature(e *promotion.QASignature) error {
	return global.GVA_DB.Save(e).Error
}
func (s *QAService) GetSignature(id uint, userUUID uuid.UUID) (promotion.QASignature, error) {
	var data promotion.QASignature
	db := global.GVA_DB.Where("id = ?", id)
	if userUUID != uuid.Nil {
		db = db.Where("uuid = ?", userUUID)
	}
	err := db.First(&data).Error
	return data, err
}
func (s *QAService) DeleteSignature(e promotion.QASignature) error {
	return global.GVA_DB.Delete(&e).Error
}
func (s *QAService) FindSignature(id uint) (promotion.QASignature, error) {
	var data promotion.QASignature
	err := global.GVA_DB.Where("id = ?", id).First(&data).Error
	return data, err
}
func (s *QAService) GetSignatureList(info request.PageInfo, userUUID uuid.UUID) (list []promotion.QASignature, total int64, err error) {
	limit := info.PageSize
	offset := info.PageSize * (info.Page - 1)
	db := global.GVA_DB.Model(&promotion.QASignature{})
	if userUUID != uuid.Nil {
		db = db.Where("uuid = ?", userUUID)
	}
	err = db.Count(&total).Error
	if err != nil {
		return
	}
	err = db.Limit(limit).Offset(offset).Order("sort desc,id desc").Find(&list).Error
	return
}
func (s *QAService) GetAllEnabledSignature(userUUID uuid.UUID) (list []promotion.QASignature, err error) {
	err = global.GVA_DB.Where("uuid = ?", userUUID).Where("status = 1").Order("sort desc,id desc").Find(&list).Error
	return
}

// 标签管理
func (s *QAService) CreateTag(e promotion.QATag) error {
	return global.GVA_DB.Create(&e).Error
}
func (s *QAService) UpdateTag(e *promotion.QATag) error {
	return global.GVA_DB.Save(e).Error
}
func (s *QAService) GetTag(id uint, userUUID uuid.UUID) (promotion.QATag, error) {
	var data promotion.QATag
	db := global.GVA_DB.Where("id = ?", id)
	if userUUID != uuid.Nil {
		db = db.Where("uuid = ?", userUUID)
	}
	err := db.First(&data).Error
	return data, err
}
func (s *QAService) DeleteTag(e promotion.QATag) error {
	return global.GVA_DB.Delete(&e).Error
}
func (s *QAService) FindTag(id uint) (promotion.QATag, error) {
	var data promotion.QATag
	err := global.GVA_DB.Where("id = ?", id).First(&data).Error
	return data, err
}
func (s *QAService) GetTagList(info request.PageInfo, userUUID uuid.UUID) (list []promotion.QATag, total int64, err error) {
	limit := info.PageSize
	offset := info.PageSize * (info.Page - 1)
	db := global.GVA_DB.Model(&promotion.QATag{})
	if userUUID != uuid.Nil {
		db = db.Where("uuid = ?", userUUID)
	}
	err = db.Count(&total).Error
	if err != nil {
		return
	}
	err = db.Limit(limit).Offset(offset).Order("sort desc,id desc").Find(&list).Error
	return
}
func (s *QAService) GetAllEnabledTag(userUUID uuid.UUID) (list []promotion.QATag, err error) {
	err = global.GVA_DB.Where("uuid = ?", userUUID).Where("status = 1").Order("sort desc,id desc").Find(&list).Error
	return
}
