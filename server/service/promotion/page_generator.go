package promotion

import (
	"bytes"
	"crypto/md5"
	"encoding/hex"
	"fmt"
	"html/template"
	"os"
	"path/filepath"
	"strings"
	"time"

	"github.com/flipped-aurora/gin-vue-admin/server/model/promotion"
)

const (
	templateBasePath = "/Users/wangjingjun/work/promotion/server/uploads/template/"
	pluginBasePath   = "/Users/wangjingjun/work/promotion/server/uploads/plugins/"
	distBasePath     = "/Users/wangjingjun/work/promotion/server/dist/"
)

// Reply 回复结构
type Reply struct {
	AvatarUrl string
	Nickname  string
	Content   string
}

// Answer 回答结构
type Answer struct {
	AvatarUrl string
	Nickname  string
	TimeText  string
	Content   string
	Replies   []Reply
}

// QaQuestion 问题结构
type QaQuestion struct {
	Title     string
	Label     []string
	Nickname  string
	AvatarUrl string
	TitleName string
	TimeAt    string
	Content   string
	Answers   []Answer
}

// TemplateData 模板渲染数据
type TemplateData struct {
	Title             string
	Question          string
	Content           string
	Wechat            string
	Phone             string
	LogoURL           string
	CompanyName       string
	IcpRecordNo       string
	HomepageURL       string
	AboutURL          string
	QrcodeURL         string
	Year              int
	Show12301Phone    bool
	QuestionTitle     string
	QuestionTags      []string
	QuestionAvatar    string
	QuestionNickname  string
	QuestionTitleName string
	QuestionTimeAt    string
	QuestionContent   string
	Answers           []Answer
}

// PageGenerator 页面生成器
type PageGenerator struct{}

// LoadTemplate 加载模板
func (g *PageGenerator) LoadTemplate(templatePath string, data TemplateData) (string, error) {
	tpl, err := template.ParseFiles(filepath.Join(templateBasePath, templatePath, "index.html"))
	if err != nil {
		return "", err
	}

	var buf bytes.Buffer
	err = tpl.Execute(&buf, data)
	if err != nil {
		return "", err
	}

	// 合并CSS
	cssPath := filepath.Join(templateBasePath, templatePath, "style.css")
	if cssBytes, err := os.ReadFile(cssPath); err == nil {
		cssStr := fmt.Sprintf("<style>%s</style>", string(cssBytes))
		html := buf.String()
		html = strings.Replace(html, "</head>", cssStr+"</head>", 1)
		buf.Reset()
		buf.WriteString(html)
	}

	// 合并JS
	jsPath := filepath.Join(templateBasePath, templatePath, "script.js")
	if jsBytes, err := os.ReadFile(jsPath); err == nil {
		jsStr := fmt.Sprintf("<script>%s</script>", string(jsBytes))
		html := buf.String()
		html = strings.Replace(html, "</body>", jsStr+"</body>", 1)
		buf.Reset()
		buf.WriteString(html)
	}

	return buf.String(), nil
}

// LoadPlugin 加载插件
func (g *PageGenerator) LoadPlugin(pluginName string, data map[string]string) (string, error) {
	pluginPath := filepath.Join(pluginBasePath, pluginName, "index.html")
	contentBytes, err := os.ReadFile(pluginPath)
	if err != nil {
		return "", err
	}

	content := string(contentBytes)
	// 变量替换
	for k, v := range data {
		content = strings.ReplaceAll(content, "{{"+k+"}}", v)
	}

	return content, nil
}

// InjectPlugin 注入插件到HTML
func (g *PageGenerator) InjectPlugin(html string, selector string, pluginHTML string) string {
	return strings.Replace(html, selector, pluginHTML, 1)
}

// BuildTemplateData 组装模板数据
func (g *PageGenerator) BuildTemplateData(link promotion.PromotionLink, basic promotion.PromotionLinkBasic, company promotion.PromotionLinkCompany, question QaQuestion, isMobile bool) TemplateData {
	data := TemplateData{
		Title:             "专业咨询服务",
		Question:          "您有什么问题需要咨询？",
		Content:           "我们提供专业的一对一咨询服务，经验丰富，价格透明，欢迎添加微信咨询。",
		Wechat:            "kefu123",
		Phone:             "400-123-4567",
		CompanyName:       company.CompanyName,
		IcpRecordNo:       company.IcpRecordNo,
		HomepageURL:       company.HomepageURL,
		AboutURL:          company.AboutURL,
		QrcodeURL:         "https://picsum.photos/200/200",
		Year:              time.Now().Year(),
		Show12301Phone:    basic.Show12301Phone,
		QuestionTitle:     question.Title,
		QuestionTags:      question.Label,
		QuestionNickname:  question.Nickname,
		QuestionTitleName: question.TitleName,
		QuestionTimeAt:    question.TimeAt,
		QuestionContent:   question.Content,
		Answers:           question.Answers,
	}
	if isMobile {
		data.LogoURL = company.LogoMobileURL
	} else {
		data.LogoURL = company.LogoPcURL
	}
	return data
}

