package promotion

import (
	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/request"
	"time"
)

type News struct {
	global.GVA_MODEL
	Title          string        `json:"title" form:"title" gorm:"type:varchar(255);not null;comment:新闻标题"`
	Summary        string        `json:"summary" form:"summary" gorm:"type:text;comment:新闻摘要"`
	Content        string        `json:"content" form:"content" gorm:"type:longtext;comment:新闻内容(富文本)"`
	CoverImage     string        `json:"coverImage" form:"coverImage" gorm:"type:varchar(500);comment:封面图片"`
	Author         string        `json:"author" form:"author" gorm:"type:varchar(100);default:'';comment:作者"`
	CategoryID     uint          `json:"categoryId" form:"categoryId" gorm:"default:0;comment:分类ID"`
	Category       NewsCategory  `json:"category" gorm:"foreignKey:CategoryID"`
	CategoryName   string        `json:"categoryName" gorm:"-"`
	Source         string        `json:"source" form:"source" gorm:"type:varchar(200);default:'';comment:来源"`
	SourceURL      string        `json:"sourceUrl" form:"sourceUrl" gorm:"type:varchar(500);default:'';comment:来源链接"`
	Status         int           `json:"status" form:"status" gorm:"type:tinyint(1);default:0;comment:状态(0=草稿 1=已发布)"`
	IsTop          *bool         `json:"isTop" form:"isTop" gorm:"default:false;comment:是否置顶"`
	Sort           int           `json:"sort" form:"sort" gorm:"default:0;comment:排序"`
	ViewCount      int           `json:"viewCount" form:"viewCount" gorm:"default:0;comment:浏览次数"`
	LikeCount      int           `json:"likeCount" form:"likeCount" gorm:"default:0;comment:点赞次数"`
	PublishTime    *time.Time    `json:"publishTime" form:"publishTime" gorm:"comment:发布时间"`
	PublishedPath  string        `json:"publishedPath" form:"publishedPath" gorm:"type:varchar(500);default:'';comment:发布路径"`
	SeoKeywords    string        `json:"seoKeywords" form:"seoKeywords" gorm:"type:text;comment:SEO关键词"`
	SeoDescription string        `json:"seoDescription" form:"seoDescription" gorm:"type:text;comment:SEO描述"`
}

func (News) TableName() string {
	return "news"
}

type NewsSearch struct {
	Title      string `json:"title" form:"title"`
	CategoryID *uint  `json:"categoryId" form:"categoryId"`
	Status     *int   `json:"status" form:"status"`
	request.PageInfo
}
