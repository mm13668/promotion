package promotion

import (
	"fmt"
	"html/template"
	"os"
	"path/filepath"
	"strings"
	"time"

	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/promotion"
	"go.uber.org/zap"
	"gorm.io/gorm"
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
		"view_count":      e.ViewCount,
	}
	if e.IsTop != nil {
		updates["is_top"] = *e.IsTop
	}
	if e.PublishTime != nil {
		updates["publish_time"] = e.PublishTime
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

	// 如果配置了新闻预览域名，使用完整 URL
	domain := global.GVA_CONFIG.Conf.NewsDomain
	if domain != "" {
		newsPath = fmt.Sprintf("https://%s/%d/index.html", domain, id)
	}

	// 构建封面图片完整URL
	coverImage := news.CoverImage
	if coverImage != "" && !strings.HasPrefix(coverImage, "http") {
		baseDomain := global.GVA_CONFIG.Conf.MainDomain
		if baseDomain != "" {
			coverImage = fmt.Sprintf("https://%s%s", baseDomain, coverImage)
		} else {
			coverImage = fmt.Sprintf("http://localhost:8080%s", coverImage)
		}
	}

	data := struct {
		ID             uint
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
		ID:             news.ID,
		Title:          news.Title,
		Summary:        news.Summary,
		Content:        template.HTML(news.Content),
		CoverImage:     coverImage,
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

	tmpl, err := template.ParseFiles("uploads/news/temp/index.html")
	if err != nil {
		return "", fmt.Errorf("加载模板失败: %w", err)
	}
	// 使用模板文件名作为模板名
	tmpl = tmpl.Lookup("index.html")

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

// IncrementViewCount 增加浏览次数，返回更新后的值
func (s *NewsService) IncrementViewCount(id uint) (int, error) {
	err := global.GVA_DB.Model(&promotion.News{}).Where("id = ?", id).
		UpdateColumn("view_count", gorm.Expr("view_count + 1")).Error
	if err != nil {
		return 0, err
	}
	var news promotion.News
	err = global.GVA_DB.Select("view_count").Where("id = ?", id).First(&news).Error
	return news.ViewCount, err
}

// BatchPublishNews 一键重新发布所有已发布的新闻
func (s *NewsService) BatchPublishNews() (success int, failed int, err error) {
	var list []promotion.News
	if err := global.GVA_DB.Where("status = ?", 1).Find(&list).Error; err != nil {
		return 0, 0, err
	}
	for _, news := range list {
		if _, err := s.PublishNews(news.ID); err != nil {
			global.GVA_LOG.Error("批量发布新闻失败", zap.Uint("id", news.ID), zap.Error(err))
			failed++
		} else {
			success++
		}
	}
	return success, failed, nil
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




