package promotion

import "github.com/flipped-aurora/gin-vue-admin/server/global"

type QAQuestion struct {
	global.GVA_MODEL
	AccountID  uint    `json:"accountId" gorm:"index:idx_question_account"`
	CategoryID *uint   `json:"categoryId" gorm:"index:idx_question_category"`
	Title      string  `json:"title" gorm:"type:varchar(200)"`
	Content    string  `json:"content" gorm:"type:mediumtext"`
	CoverURL   string  `json:"coverUrl" gorm:"type:varchar(255)"`
	Status     uint8   `json:"status" gorm:"index:idx_question_status"`
	IsPinned   bool    `json:"isPinned"`
	IsPrivate  bool    `json:"isPrivate"`
	ViewCount  uint    `json:"viewCount"`
	LikeCount  uint    `json:"likeCount"`
	FavoriteCount uint `json:"favoriteCount"`
	AnswerCount uint   `json:"answerCount"`
	Sort       int     `json:"sort" gorm:"index:idx_question_sort"`
	Remark     string  `json:"remark" gorm:"type:varchar(255)"`
	CreatedBy  *uint   `json:"createdBy"`
	UpdatedBy  *uint   `json:"updatedBy"`
}

func (QAQuestion) TableName() string {
	return "qa_question"
}

type QAAnswer struct {
	global.GVA_MODEL
	QuestionID uint   `json:"questionId" gorm:"index:idx_answer_question"`
	AuthorID   uint   `json:"authorId" gorm:"index:idx_answer_author"`
	Content    string `json:"content" gorm:"type:mediumtext"`
	ImagesJSON string `json:"imagesJson" gorm:"type:json"`
	Status     uint8  `json:"status" gorm:"index:idx_answer_status"`
	IsAccepted bool   `json:"isAccepted"`
	LikeCount  uint   `json:"likeCount"`
	ReplyCount uint   `json:"replyCount"`
	Sort       int    `json:"sort"`
	Remark     string `json:"remark" gorm:"type:varchar(255)"`
	CreatedBy  *uint  `json:"createdBy"`
	UpdatedBy  *uint  `json:"updatedBy"`
}

func (QAAnswer) TableName() string {
	return "qa_answer"
}

type QAReply struct {
	global.GVA_MODEL
	AnswerID  uint   `json:"answerId" gorm:"index:idx_reply_answer"`
	ParentID  *uint  `json:"parentId" gorm:"index:idx_reply_parent"`
	AuthorID  uint   `json:"authorId"`
	Content   string `json:"content" gorm:"type:text"`
	Status    uint8  `json:"status" gorm:"index:idx_reply_status"`
	LikeCount uint   `json:"likeCount"`
	Remark    string `json:"remark" gorm:"type:varchar(255)"`
	CreatedBy *uint  `json:"createdBy"`
	UpdatedBy *uint  `json:"updatedBy"`
}

func (QAReply) TableName() string {
	return "qa_reply"
}

