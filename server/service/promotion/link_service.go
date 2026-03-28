package promotion

import (
	"encoding/json"
	"fmt"
	"html/template"
	"math/rand"
	"os"
	"path/filepath"
	"time"

	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/request"
	"github.com/flipped-aurora/gin-vue-admin/server/model/promotion"
)

// GroupMember 客服成员结构体
type GroupMember struct {
	Nickname string `json:"nickname"`
	Wechat   string `json:"wechat"`
	Mobile   string `json:"mobile"`
}

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

	// 查询问题详情
	var question QaQuestion
	if link.QuestionID != nil {
		// 1. 查询问题基本信息
		var qaQuestion promotion.QAQuestion
		if err := global.GVA_DB.Debug().Where("id = ?", *link.QuestionID).First(&qaQuestion).Error; err != nil {
			return err
		}

		// 2. 查询回答列表
		var qaAnswers []promotion.QAAnswer
		if err := global.GVA_DB.Debug().Where("question_id = ? AND audit_status = 1", *link.QuestionID).Find(&qaAnswers).Error; err != nil {
			return err
		}

		// 3. 组装回答和回复
		answers := make([]Answer, 0, len(qaAnswers))
		for _, qaAnswer := range qaAnswers {
			// 查询每个回答的回复
			var qaReplies []promotion.QAReply
			if err := global.GVA_DB.Debug().Where("answer_id = ? AND audit_status = 1", qaAnswer.ID).Find(&qaReplies).Error; err != nil {
				return err
			}

			// 组装回复
			replies := make([]Reply, 0, len(qaReplies))
			for _, qaReply := range qaReplies {
				var level *int
				if qaReply.Level != nil {
					l := int(*qaReply.Level)
					level = &l
				}
				replies = append(replies, Reply{
					AvatarUrl:     qaReply.AvatarURL,
					Nickname:      qaReply.Nickname,
					TitleName:     qaReply.TitleName,
					Level:         level,
					TimeText:      qaReply.TimeText,
					Content:       template.HTML(qaReply.Content),
					FollowCount:   int(qaReply.FollowCount),
					FavoriteCount: int(qaReply.FavoriteCount),
					LikeCount:     int(qaReply.LikeCount),
				})
			}

			// 组装回答
			answers = append(answers, Answer{
				AvatarUrl:     qaAnswer.AvatarURL,
				Nickname:      qaAnswer.Nickname,
				TitleName:     qaAnswer.TitleName,
				Level:         int(*qaAnswer.Level),
				TimeText:      qaAnswer.TimeText,
				Content:       template.HTML(qaAnswer.Content),
				FollowCount:   int(qaAnswer.FollowCount),
				FavoriteCount: int(qaAnswer.FavoriteCount),
				LikeCount:     int(qaAnswer.LikeCount),
				Replies:       replies,
			})
		}

		// 组装问题
		question = QaQuestion{
			Title:         qaQuestion.Title,
			Label:         qaQuestion.Label,
			Nickname:      qaQuestion.Nickname,
			AvatarUrl:     qaQuestion.AvatarURL,
			TitleName:     qaQuestion.TitleName,
			TimeAt:        qaQuestion.TimeAt,
			Content:       template.HTML(qaQuestion.Content),
			FollowCount:   int(qaQuestion.FollowCount),
			LookCount:     int(qaQuestion.LookCount),
			FavoriteCount: int(qaQuestion.FavoriteCount),
			LikeCount:     int(qaQuestion.LikeCount),
			Answers:       answers,
		}
	} else {
		// 默认问题
		question = QaQuestion{
			Title:         "专业咨询服务",
			Label:         []string{"服务", "咨询", "一对一"},
			Nickname:      "官方客服",
			AvatarUrl:     "https://picsum.photos/100/100",
			TimeAt:        time.Now().Format("2006-01-02 15:04"),
			Content:       template.HTML("我们提供专业的一对一咨询服务，经验丰富，价格透明，欢迎添加微信咨询。"),
			FollowCount:   0,
			LookCount:     0,
			FavoriteCount: 0,
			LikeCount:     0,
			Answers:       []Answer{},
		}
	}

	// 4. 查询所有客服信息，用于前端随机展示
	var serviceListJSON string = "[]"
	if link.RegionID != nil && link.GroupID != nil {
		var members []GroupMember
		if err := global.GVA_DB.Table("group_member").Select("nickname, wechat, mobile").Where("region_id = ? AND group_id = ? AND status=1 AND deleted_at IS NULL", *link.RegionID, *link.GroupID).Find(&members).Error; err == nil && len(members) > 0 {
			// 序列化所有客服为JSON字符串
			if jsonBytes, err := json.Marshal(members); err == nil {
				serviceListJSON = string(jsonBytes)
			}
		}
	}

	// 5. 查询模板和插件信息
	var mobileTemplateName, pcTemplateName string
	var copyPluginName, bottomPluginName, qrcodePluginName string

	// 查询移动端模板
	if basic.TemplateMobileId != nil {
		var widget promotion.PromotionTemplateWidget
		if err := global.GVA_DB.Where("id = ?", *basic.TemplateMobileId).First(&widget).Error; err == nil {
			mobileTemplateName = widget.Name
		}
	}

	// 查询PC端模板
	if basic.TemplatePcId != nil {
		var widget promotion.PromotionTemplateWidget
		if err := global.GVA_DB.Where("id = ?", *basic.TemplatePcId).First(&widget).Error; err == nil {
			pcTemplateName = widget.Name
		}
	}

	// 查询微信复制插件
	if basic.MobileCopyWidgetId != nil {
		var widget promotion.PromotionTemplateWidget
		if err := global.GVA_DB.Where("id = ?", *basic.MobileCopyWidgetId).First(&widget).Error; err == nil {
			copyPluginName = widget.Name
		}
	}

	// 查询底部栏插件
	if basic.MobileBottomWidgetId != nil {
		var widget promotion.PromotionTemplateWidget
		if err := global.GVA_DB.Where("id = ?", *basic.MobileBottomWidgetId).First(&widget).Error; err == nil {
			bottomPluginName = widget.Name
		}
	}

	// 查询PC端二维码插件
	if basic.PcQrcodeWidgetId != nil {
		var widget promotion.PromotionTemplateWidget
		if err := global.GVA_DB.Where("id = ?", *basic.PcQrcodeWidgetId).First(&widget).Error; err == nil {
			qrcodePluginName = widget.Name
		}
	}

	// 5. 生成页面
	generator := &PageGenerator{}

	// 创建随机编号目录
	randomDir := filepath.Join(global.GVA_CONFIG.Local.DistBasePath, link.RandomCode)
	os.MkdirAll(filepath.Join(randomDir, "m"), 0755)
	os.MkdirAll(filepath.Join(randomDir, "pc"), 0755)

	databyte, _ := json.Marshal(question)
	fmt.Println("databyte", string(databyte))

	// 生成移动端页面
	mobileData := generator.BuildTemplateData(link, basic, company, question, true)
	// 替换客服信息
	mobileData.ServiceListJSON = serviceListJSON
	mobilePlugins := map[string]string{
		"copy":   copyPluginName,
		"bottom": bottomPluginName,
	}
	_, err := generator.GeneratePageWithData(mobileData, mobileTemplateName, mobilePlugins, true, filepath.Join(randomDir, "m", "index.html"))
	if err != nil {
		return err
	}
	// 生成PC端页面
	pcData := generator.BuildTemplateData(link, basic, company, question, false)
	// 替换客服信息
	pcData.ServiceListJSON = serviceListJSON
	pcPlugins := map[string]string{
		"qrcode": qrcodePluginName,
	}
	_, err = generator.GeneratePageWithData(pcData, pcTemplateName, pcPlugins, false, filepath.Join(randomDir, "pc", "index.html"))
	if err != nil {
		return err
	}
	// 5. 更新链接地址
	link.MobileUrl = "/p/" + link.RandomCode + "/m/index.html"
	link.PcUrl = "/p/" + link.RandomCode + "/pc/index.html"
	//http://localhost:8080/api/h5ldy/V4N9HIZs/m/
	domain, _ := DomainServiceObj.FindPromotionDomain(*link.DomainID)
	if domain.ID > 0 {
		accessPath := domain.Domain + "/api" + global.GVA_CONFIG.Local.DistH5Path + "/" + link.RandomCode
		link.MobileUrl = accessPath + "/m/index.html"
		link.PcUrl = accessPath + "/pc/index.html"
	}

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
