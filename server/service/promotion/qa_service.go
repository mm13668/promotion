package promotion

import (
	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/request"
	"github.com/flipped-aurora/gin-vue-admin/server/model/promotion"
)

type QAService struct{}

func (s *QAService) CreateQuestion(e promotion.QAQuestion) error {
	return global.GVA_DB.Create(&e).Error
}
func (s *QAService) UpdateQuestion(e *promotion.QAQuestion) error {
	return global.GVA_DB.Save(e).Error
}
func (s *QAService) DeleteQuestion(e promotion.QAQuestion) error {
	return global.GVA_DB.Delete(&e).Error
}
func (s *QAService) FindQuestion(id uint) (promotion.QAQuestion, error) {
	var data promotion.QAQuestion
	err := global.GVA_DB.Where("id = ?", id).First(&data).Error
	return data, err
}
func (s *QAService) GetQuestionList(info request.PageInfo) (list []promotion.QAQuestion, total int64, err error) {
	limit := info.PageSize
	offset := info.PageSize * (info.Page - 1)
	db := global.GVA_DB.Model(&promotion.QAQuestion{})
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
func (s *QAService) DeleteAnswer(e promotion.QAAnswer) error {
	return global.GVA_DB.Delete(&e).Error
}
func (s *QAService) FindAnswer(id uint) (promotion.QAAnswer, error) {
	var data promotion.QAAnswer
	err := global.GVA_DB.Where("id = ?", id).First(&data).Error
	return data, err
}
func (s *QAService) GetAnswerList(info request.PageInfo) (list []promotion.QAAnswer, total int64, err error) {
	limit := info.PageSize
	offset := info.PageSize * (info.Page - 1)
	db := global.GVA_DB.Model(&promotion.QAAnswer{})
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
func (s *QAService) DeleteReply(e promotion.QAReply) error {
	return global.GVA_DB.Delete(&e).Error
}
func (s *QAService) FindReply(id uint) (promotion.QAReply, error) {
	var data promotion.QAReply
	err := global.GVA_DB.Where("id = ?", id).First(&data).Error
	return data, err
}
func (s *QAService) GetReplyList(info request.PageInfo) (list []promotion.QAReply, total int64, err error) {
	limit := info.PageSize
	offset := info.PageSize * (info.Page - 1)
	db := global.GVA_DB.Model(&promotion.QAReply{})
	err = db.Count(&total).Error
	if err != nil {
		return
	}
	err = db.Limit(limit).Offset(offset).Order("id desc").Find(&list).Error
	return
}

