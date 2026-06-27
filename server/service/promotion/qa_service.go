package promotion

import (
	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/promotion"
	"github.com/google/uuid"
)

type QAService struct{}

func (s *QAService) CreateQuestion(e promotion.QAQuestion) error {
	return global.GVA_DB.Create(&e).Error
}
func (s *QAService) UpdateQuestion(e *promotion.QAQuestion) error {
	return global.GVA_DB.Model(e).Updates(e).Error
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
	tx := global.GVA_DB.Begin()

	var answerIDs []uint
	if err := tx.Model(&promotion.QAAnswer{}).Where("question_id = ?", e.ID).Pluck("id", &answerIDs).Error; err != nil {
		tx.Rollback()
		return err
	}
	if len(answerIDs) > 0 {
		if err := tx.Where("answer_id IN ?", answerIDs).Delete(&promotion.QAReply{}).Error; err != nil {
			tx.Rollback()
			return err
		}
		if err := tx.Where("id IN ?", answerIDs).Delete(&promotion.QAAnswer{}).Error; err != nil {
			tx.Rollback()
			return err
		}
	}
	if err := tx.Delete(&e).Error; err != nil {
		tx.Rollback()
		return err
	}
	return tx.Commit().Error
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
	err = global.GVA_DB.Where("question_id = ?", id).Order("sort desc, id asc").Find(&answers).Error
	if err != nil {
		return detail, err
	}
	// 查询每个回答的回复
	detail.Answers = make([]QAAnswerWithReply, len(answers))
	for i, answer := range answers {
		detail.Answers[i].QAAnswer = answer
		var replies []promotion.QAReply
		err = global.GVA_DB.Where("answer_id = ?", answer.ID).Order("sort desc, id asc").Find(&replies).Error
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
	return global.GVA_DB.Model(e).Updates(e).Error
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
	tx := global.GVA_DB.Begin()

	if err := tx.Where("answer_id = ?", e.ID).Delete(&promotion.QAReply{}).Error; err != nil {
		tx.Rollback()
		return err
	}
	if err := tx.Delete(&e).Error; err != nil {
		tx.Rollback()
		return err
	}
	return tx.Commit().Error
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
	err = global.GVA_DB.Where("answer_id = ?", id).Order("sort desc, id asc").Find(&replies).Error
	if err != nil {
		return detail, err
	}
	detail.Replies = replies
	return detail, nil
}

func (s *QAService) GetAnswerList(info promotion.AnswerSearch, userUUID uuid.UUID) (list []promotion.QAAnswer, total int64, err error) {
	limit := info.PageSize
	offset := info.PageSize * (info.Page - 1)
	db := global.GVA_DB.Model(&promotion.QAAnswer{})
	if userUUID != uuid.Nil {
		db = db.Where("qa_answer.uuid = ?", userUUID)
	}
	if info.QuestionID != nil {
		db = db.Where("qa_answer.question_id = ?", *info.QuestionID)
	}
	err = db.Count(&total).Error
	if err != nil {
		return
	}
	err = db.Select("qa_answer.*, (SELECT COUNT(*) FROM qa_reply WHERE qa_reply.answer_id = qa_answer.id AND qa_reply.deleted_at IS NULL) as reply_count").
		Limit(limit).Offset(offset).Order("sort desc, id asc").Find(&list).Error
	return
}

func (s *QAService) CreateReply(e promotion.QAReply) error {
	return global.GVA_DB.Create(&e).Error
}
func (s *QAService) UpdateReply(e *promotion.QAReply) error {
	return global.GVA_DB.Model(e).Updates(e).Error
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
func (s *QAService) BatchUpdateAnswerSort(items []promotion.SortItem) error {
	for _, item := range items {
		if err := global.GVA_DB.Model(&promotion.QAAnswer{}).Where("id = ?", item.ID).Update("sort", item.Sort).Error; err != nil {
			return err
		}
	}
	return nil
}

func (s *QAService) BatchUpdateReplySort(items []promotion.SortItem) error {
	for _, item := range items {
		if err := global.GVA_DB.Model(&promotion.QAReply{}).Where("id = ?", item.ID).Update("sort", item.Sort).Error; err != nil {
			return err
		}
	}
	return nil
}

func (s *QAService) GetReplyList(info promotion.ReplySearch, userUUID uuid.UUID) (list []promotion.QAReply, total int64, err error) {
	limit := info.PageSize
	offset := info.PageSize * (info.Page - 1)
	db := global.GVA_DB.Model(&promotion.QAReply{})
	if userUUID != uuid.Nil {
		db = db.Where("uuid = ?", userUUID)
	}
	if info.AnswerID != nil {
		db = db.Where("answer_id = ?", *info.AnswerID)
	}
	err = db.Count(&total).Error
	if err != nil {
		return
	}
	err = db.Limit(limit).Offset(offset).Order("sort desc, id asc").Find(&list).Error
	return
}

// 头像昵称管理
func (s *QAService) CreateAvatarNickname(e promotion.QAAvatarNickname) error {
	return global.GVA_DB.Create(&e).Error
}
func (s *QAService) UpdateAvatarNickname(e *promotion.QAAvatarNickname) error {
	return global.GVA_DB.Model(e).Updates(e).Error
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
func (s *QAService) GetAvatarNicknameList(info promotion.QAAvatarNicknameSearch, userUUID uuid.UUID) (list []promotion.QAAvatarNickname, total int64, err error) {
	limit := info.PageSize
	offset := info.PageSize * (info.Page - 1)
	db := global.GVA_DB.Model(&promotion.QAAvatarNickname{})
	if userUUID != uuid.Nil {
		db = db.Where("(uuid = ? OR uuid = ?)", userUUID, promotion.SuperAdminUUID)
	}
	if info.Nickname != "" {
		db = db.Where("nickname LIKE ?", "%"+info.Nickname+"%")
	}
	err = db.Count(&total).Error
	if err != nil {
		return
	}
	err = db.Limit(limit).Offset(offset).Order("id desc").Find(&list).Error
	return
}
func (s *QAService) GetAllEnabledAvatarNickname(userUUID uuid.UUID) (list []promotion.QAAvatarNickname, err error) {
	err = global.GVA_DB.Where("(uuid = ? OR uuid = ?) AND status = 1", userUUID, promotion.SuperAdminUUID).Order("id desc").Find(&list).Error
	return
}

// 称号管理
func (s *QAService) CreateTitle(e promotion.QATitle) error {
	return global.GVA_DB.Create(&e).Error
}
func (s *QAService) UpdateTitle(e *promotion.QATitle) error {
	return global.GVA_DB.Model(e).Updates(e).Error
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
func (s *QAService) GetTitleList(info promotion.QATitleSearch, userUUID uuid.UUID) (list []promotion.QATitle, total int64, err error) {
	limit := info.PageSize
	offset := info.PageSize * (info.Page - 1)
	db := global.GVA_DB.Model(&promotion.QATitle{})
	if userUUID != uuid.Nil {
		db = db.Where("(uuid = ? OR uuid = ?)", userUUID, promotion.SuperAdminUUID)
	}
	if info.Name != "" {
		db = db.Where("name LIKE ?", "%"+info.Name+"%")
	}
	err = db.Count(&total).Error
	if err != nil {
		return
	}
	err = db.Limit(limit).Offset(offset).Order("id desc").Find(&list).Error
	return
}
func (s *QAService) GetAllEnabledTitle(userUUID uuid.UUID) (list []promotion.QATitle, err error) {
	err = global.GVA_DB.Where("(uuid = ? OR uuid = ?) AND status = 1", userUUID, promotion.SuperAdminUUID).Order("id desc").Find(&list).Error
	return
}

// 个性签名管理
func (s *QAService) CreateSignature(e promotion.QASignature) error {
	return global.GVA_DB.Create(&e).Error
}
func (s *QAService) UpdateSignature(e *promotion.QASignature) error {
	return global.GVA_DB.Model(e).Updates(e).Error
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
func (s *QAService) GetSignatureList(info promotion.QASignatureSearch, userUUID uuid.UUID) (list []promotion.QASignature, total int64, err error) {
	limit := info.PageSize
	offset := info.PageSize * (info.Page - 1)
	db := global.GVA_DB.Model(&promotion.QASignature{})
	if userUUID != uuid.Nil {
		db = db.Where("(uuid = ? OR uuid = ?)", userUUID, promotion.SuperAdminUUID)
	}
	if info.Content != "" {
		db = db.Where("content LIKE ?", "%"+info.Content+"%")
	}
	err = db.Count(&total).Error
	if err != nil {
		return
	}
	err = db.Limit(limit).Offset(offset).Order("id desc").Find(&list).Error
	return
}
func (s *QAService) GetAllEnabledSignature(userUUID uuid.UUID) (list []promotion.QASignature, err error) {
	err = global.GVA_DB.Where("(uuid = ? OR uuid = ?) AND status = 1", userUUID, promotion.SuperAdminUUID).Order("id desc").Find(&list).Error
	return
}

// 标签管理
func (s *QAService) CreateTag(e promotion.QATag) error {
	return global.GVA_DB.Create(&e).Error
}
func (s *QAService) UpdateTag(e *promotion.QATag) error {
	return global.GVA_DB.Model(e).Updates(e).Error
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
func (s *QAService) GetTagList(info promotion.QATagSearch, userUUID uuid.UUID) (list []promotion.QATag, total int64, err error) {
	limit := info.PageSize
	offset := info.PageSize * (info.Page - 1)
	db := global.GVA_DB.Model(&promotion.QATag{})
	if userUUID != uuid.Nil {
		db = db.Where("(uuid = ? OR uuid = ?)", userUUID, promotion.SuperAdminUUID)
	}
	if info.Name != "" {
		db = db.Where("name LIKE ?", "%"+info.Name+"%")
	}
	err = db.Count(&total).Error
	if err != nil {
		return
	}
	err = db.Limit(limit).Offset(offset).Order("id desc").Find(&list).Error
	return
}
func (s *QAService) GetAllEnabledTag(userUUID uuid.UUID) (list []promotion.QATag, err error) {
	err = global.GVA_DB.Where("(uuid = ? OR uuid = ?) AND status = 1", userUUID, promotion.SuperAdminUUID).Order("id desc").Find(&list).Error
	return
}

func (s *QAService) CopyQuestion(id uint) (promotion.QAQuestion, error) {
	tx := global.GVA_DB.Begin()

	var orig promotion.QAQuestion
	if err := tx.Where("id = ?", id).First(&orig).Error; err != nil {
		tx.Rollback()
		return orig, err
	}

	newQuestion := promotion.QAQuestion{
		UUID:          orig.UUID,
		RegionID:      orig.RegionID,
		Title:         orig.Title + " (副本)",
		Content:       orig.Content,
		TimeAt:        orig.TimeAt,
		Remark:        orig.Remark,
		Nickname:      orig.Nickname,
		AvatarURL:     orig.AvatarURL,
		TitleName:     orig.TitleName,
		Signature:     orig.Signature,
		FollowCount:   orig.FollowCount,
		LookCount:     orig.LookCount,
		FavoriteCount: orig.FavoriteCount,
		LikeCount:     orig.LikeCount,
		Label:         orig.Label,
		Sort:          orig.Sort,
		AnswerCount:   orig.AnswerCount,
		Status:        orig.Status,
	}
	if err := tx.Create(&newQuestion).Error; err != nil {
		tx.Rollback()
		return newQuestion, err
	}

	var origAnswers []promotion.QAAnswer
	if err := tx.Where("question_id = ?", id).Order("id asc").Find(&origAnswers).Error; err != nil {
		tx.Rollback()
		return newQuestion, err
	}

	answerIDMap := map[uint]uint{}
	for _, origAnswer := range origAnswers {
		newAnswer := promotion.QAAnswer{
			UUID:          origAnswer.UUID,
			QuestionID:    newQuestion.ID,
			Nickname:      origAnswer.Nickname,
			AvatarURL:     origAnswer.AvatarURL,
			TitleName:     origAnswer.TitleName,
			Signature:     origAnswer.Signature,
			Level:         origAnswer.Level,
			Content:       origAnswer.Content,
			FollowCount:   origAnswer.FollowCount,
			FavoriteCount: origAnswer.FavoriteCount,
			LikeCount:     origAnswer.LikeCount,
			TimeText:      origAnswer.TimeText,
			Skill:         origAnswer.Skill,
			AuditStatus:   origAnswer.AuditStatus,
			Sort:          origAnswer.Sort,
		}
		if err := tx.Create(&newAnswer).Error; err != nil {
			tx.Rollback()
			return newQuestion, err
		}
		answerIDMap[origAnswer.ID] = newAnswer.ID
	}

	var origReplies []promotion.QAReply
	var answerIDs []uint
	for origID := range answerIDMap {
		answerIDs = append(answerIDs, origID)
	}
	if len(answerIDs) > 0 {
		if err := tx.Where("answer_id IN ?", answerIDs).Order("id asc").Find(&origReplies).Error; err != nil {
			tx.Rollback()
			return newQuestion, err
		}
	}

	for _, origReply := range origReplies {
		newAnswerID := answerIDMap[origReply.AnswerID]
		newReply := promotion.QAReply{
			UUID:          origReply.UUID,
			AnswerID:      newAnswerID,
			ParentID:      origReply.ParentID,
			Nickname:      origReply.Nickname,
			AvatarURL:     origReply.AvatarURL,
			TitleName:     origReply.TitleName,
			Signature:     origReply.Signature,
			Level:         origReply.Level,
			Content:       origReply.Content,
			FollowCount:   origReply.FollowCount,
			FavoriteCount: origReply.FavoriteCount,
			LikeCount:     origReply.LikeCount,
			TimeText:      origReply.TimeText,
			Skill:         origReply.Skill,
			AuditStatus:   origReply.AuditStatus,
			Sort:          origReply.Sort,
		}
		if err := tx.Create(&newReply).Error; err != nil {
			tx.Rollback()
			return newQuestion, err
		}
	}

	if err := tx.Commit().Error; err != nil {
		return newQuestion, err
	}
	return newQuestion, nil
}
