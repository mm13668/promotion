package promotion

import (
	"fmt"
	"html/template"
	"os"
	"path/filepath"
	"time"

	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/promotion"
	"go.uber.org/zap"
)

type NewsService struct{}

var NewsServiceApp = new(NewsService)

func (s *NewsService) CreateNews(e promotion.News) (err error) {
	err = global.GVA_DB.Create(&e).Error
	return err
}

func (s *NewsService) DeleteNews(e promotion.News) (err error) {
	err = global.GVA_DB.Delete(&e).Error
	return err
}

func (s *NewsService) UpdateNews(e *promotion.News) (err error) {
	updates := map[string]interface{}{
		"title":           e.Title,
		"summary":         e.Summary,
		"content":         e.Content,
		"cover_image":     e.CoverImage,
		"author":          e.Author,
		"category_id":     e.CategoryID,
		"source":          e.Source,
		"source_url":      e.SourceURL,
		"status":          e.Status,
		"sort":            e.Sort,
		"seo_keywords":    e.SeoKeywords,
		"seo_description": e.SeoDescription,
	}
	if e.IsTop != nil {
		updates["is_top"] = *e.IsTop
	}
	err = global.GVA_DB.Model(&promotion.News{}).Where("id = ?", e.ID).Updates(updates).Error
	return
}

func (s *NewsService) FindNews(id uint) (news promotion.News, err error) {
	err = global.GVA_DB.Where("id = ?", id).First(&news).Error
	return
}

func (s *NewsService) GetNewsList(info promotion.NewsSearch) (list []promotion.News, total int64, err error) {
	limit := info.PageSize
	offset := info.PageSize * (info.Page - 1)
	db := global.GVA_DB.Model(&promotion.News{})

	if info.Title != "" {
		db = db.Where("title LIKE ?", "%"+info.Title+"%")
	}
	if info.CategoryID != nil {
		db = db.Where("category_id = ?", *info.CategoryID)
	}
	if info.Status != nil {
		db = db.Where("status = ?", *info.Status)
	}

	err = db.Count(&total).Error
	if err != nil {
		return
	}
	err = db.Preload("Category").Order("sort asc, id desc").Limit(limit).Offset(offset).Find(&list).Error
	if err != nil {
		return
	}
	for i := range list {
		if list[i].Category.ID > 0 {
			list[i].CategoryName = list[i].Category.Name
		}
	}
	return
}

// PublishNews 发布新闻，生成静态HTML页面
func (s *NewsService) PublishNews(id uint) (publishedPath string, err error) {
	news, err := s.FindNews(id)
	if err != nil {
		return "", fmt.Errorf("新闻不存在: %w", err)
	}

	basePath := "uploads/news"
	dir := filepath.Join(basePath, fmt.Sprintf("%d", id))
	outputPath := filepath.Join(dir, "index.html")

	if err := os.MkdirAll(dir, 0755); err != nil {
		return "", fmt.Errorf("创建目录失败: %w", err)
	}

	var publishTime string
	if news.PublishTime != nil {
		publishTime = news.PublishTime.Format("2006-01-02 15:04:05")
	} else {
		publishTime = news.CreatedAt.Format("2006-01-02 15:04:05")
	}

	isTop := false
	if news.IsTop != nil {
		isTop = *news.IsTop
	}

	statusText := "草稿"
	if news.Status == 1 {
		statusText = "已发布"
	}

	newsPath := fmt.Sprintf("/news/%d", id)

	data := struct {
		Title          string
		Summary        string
		Content        template.HTML
		CoverImage     string
		Author         string
		Category       string
		Source         string
		SourceURL      string
		StatusText     string
		IsTop          bool
		PublishTime    string
		ViewCount      int
		LikeCount      int
		SeoKeywords    string
		SeoDescription string
		NewsPath       string
		Year           int
	}{
		Title:          news.Title,
		Summary:        news.Summary,
		Content:        template.HTML(news.Content),
		CoverImage:     news.CoverImage,
		Author:         news.Author,
		Category:       s.resolveCategoryName(news.CategoryID),
		Source:         news.Source,
		SourceURL:      news.SourceURL,
		StatusText:     statusText,
		IsTop:          isTop,
		PublishTime:    publishTime,
		ViewCount:      news.ViewCount,
		LikeCount:      news.LikeCount,
		SeoKeywords:    news.SeoKeywords,
		SeoDescription: news.SeoDescription,
		NewsPath:       newsPath,
		Year:           time.Now().Year(),
	}

	tmpl, err := template.New("news").Parse(newsHTMLTemplate)
	if err != nil {
		return "", fmt.Errorf("解析模板失败: %w", err)
	}

	f, err := os.Create(outputPath)
	if err != nil {
		return "", fmt.Errorf("创建文件失败: %w", err)
	}
	defer f.Close()

	if err := tmpl.Execute(f, data); err != nil {
		return "", fmt.Errorf("渲染模板失败: %w", err)
	}

	publishedPath = newsPath

	err = global.GVA_DB.Model(&promotion.News{}).Where("id = ?", id).Updates(map[string]interface{}{
		"published_path": publishedPath,
		"status":         1,
		"publish_time":   time.Now(),
	}).Error
	if err != nil {
		global.GVA_LOG.Error("更新新闻发布状态失败", zap.Error(err))
	}

	return publishedPath, nil
}

