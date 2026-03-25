package promotion

import (
	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/promotion"
)

type LandingMessageService struct{}

// CreateLandingMessage 创建落地页留言记录
func (l *LandingMessageService) CreateLandingMessage(landingMessage *promotion.LandingMessage) (err error) {
	err = global.GVA_DB.Create(landingMessage).Error
	return err
}
