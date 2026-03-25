package promotion

import (
	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/model/promotion"
)

type LandingPhoneService struct{}

// CreateLandingPhone 创建落地页手机号收集记录
func (l *LandingPhoneService) CreateLandingPhone(landingPhone *promotion.LandingPhone) (err error) {
	err = global.GVA_DB.Create(landingPhone).Error
	return err
}
