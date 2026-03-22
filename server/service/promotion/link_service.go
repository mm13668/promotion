package promotion

import (
	"math/rand"
	"os"
	"path/filepath"
	"time"

	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/request"
	"github.com/flipped-aurora/gin-vue-admin/server/model/promotion"
)

type LinkService struct{}

func (s *LinkService) CreatePromotionLink(e promotion.PromotionLink) error {
	return global.GVA_DB.Create(&e).Error
}

func (s *LinkService) DeletePromotionLink(e promotion.PromotionLink) error {
	return global.GVA_DB.Delete(&e).Error
}

func (s *LinkService) UpdatePromotionLink(e *promotion.PromotionLink) error {
	return global.GVA_DB.Save(e).Error
}

func (s *LinkService) FindPromotionLink(id uint) (promotion.PromotionLink, error) {
	var data promotion.PromotionLink
	err := global.GVA_DB.Where("id = ?", id).First(&data).Error
	return data, err
}

type LinkFilter struct {
	PlatformID *uint
	RegionID   *uint
	GroupID    *uint
	DomainID   *uint
}

func (s *LinkService) GetPromotionLinkList(info request.PageInfo, f LinkFilter) (list []promotion.PromotionLink, total int64, err error) {
	limit := info.PageSize
	offset := info.PageSize * (info.Page - 1)
	db := global.GVA_DB.Model(&promotion.PromotionLink{})
	if f.PlatformID != nil {
		db = db.Where("platform_id = ?", *f.PlatformID)
	}
	if f.RegionID != nil {
		db = db.Where("region_id = ?", *f.RegionID)
	}
	if f.GroupID != nil {
		db = db.Where("group_id = ?", *f.GroupID)
	}
	if f.DomainID != nil {
		db = db.Where("domain_id = ?", *f.DomainID)
	}
	err = db.Count(&total).Error
	if err != nil {
		return
	}
	err = db.Limit(limit).Offset(offset).Order("sort desc,id desc").Find(&list).Error
	return
}

func (s *LinkService) UpsertBasic(e *promotion.PromotionLinkBasic) error {
	var exist promotion.PromotionLinkBasic
	tx := global.GVA_DB.Where("link_id = ?", e.LinkID).First(&exist)
	if tx.Error == nil {
		e.ID = exist.ID
		return global.GVA_DB.Save(e).Error
	}
	return global.GVA_DB.Create(e).Error
}

func (s *LinkService) GetBasic(linkId uint) (promotion.PromotionLinkBasic, error) {
	var data promotion.PromotionLinkBasic
	err := global.GVA_DB.Where("link_id = ?", linkId).First(&data).Error
	return data, err
}

func (s *LinkService) UpsertCompany(e *promotion.PromotionLinkCompany) error {
	var exist promotion.PromotionLinkCompany
	tx := global.GVA_DB.Where("link_id = ?", e.LinkID).First(&exist)
	if tx.Error == nil {
		e.ID = exist.ID
		return global.GVA_DB.Save(e).Error
	}
	return global.GVA_DB.Create(e).Error
}

func (s *LinkService) GetCompany(linkId uint) (promotion.PromotionLinkCompany, error) {
	var data promotion.PromotionLinkCompany
	err := global.GVA_DB.Where("link_id = ?", linkId).First(&data).Error
	return data, err
}

func (s *LinkService) UpsertCode(e *promotion.PromotionLinkCode) error {
	var exist promotion.PromotionLinkCode
	tx := global.GVA_DB.Where("link_id = ?", e.LinkID).First(&exist)
	if tx.Error == nil {
		e.ID = exist.ID
		return global.GVA_DB.Save(e).Error
	}
	return global.GVA_DB.Create(e).Error
}

func (s *LinkService) GetCode(linkId uint) (promotion.PromotionLinkCode, error) {
	var data promotion.PromotionLinkCode
	err := global.GVA_DB.Where("link_id = ?", linkId).First(&data).Error
	return data, err
}

func (s *LinkService) UpsertTheme(e *promotion.PromotionLinkTheme) error {
	var exist promotion.PromotionLinkTheme
	tx := global.GVA_DB.Where("link_id = ?", e.LinkID).First(&exist)
	if tx.Error == nil {
		e.ID = exist.ID
		return global.GVA_DB.Save(e).Error
	}
	return global.GVA_DB.Create(e).Error
}

func (s *LinkService) GetTheme(linkId uint) (promotion.PromotionLinkTheme, error) {
	var data promotion.PromotionLinkTheme
	err := global.GVA_DB.Where("link_id = ?", linkId).First(&data).Error
	return data, err
}

func (s *LinkService) UpsertComment(e *promotion.PromotionLinkComment) error {
	var exist promotion.PromotionLinkComment
	tx := global.GVA_DB.Where("link_id = ?", e.LinkID).First(&exist)
	if tx.Error == nil {
		e.ID = exist.ID
		return global.GVA_DB.Save(e).Error
	}
	return global.GVA_DB.Create(e).Error
}

func (s *LinkService) GetComment(linkId uint) (promotion.PromotionLinkComment, error) {
	var data promotion.PromotionLinkComment
	err := global.GVA_DB.Where("link_id = ?", linkId).First(&data).Error
	return data, err
}

