package promotion

import "github.com/flipped-aurora/gin-vue-admin/server/global"

type QAQuestion struct {
	global.GVA_MODEL
	RegionID      *uint    `json:"regionId" gorm:"index:idx_question_region"`
	Title         string   `json:"title" gorm:"type:varchar(200)"`
	Content       string   `json:"content" gorm:"type:mediumtext"`
	TimeAt        string   `json:"timeAt" gorm:"type:varchar(50)"`
	Remark        string   `json:"remark" gorm:"type:varchar(255)"`
	Nickname      string   `json:"nickname" gorm:"type:varchar(50)"`
	AvatarURL     string   `json:"avatarUrl" gorm:"type:varchar(255)"`
	TitleName     string   `json:"titleName" gorm:"type:varchar(50)"`
	Signature     string   `json:"signature" gorm:"type:varchar(255)"`
	FollowCount   uint     `json:"followCount"`
	LookCount     uint     `json:"lookCount"`
	FavoriteCount uint     `json:"favoriteCount"`
	LikeCount     uint     `json:"likeCount"`
	Label         []string `json:"label" gorm:"type:json;serializer:json"`
	Sort          int      `json:"sort" gorm:"index:idx_question_sort"`
	AnswerCount   uint     `json:"answerCount"`
	Status        uint8    `json:"status" gorm:"index:idx_question_status"`
	CreatedBy     *uint    `json:"createdBy"`
	UpdatedBy     *uint    `json:"updatedBy"`
}

func (QAQuestion) TableName() string {
	return "qa_question"
}

type QAAnswer struct {
	global.GVA_MODEL
	QuestionID    uint   `json:"questionId" gorm:"index:idx_answer_question"`
	Nickname      string `json:"nickname" gorm:"type:varchar(50)"`
	AvatarURL     string `json:"avatarUrl" gorm:"type:varchar(255)"`
	TitleName     string `json:"titleName" gorm:"type:varchar(50)"`
	Signature     string `json:"signature" gorm:"type:varchar(255)"`
	Level         *uint  `json:"level"`
	Content       string `json:"content" gorm:"type:mediumtext"`
	FollowCount   uint   `json:"followCount"`
	FavoriteCount uint   `json:"favoriteCount"`
	LikeCount     uint   `json:"likeCount"`
	TimeText      string `json:"timeText" gorm:"type:varchar(50)"`
	Skill         string `json:"skill" gorm:"type:varchar(255)"`
	AuditStatus   uint8  `json:"auditStatus" gorm:"default:0"`
	ReplyCount    uint   `json:"replyCount"`
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
	Nickname      string `json:"nickname" gorm:"type:varchar(50)"`
	AvatarURL     string `json:"avatarUrl" gorm:"type:varchar(255)"`
	TitleName     string `json:"titleName" gorm:"type:varchar(50)"`
	Signature     string `json:"signature" gorm:"type:varchar(255)"`
	Level         *uint  `json:"level"`
	Content       string `json:"content" gorm:"type:text"`
	FollowCount   uint   `json:"followCount"`
	FavoriteCount uint   `json:"favoriteCount"`
	LikeCount     uint   `json:"likeCount"`
	TimeText      string `json:"timeText" gorm:"type:varchar(50)"`
	Skill         string `json:"skill" gorm:"type:varchar(255)"`
	AuditStatus   uint8  `json:"auditStatus" gorm:"default:0"`
	Status        uint8  `json:"status" gorm:"index:idx_reply_status"`
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
