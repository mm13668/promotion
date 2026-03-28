package promotion

import (
	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"time"
)

type PromotionDomain struct {
	global.GVA_MODEL
	Domain      string `json:"domain" gorm:"type:varchar(255);uniqueIndex:uk_domain_domain"`
	CnameTarget string `json:"cnameTarget" gorm:"type:varchar(255)"`
	Status      uint8  `json:"status" gorm:"index:idx_domain_status"`
	HttpsStatus uint8  `json:"httpsStatus" gorm:"index:idx_domain_https"`
	CertMode    uint8  `json:"certMode"`
	Remark      string `json:"remark" gorm:"type:varchar(255)"`
	CreatedBy   *uint  `json:"createdBy"`
	UpdatedBy   *uint  `json:"updatedBy"`
}

func (PromotionDomain) TableName() string {
	return "promotion_domain"
}

type SSLCertificate struct {
	global.GVA_MODEL
	Name      string     `json:"name" gorm:"type:varchar(128)"`
	Provider  string     `json:"provider" gorm:"type:varchar(64)"`
	Type      string     `json:"type" gorm:"type:varchar(32)"`
	SerialNo  string     `json:"serialNo" gorm:"type:varchar(128)"`
	Issuer    string     `json:"issuer" gorm:"type:varchar(255)"`
	NotBefore *time.Time `json:"notBefore" gorm:"type:datetime"`
	NotAfter  *time.Time `json:"notAfter" gorm:"type:datetime;index:idx_cert_expire"`
	Status    uint8      `json:"status" gorm:"index:idx_cert_status"`
	PemPath   string     `json:"pemPath" gorm:"type:varchar(255)"`
	KeyPath   string     `json:"keyPath" gorm:"type:varchar(255)"`
	Remark    string     `json:"remark" gorm:"type:varchar(255)"`
	CreatedBy *uint      `json:"createdBy"`
	UpdatedBy *uint      `json:"updatedBy"`
}

func (SSLCertificate) TableName() string {
	return "ssl_certificate"
}

type DomainSSLBinding struct {
	global.GVA_MODEL
	DomainID     uint       `json:"domainId" gorm:"index:idx_binding_domain"`
	CertID       *uint      `json:"certId"`
	HttpsEnabled bool       `json:"httpsEnabled"`
	ForceHttps   bool       `json:"forceHttps"`
	ApplyStatus  uint8      `json:"applyStatus" gorm:"index:idx_binding_status"`
	ApplyMessage string     `json:"applyMessage" gorm:"type:varchar(255)"`
	LastApplyAt  *time.Time `json:"lastApplyAt" gorm:"type:datetime"`
	Remark       string     `json:"remark" gorm:"type:varchar(255)"`
	CreatedBy    *uint      `json:"createdBy"`
	UpdatedBy    *uint      `json:"updatedBy"`
}

func (DomainSSLBinding) TableName() string {
	return "domain_ssl_binding"
}
