package promotion

import "github.com/flipped-aurora/gin-vue-admin/server/global"

type QAQuestion struct {
	global.GVA_MODEL
	AccountID     uint   `json:"accountId" gorm:"index:idx_question_account"`
	CategoryID    *uint  `json:"categoryId" gorm:"index:idx_question_category"`
	Title         string `json:"title" gorm:"type:varchar(200)"`
	Content       string `json:"content" gorm:"type:mediumtext"`
	CoverURL      string `json:"coverUrl" gorm:"type:varchar(255)"`
	Status        uint8  `json:"status" gorm:"index:idx_question_status"`
	IsPinned      bool   `json:"isPinned"`
	IsPrivate     bool   `json:"isPrivate"`
	ViewCount     uint   `json:"viewCount"`
	LikeCount     uint   `json:"likeCount"`
	FavoriteCount uint   `json:"favoriteCount"`
	AnswerCount   uint   `json:"answerCount"`
	Sort          int    `json:"sort" gorm:"index:idx_question_sort"`
	Remark        string `json:"remark" gorm:"type:varchar(255)"`
	CreatedBy     *uint  `json:"createdBy"`
	UpdatedBy     *uint  `json:"updatedBy"`
}

func (QAQuestion) TableName() string {
	return "qa_question"
}

type QAAnswer struct {
	global.GVA_MODEL
	QuestionID    uint   `json:"questionId" gorm:"index:idx_answer_question"`
	AuthorID      uint   `json:"authorId" gorm:"index:idx_answer_author"`
	Nickname      string `json:"nickname" gorm:"type:varchar(100)"`
	AvatarURL     string `json:"avatarUrl" gorm:"type:varchar(255)"`
	Title         string `json:"title" gorm:"type:varchar(100)"`
	Signature     string `json:"signature" gorm:"type:varchar(255)"`
	Level         *uint  `json:"level"`
	Content       string `json:"content" gorm:"type:mediumtext"`
	ImagesJSON    string `json:"imagesJson" gorm:"type:json"`
	FollowCount   uint   `json:"followCount"`
	FavoriteCount uint   `json:"favoriteCount"`
	TimeText      string `json:"timeText" gorm:"type:varchar(50)"`
	Skill         string `json:"skill" gorm:"type:varchar(255)"`
	AuditStatus   bool   `json:"auditStatus" gorm:"default:0"`
	IsAccepted    bool   `json:"isAccepted"`
	LikeCount     uint   `json:"likeCount"`
	ReplyCount    uint   `json:"replyCount"`
	Sort          int    `json:"sort"`
	Remark        string `json:"remark" gorm:"type:varchar(255)"`
	CreatedBy     *uint  `json:"createdBy"`
	UpdatedBy     *uint  `json:"updatedBy"`
}

func (QAAnswer) TableName() string {
	return "qa_answer"
}

type QAReply struct {
	global.GVA_MODEL
	AnswerID      uint   `json:"answerId" gorm:"index:idx_reply_answer"`
	ParentID      *uint  `json:"parentId" gorm:"index:idx_reply_parent"`
	AuthorID      uint   `json:"authorId"`
	Nickname      string `json:"nickname" gorm:"type:varchar(100)"`
	AvatarURL     string `json:"avatarUrl" gorm:"type:varchar(255)"`
	Title         string `json:"title" gorm:"type:varchar(100)"`
	Signature     string `json:"signature" gorm:"type:varchar(255)"`
	Level         *uint  `json:"level"`
	Content       string `json:"content" gorm:"type:text"`
	FollowCount   uint   `json:"followCount"`
	FavoriteCount uint   `json:"favoriteCount"`
	TimeText      string `json:"timeText" gorm:"type:varchar(50)"`
	Skill         string `json:"skill" gorm:"type:varchar(255)"`
	AuditStatus   bool   `json:"auditStatus" gorm:"default:0"`
	Status        uint8  `json:"status" gorm:"index:idx_reply_status"`
	LikeCount     uint   `json:"likeCount"`
	Remark        string `json:"remark" gorm:"type:varchar(255)"`
	CreatedBy     *uint  `json:"createdBy"`
	UpdatedBy     *uint  `json:"updatedBy"`
}

func (QAReply) TableName() string {
	return "qa_reply"
}

type QAAvatarNickname struct {
	global.GVA_MODEL
	AvatarURL string `json:"avatarUrl" gorm:"type:varchar(255)"`
	Nickname  string `json:"nickname" gorm:"type:varchar(50)"`
	Sort      int    `json:"sort" gorm:"index:idx_sort"`
	Status    uint8  `json:"status" gorm:"index:idx_status;default:1"`
}

func (QAAvatarNickname) TableName() string {
	return "qa_avatar_nickname"
}

type QATitle struct {
	global.GVA_MODEL
	Name   string `json:"name" gorm:"type:varchar(50);uniqueIndex:uk_name"`
	Sort   int    `json:"sort" gorm:"index:idx_sort"`
	Status uint8  `json:"status" gorm:"index:idx_status;default:1"`
}

func (QATitle) TableName() string {
	return "qa_title"
}

type QASignature struct {
	global.GVA_MODEL
	Content string `json:"content" gorm:"type:varchar(255);uniqueIndex:uk_content"`
	Sort    int    `json:"sort" gorm:"index:idx_sort"`
	Status  uint8  `json:"status" gorm:"index:idx_status;default:1"`
}

func (QASignature) TableName() string {
	return "qa_signature"
}

type QATag struct {
	global.GVA_MODEL
	Name   string `json:"name" gorm:"type:varchar(50);uniqueIndex:uk_name"`
	Sort   int    `json:"sort" gorm:"index:idx_sort"`
	Status uint8  `json:"status" gorm:"index:idx_status;default:1"`
}

func (QATag) TableName() string {
	return "qa_tag"
}
