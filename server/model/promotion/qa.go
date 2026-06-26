package promotion

import (
	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/common/request"
	"github.com/google/uuid"
)

const SuperAdminUUID = "4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b"

type QAQuestion struct {
	global.GVA_MODEL
	UUID          uuid.UUID `json:"uuid" gorm:"type:varchar(100);index:idx_question_uuid;comment:用户UUID"`
	RegionID      *uint     `json:"regionId" gorm:"index:idx_question_region"`
	Title         string    `json:"title" gorm:"type:varchar(200)"`
	Content       string    `json:"content" gorm:"type:mediumtext"`
	TimeAt        string    `json:"timeAt" gorm:"type:varchar(50)"`
	Remark        string    `json:"remark" gorm:"type:varchar(255)"`
	Nickname      string    `json:"nickname" gorm:"type:varchar(50)"`
	AvatarURL     string    `json:"avatarUrl" gorm:"type:varchar(255)"`
	TitleName     string    `json:"titleName" gorm:"type:varchar(50)"`
	Signature     string    `json:"signature" gorm:"type:varchar(255)"`
	FollowCount   uint      `json:"followCount"`
	LookCount     uint      `json:"lookCount"`
	FavoriteCount uint      `json:"favoriteCount"`
	LikeCount     uint      `json:"likeCount"`
	Label         []string  `json:"label" gorm:"type:json;serializer:json"`
	Sort          int       `json:"sort" gorm:"index:idx_question_sort"`
	AnswerCount   uint      `json:"answerCount"`
	Status        uint8     `json:"status" gorm:"index:idx_question_status"`
	CreatedBy     *uint     `json:"createdBy"`
	UpdatedBy     *uint     `json:"updatedBy"`
}

func (QAQuestion) TableName() string {
	return "qa_question"
}

type QAAnswer struct {
	global.GVA_MODEL
	UUID          uuid.UUID `json:"uuid" gorm:"type:varchar(100);index:idx_answer_uuid;comment:用户UUID"`
	QuestionID    uint      `json:"questionId" gorm:"index:idx_answer_question"`
	Nickname      string    `json:"nickname" gorm:"type:varchar(50)"`
	AvatarURL     string    `json:"avatarUrl" gorm:"type:varchar(255)"`
	TitleName     string    `json:"titleName" gorm:"type:varchar(50)"`
	Signature     string    `json:"signature" gorm:"type:varchar(255)"`
	Level         *uint     `json:"level" gorm:"default:0"`
	Content       string    `json:"content" gorm:"type:mediumtext"`
	FollowCount   uint      `json:"followCount" gorm:"default:0"`
	FavoriteCount uint      `json:"favoriteCount" gorm:"default:0"`
	LikeCount     uint      `json:"likeCount" gorm:"default:0"`
	TimeText      string    `json:"timeText" gorm:"type:varchar(50)"`
	Skill         string    `json:"skill" gorm:"type:varchar(255)"`
	AuditStatus   uint8     `json:"auditStatus" gorm:"default:0"`
	ReplyCount    uint      `json:"replyCount"`
	Sort          int       `json:"sort" gorm:"default:0;index:idx_answer_sort"`
	CreatedBy     *uint     `json:"createdBy"`
	UpdatedBy     *uint     `json:"updatedBy"`
}

func (QAAnswer) TableName() string {
	return "qa_answer"
}