// 模板插件管理
func (s *LinkService) CreateTemplateWidget(e promotion.PromotionTemplateWidget) error {
	return global.GVA_DB.Create(&e).Error
}

func (s *LinkService) DeleteTemplateWidget(e promotion.PromotionTemplateWidget) error {
	return global.GVA_DB.Delete(&e).Error
}

func (s *LinkService) UpdateTemplateWidget(e *promotion.PromotionTemplateWidget) error {
	return global.GVA_DB.Save(e).Error
}

func (s *LinkService) FindTemplateWidget(id uint) (promotion.PromotionTemplateWidget, error) {
	var data promotion.PromotionTemplateWidget
	err := global.GVA_DB.Where("id = ?", id).First(&data).Error
	return data, err
}

type TemplateWidgetFilter struct {
	Type *uint8
}

func (s *LinkService) GetTemplateWidgetList(info request.PageInfo, f TemplateWidgetFilter) (list []promotion.PromotionTemplateWidget, total int64, err error) {
	limit := info.PageSize
	offset := info.PageSize * (info.Page - 1)
	db := global.GVA_DB.Model(&promotion.PromotionTemplateWidget{})
	if f.Type != nil {
		db = db.Where("type = ?", *f.Type)
	}
	err = db.Count(&total).Error
	if err != nil {
		return
	}
	err = db.Limit(limit).Offset(offset).Order("id desc").Find(&list).Error
	return
}

// PublishPromotionLink 发布推广链接，生成移动端和PC端页面
func (s *LinkService) PublishPromotionLink(linkId uint) error {
	// 1. 查询链接信息
	var link promotion.PromotionLink
	if err := global.GVA_DB.Where("id = ?", linkId).First(&link).Error; err != nil {
		return err
	}

	// 2. 生成随机编号（如果不存在）
	if link.RandomCode == "" {
		link.RandomCode = generateRandomCode(8)
	}

	// 3. 查询关联配置
	var basic promotion.PromotionLinkBasic
	if err := global.GVA_DB.Where("link_id = ?", linkId).First(&basic).Error; err != nil {
		return err
	}

	var company promotion.PromotionLinkCompany
	if err := global.GVA_DB.Where("link_id = ?", linkId).First(&company).Error; err != nil {
		return err
	}

	// 查询问题详情（临时填充模拟数据，后续可对接真实QA表）
	var question QaQuestion
	if link.QuestionID != nil {
		// 这里可以扩展查询真实的问题和回答数据
		question = QaQuestion{
			Title:     "常见问题咨询",
			Label:     []string{"咨询", "服务", "专业"},
			Nickname:  "匿名用户",
			AvatarUrl: "https://picsum.photos/100/100",
			TimeAt:    time.Now().Format("2006-01-02 15:04"),
			Content:   "我想咨询一下相关服务的具体流程和收费标准是怎样的？",
			Answers: []Answer{
				{
					AvatarUrl: "https://picsum.photos/100/100",
					Nickname:  "客服小王",
					TimeText:  "1小时前",
					Content:   "您好，我们的服务流程非常简单，您只需要添加我们的客服微信，说明您的需求，我们会为您安排专业的顾问对接，收费根据您的需求而定，透明公开，没有隐形消费。",
					Replies: []Reply{
						{
							AvatarUrl: "https://picsum.photos/100/100",
							Nickname:  "匿名用户",
							Content:   "好的，我现在就加微信咨询，谢谢！",
						},
					},
				},
			},
		}
	} else {
		// 默认问题
		question = QaQuestion{
			Title:     "专业咨询服务",
			Label:     []string{"服务", "咨询", "一对一"},
			Nickname:  "官方客服",
			AvatarUrl: "https://picsum.photos/100/100",
			TimeAt:    time.Now().Format("2006-01-02 15:04"),
			Content:   "我们提供专业的一对一咨询服务，经验丰富，价格透明，欢迎添加微信咨询。",
			Answers:   []Answer{},
		}
	}

	// 4. 生成页面
	generator := &PageGenerator{}
	const distBasePath = "/Users/wangjingjun/work/promotion/server/dist/"

	// 创建随机编号目录
	randomDir := filepath.Join(distBasePath, link.RandomCode)
	os.MkdirAll(filepath.Join(randomDir, "m"), 0755)
	os.MkdirAll(filepath.Join(randomDir, "pc"), 0755)

	// 生成移动端页面
	mobileData := generator.BuildTemplateData(link, basic, company, question, true)
	_, err := generator.GeneratePageWithData(link, basic, mobileData, true, filepath.Join(randomDir, "m", "index.html"))
	if err != nil {
		return err
	}
	// 生成PC端页面
	pcData := generator.BuildTemplateData(link, basic, company, question, false)
	_, err = generator.GeneratePageWithData(link, basic, pcData, false, filepath.Join(randomDir, "pc", "index.html"))
	if err != nil {
		return err
	}

	// 5. 更新链接地址
	link.MobileUrl = "/p/" + link.RandomCode + "/m/"
	link.PcUrl = "/p/" + link.RandomCode + "/pc/"

	return global.GVA_DB.Save(&link).Error
}

// generateRandomCode 生成指定长度的随机字符串
func generateRandomCode(length int) string {
	const charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
	b := make([]byte, length)
	for i := range b {
		b[i] = charset[rand.Intn(len(charset))]
	}
	return string(b)
}
