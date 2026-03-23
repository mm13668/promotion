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
	AvatarUrl     string
	Nickname      string
	TitleName     string // 回答者称号
	Level         *int   // 等级（为空时隐藏）
	TimeText      string // 时间文本
	Content       template.HTML
	FollowCount   int // 关注数
	FavoriteCount int // 收藏数
	LikeCount     int // 点赞数
}

// Answer 回答结构
type Answer struct {
	AvatarUrl     string
	Nickname      string
	TitleName     string // 回复者称号
	Level         *int   // 等级（为空时隐藏）
	TimeText      string
	Content       template.HTML
	FollowCount   int // 关注数
	FavoriteCount int // 收藏数
	LikeCount     int // 点赞数
	Replies       []Reply
}

// QaQuestion 问题结构
type QaQuestion struct {
	Title         string
	Label         []string
	Nickname      string
	AvatarUrl     string
	TitleName     string
	TimeAt        string
	Content       template.HTML
	FollowCount   int // 关注数
	LookCount     int // 浏览数
	FavoriteCount int // 收藏数
	LikeCount     int // 点赞数
	Answers       []Answer
}

// TemplateData 模板渲染数据
type TemplateData struct {
	ServiceListJSON       string
	LogoURL               string
	CompanyName           string
	IcpRecordNo           string
	HomepageURL           string
	AboutURL              string
	QrcodeURL             string
	Year                  int
	Show12301Phone        bool
	QuestionTitle         string
	QuestionTags          []string
	QuestionAvatar        string
	QuestionNickname      string
	QuestionTitleName     string
	QuestionTimeAt        string
	QuestionContent       template.HTML
	QuestionFollowCount   int // 问题关注数
	QuestionLookCount     int // 问题浏览数
	QuestionFavoriteCount int // 问题收藏数
	QuestionLikeCount     int // 问题点赞数
	Answers               []Answer
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
	// 处理回答和回复的富文本内容
	processedAnswers := make([]Answer, 0, len(question.Answers))
	for _, ans := range question.Answers {
		processedReplies := make([]Reply, 0, len(ans.Replies))
		for _, reply := range ans.Replies {
			processedReplies = append(processedReplies, Reply{
				AvatarUrl: reply.AvatarUrl,
				Nickname:  reply.Nickname,
				Content:   template.HTML(reply.Content),
			})
		}
		processedAnswers = append(processedAnswers, Answer{
			AvatarUrl: ans.AvatarUrl,
			Nickname:  ans.Nickname,
			TimeText:  ans.TimeText,
			Content:   template.HTML(ans.Content),
			Replies:   processedReplies,
		})
	}

	data := TemplateData{
		CompanyName:           company.CompanyName,
		IcpRecordNo:           company.IcpRecordNo,
		HomepageURL:           company.HomepageURL,
		AboutURL:              company.AboutURL,
		QrcodeURL:             "https://picsum.photos/200/200",
		Year:                  time.Now().Year(),
		Show12301Phone:        basic.Show12301Phone,
		QuestionTitle:         question.Title,
		QuestionTags:          question.Label,
		QuestionNickname:      question.Nickname,
		QuestionTitleName:     question.TitleName,
		QuestionTimeAt:        question.TimeAt,
		QuestionContent:       template.HTML(question.Content),
		QuestionFollowCount:   question.FollowCount,
		QuestionLookCount:     question.LookCount,
		QuestionFavoriteCount: question.FavoriteCount,
		QuestionLikeCount:     question.LikeCount,
		Answers:               processedAnswers,
	}
	if isMobile {
		data.LogoURL = company.LogoMobileURL
	} else {
		data.LogoURL = company.LogoPcURL
	}
	return data
}

// GeneratePageWithData 使用指定数据生成页面并保存到指定路径
func (g *PageGenerator) GeneratePageWithData(data TemplateData, templateName string, plugins map[string]string, isMobile bool, outputPath string) (string, error) {
	// 1. 加载模板
	var templatePath string
	if templateName != "" {
		if isMobile {
			templatePath = fmt.Sprintf("mobile/%s", templateName)
		} else {
			templatePath = fmt.Sprintf("pc/%s", templateName)
		}
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
		"wechat":    "",
		"phone":     "",
		"qrcodeUrl": data.QrcodeURL,
	}

	if isMobile {
		// 注入微信复制插件
		if copyPluginName, ok := plugins["copy"]; ok && copyPluginName != "" {
			if pluginHtml, err := g.LoadPlugin(copyPluginName, pluginData); err == nil {
				html = g.InjectPlugin(html, `<div id="plugin-copy"></div>`, pluginHtml)
			}
		}

		// 注入底部栏插件
		if bottomPluginName, ok := plugins["bottom"]; ok && bottomPluginName != "" {
			if pluginHtml, err := g.LoadPlugin(bottomPluginName, pluginData); err == nil {
				html = g.InjectPlugin(html, `<div id="plugin-bottom"></div>`, pluginHtml)
			}
		}
	} else {
		// 注入PC端二维码插件
		if qrcodePluginName, ok := plugins["qrcode"]; ok && qrcodePluginName != "" {
			if pluginHtml, err := g.LoadPlugin(qrcodePluginName, pluginData); err == nil {
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