// resolveCategoryName 根据分类ID获取分类名称
func (s *NewsService) resolveCategoryName(categoryID uint) string {
	if categoryID == 0 {
		return ""
	}
	var cat promotion.NewsCategory
	if err := global.GVA_DB.Where("id = ?", categoryID).First(&cat).Error; err != nil {
		return ""
	}
	return cat.Name
}

// FindNewsWithCategory 查询新闻详情（含分类信息）
func (s *NewsService) FindNewsWithCategory(id uint) (news promotion.News, err error) {
	err = global.GVA_DB.Preload("Category").Where("id = ?", id).First(&news).Error
	if err != nil {
		return
	}
	if news.Category.ID > 0 {
		news.CategoryName = news.Category.Name
	}
	return
}

const newsHTMLTemplate = `<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{{.Title}}</title>
    <meta name="keywords" content="{{.SeoKeywords}}">
    <meta name="description" content="{{.SeoDescription}}">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, "Noto Sans SC", sans-serif;
            background: #f5f5f5;
            color: #333;
            line-height: 1.8;
        }
        .news-wrapper {
            max-width: 800px;
            margin: 0 auto;
            background: #fff;
            min-height: 100vh;
            padding: 40px 30px;
        }
        .news-header {
            margin-bottom: 30px;
            border-bottom: 1px solid #eee;
            padding-bottom: 20px;
        }
        .news-title {
            font-size: 28px;
            font-weight: 700;
            color: #1a1a1a;
            line-height: 1.4;
            margin-bottom: 15px;
        }
        .news-meta {
            font-size: 14px;
            color: #999;
            display: flex;
            flex-wrap: wrap;
            gap: 16px;
        }
        .news-meta span { display: inline-flex; align-items: center; gap: 4px; }
        .news-meta .is-top {
            display: inline-block;
            padding: 1px 8px;
            background: #e6f7ff;
            color: #1890ff;
            border-radius: 3px;
            font-size: 12px;
        }
        .news-meta .category {
            display: inline-block;
            padding: 1px 10px;
            background: #f0f5ff;
            color: #2f54eb;
            border-radius: 3px;
            font-size: 12px;
        }
        .news-cover {
            margin-bottom: 24px;
            text-align: center;
        }
        .news-cover img {
            max-width: 100%;
            max-height: 400px;
            border-radius: 8px;
            object-fit: cover;
        }
        .news-summary {
            font-size: 16px;
            color: #666;
            line-height: 1.8;
            padding: 16px 20px;
            background: #fafafa;
            border-left: 4px solid #1890ff;
            border-radius: 4px;
            margin-bottom: 24px;
        }
        .news-content {
            font-size: 16px;
            color: #333;
            line-height: 1.8;
        }
        .news-content h1, .news-content h2, .news-content h3,
        .news-content h4, .news-content h5, .news-content h6 {
            margin: 24px 0 12px;
            font-weight: 600;
            color: #1a1a1a;
        }
        .news-content h1 { font-size: 24px; }
        .news-content h2 { font-size: 20px; }
        .news-content h3 { font-size: 18px; }
        .news-content p { margin-bottom: 16px; }
        .news-content img {
            max-width: 100%;
            height: auto;
            border-radius: 4px;
            margin: 12px 0;
        }
        .news-content a { color: #1890ff; text-decoration: none; }
        .news-content a:hover { text-decoration: underline; }
        .news-content blockquote {
            margin: 16px 0;
            padding: 12px 20px;
            border-left: 4px solid #1890ff;
            background: #f6f8fa;
            color: #666;
        }
        .news-content ul, .news-content ol { padding-left: 24px; margin-bottom: 16px; }
        .news-content li { margin-bottom: 8px; }
        .news-content table {
            width: 100%;
            border-collapse: collapse;
            margin: 16px 0;
        }
        .news-content table th, .news-content table td {
            border: 1px solid #e0e0e0;
            padding: 8px 12px;
            text-align: left;
        }
        .news-content table th { background: #fafafa; font-weight: 600; }
        .news-content pre {
            background: #f6f8fa;
            padding: 16px;
            border-radius: 4px;
            overflow-x: auto;
            font-size: 14px;
            margin-bottom: 16px;
        }
        .news-content code {
            background: #f0f0f0;
            padding: 2px 6px;
            border-radius: 3px;
            font-size: 14px;
        }
        .news-content pre code { background: none; padding: 0; }
        .news-content hr {
            border: none;
            border-top: 1px solid #eee;
            margin: 24px 0;
        }
        .news-footer {
            margin-top: 30px;
            padding-top: 16px;
            border-top: 1px solid #eee;
            font-size: 13px;
            color: #999;
        }
        .news-footer a { color: #1890ff; text-decoration: none; }
        @media (max-width: 640px) {
            .news-wrapper { padding: 20px 16px; }
            .news-title { font-size: 22px; }
            .news-meta { font-size: 12px; gap: 10px; }
            .news-content { font-size: 15px; }
        }
    </style>
</head>
<body>
    <div class="news-wrapper">
        <div class="news-header">
            <h1 class="news-title">{{.Title}}</h1>
            <div class="news-meta">
                {{if .Category}}<span class="category">{{.Category}}</span>{{end}}
                {{if .IsTop}}<span class="is-top">置顶</span>{{end}}
                {{if .Author}}<span>作者: {{.Author}}</span>{{end}}
                {{if .PublishTime}}<span>发布时间: {{.PublishTime}}</span>{{end}}
                {{if .Source}}<span>来源: {{if .SourceURL}}<a href="{{.SourceURL}}" target="_blank" rel="noopener">{{.Source}}</a>{{else}}{{.Source}}{{end}}</span>{{end}}
                <span>浏览: {{.ViewCount}}</span>
            </div>
        </div>
        {{if .CoverImage}}
        <div class="news-cover">
            <img src="{{.CoverImage}}" alt="{{.Title}}" onerror="this.style.display='none'">
        </div>
        {{end}}
        {{if .Summary}}
        <div class="news-summary">{{.Summary}}</div>
        {{end}}
        <div class="news-content">{{.Content}}</div>
        <div class="news-footer">
            <p>本文来源: {{if .SourceURL}}<a href="{{.SourceURL}}" target="_blank" rel="noopener">{{.Source}}</a>{{else}}{{.Source}}{{end}}</p>
            <p>Copyright &copy; {{.Year}} All Rights Reserved.</p>
        </div>
    </div>
</body>
</html>`