type QAReply struct {
	global.GVA_MODEL
	UUID          uuid.UUID `json:"uuid" gorm:"type:varchar(100);index:idx_reply_uuid;comment:用户UUID"`
	AnswerID      uint      `json:"answerId" gorm:"index:idx_reply_answer"`
	ParentID      *uint     `json:"parentId" gorm:"index:idx_reply_parent"`
	Nickname      string    `json:"nickname" gorm:"type:varchar(50)"`
	AvatarURL     string    `json:"avatarUrl" gorm:"type:varchar(255)"`
	TitleName     string    `json:"titleName" gorm:"type:varchar(50)"`
	Signature     string    `json:"signature" gorm:"type:varchar(255)"`
	Level         *uint     `json:"level" gorm:"default:0"`
	Content       string    `json:"content" gorm:"type:text"`
	FollowCount   uint      `json:"followCount" gorm:"default:0"`
	FavoriteCount uint      `json:"favoriteCount" gorm:"default:0"`
	LikeCount     uint      `json:"likeCount" gorm:"default:0"`
	TimeText      string    `json:"timeText" gorm:"type:varchar(50)"`
	Skill         string    `json:"skill" gorm:"type:varchar(255)"`
	AuditStatus   uint8     `json:"auditStatus" gorm:"default:0"`
	Sort          int       `json:"sort" gorm:"default:0;index:idx_reply_sort"`
	CreatedBy     *uint     `json:"createdBy"`
	UpdatedBy     *uint     `json:"updatedBy"`
}

func (QAReply) TableName() string {
	return "qa_reply"
}

type QAAvatarNickname struct {
	global.GVA_MODEL
	UUID      uuid.UUID `json:"uuid" gorm:"type:varchar(100);index:idx_avatar_uuid;comment:用户UUID"`
	AvatarURL string    `json:"avatarUrl" gorm:"type:varchar(255)"`
	Nickname  string    `json:"nickname" gorm:"type:varchar(50)"`
	Sort      int       `json:"sort" gorm:"index:idx_sort"`
	Status    uint8     `json:"status" gorm:"index:idx_status;default:1"`
}

func (QAAvatarNickname) TableName() string {
	return "qa_avatar_nickname"
}

type QATitle struct {
	global.GVA_MODEL
	UUID   uuid.UUID `json:"uuid" gorm:"type:varchar(100);index:idx_title_uuid;comment:用户UUID"`
	Name   string    `json:"name" gorm:"type:varchar(50);index:idk_name"`
	Sort   int       `json:"sort" gorm:"index:idx_sort"`
	Status uint8     `json:"status" gorm:"index:idx_status;default:1"`
}

func (QATitle) TableName() string {
	return "qa_title"
}

type QASignature struct {
	global.GVA_MODEL
	UUID    uuid.UUID `json:"uuid" gorm:"type:varchar(100);index:idx_signature_uuid;comment:用户UUID"`
	Content string    `json:"content" gorm:"type:varchar(255);index:idk_content"`
	Sort    int       `json:"sort" gorm:"index:idx_sort"`
	Status  uint8     `json:"status" gorm:"index:idx_status;default:1"`
}

func (QASignature) TableName() string {
	return "qa_signature"
}

type QATag struct {
	global.GVA_MODEL
	UUID   uuid.UUID `json:"uuid" gorm:"type:varchar(100);index:idx_tag_uuid;comment:用户UUID"`
	Name   string    `json:"name" gorm:"type:varchar(50);index:idk_name"`
	Sort   int       `json:"sort" gorm:"index:idx_sort"`
	Status uint8     `json:"status" gorm:"index:idx_status;default:1"`
}

func (QATag) TableName() string {
	return "qa_tag"
}

type SortItem struct {
	ID   uint `json:"id"`
	Sort int  `json:"sort"`
}

type AnswerSearch struct {
	request.PageInfo
	QuestionID *uint `json:"questionId" form:"questionId"`
}

type ReplySearch struct {
	request.PageInfo
	AnswerID *uint `json:"answerId" form:"answerId"`
}

type QAQuestionSearch struct {
	Page     int    `json:"page" form:"page"`
	PageSize int    `json:"pageSize" form:"pageSize"`
	RegionID *uint  `json:"regionId" form:"regionId"`
	Title    string `json:"title" form:"title"`
}

type QAAvatarNicknameSearch struct {
	request.PageInfo
	Nickname string `json:"nickname" form:"nickname"`
}

type QATitleSearch struct {
	request.PageInfo
	Name string `json:"name" form:"name"`
}

type QASignatureSearch struct {
	request.PageInfo
	Content string `json:"content" form:"content"`
}

type QATagSearch struct {
	request.PageInfo
	Name string `json:"name" form:"name"`
}