// GeneratePageWithData 使用指定数据生成页面并保存到指定路径
func (g *PageGenerator) GeneratePageWithData(link promotion.PromotionLink, basic promotion.PromotionLinkBasic, data TemplateData, isMobile bool, outputPath string) (string, error) {
	// 1. 加载模板
	var templatePath string
	if isMobile && basic.TemplateMobileId != nil {
		templatePath = fmt.Sprintf("mobile/template-%02d", *basic.TemplateMobileId%8+1)
	} else if !isMobile && basic.TemplatePcId != nil {
		templatePath = fmt.Sprintf("pc/template-%02d", *basic.TemplatePcId%5+1)
	} else {
		// 默认模板
		if isMobile {
			templatePath = "mobile/template-01"
		} else {
			templatePath = "pc/template-01"
		}
	}

	html, err := g.LoadTemplate(templatePath, data)
	if err != nil {
		return "", err
	}

	// 2. 注入插件
	pluginData := map[string]string{
		"wechat":    data.Wechat,
		"phone":     data.Phone,
		"qrcodeUrl": data.QrcodeURL,
	}

	if isMobile {
		// 注入微信复制插件
		if basic.MobileCopyWidgetId != nil && *basic.MobileCopyWidgetId > 0 {
			pluginName := fmt.Sprintf("wechat-copy-%d", *basic.MobileCopyWidgetId%3+1)
			if pluginHtml, err := g.LoadPlugin(pluginName, pluginData); err == nil {
				html = g.InjectPlugin(html, `<div id="plugin-copy"></div>`, pluginHtml)
			}
		}

		// 注入底部栏插件
		if basic.MobileBottomWidgetId != nil && *basic.MobileBottomWidgetId > 0 {
			pluginName := fmt.Sprintf("bottom-bar-%d", *basic.MobileBottomWidgetId%3+1)
			if pluginHtml, err := g.LoadPlugin(pluginName, pluginData); err == nil {
				html = g.InjectPlugin(html, `<div id="plugin-bottom"></div>`, pluginHtml)
			}
		}
	} else {
		// 注入PC端二维码插件
		if basic.PcQrcodeWidgetId != nil && *basic.PcQrcodeWidgetId > 0 {
			pluginName := fmt.Sprintf("pc-qrcode-%d", *basic.PcQrcodeWidgetId%3+1)
			if pluginHtml, err := g.LoadPlugin(pluginName, pluginData); err == nil {
				html = g.InjectPlugin(html, `<div id="plugin-qrcode"></div>`, pluginHtml)
			}
		}
	}

	// 3. 写入文件
	err = os.WriteFile(outputPath, []byte(html), 0644)
	if err != nil {
		return "", err
	}

	return outputPath, nil
}

// generateCacheKey 生成缓存key
func (g *PageGenerator) generateCacheKey(link promotion.PromotionLink, basic promotion.PromotionLinkBasic, company promotion.PromotionLinkCompany, isMobile bool) string {
	var tplMobileId, tplPcId, copyId, bottomId, qrcodeId uint = 0, 0, 0, 0, 0
	if basic.TemplateMobileId != nil {
		tplMobileId = *basic.TemplateMobileId
	}
	if basic.TemplatePcId != nil {
		tplPcId = *basic.TemplatePcId
	}
	if basic.MobileCopyWidgetId != nil {
		copyId = *basic.MobileCopyWidgetId
	}
	if basic.MobileBottomWidgetId != nil {
		bottomId = *basic.MobileBottomWidgetId
	}
	if basic.PcQrcodeWidgetId != nil {
		qrcodeId = *basic.PcQrcodeWidgetId
	}
	str := fmt.Sprintf("%d-%d-%d-%d-%d-%d-%v",
		link.ID,
		tplMobileId,
		tplPcId,
		copyId,
		bottomId,
		qrcodeId,
		isMobile)
	hash := md5.Sum([]byte(str))
	return hex.EncodeToString(hash[:])
}
