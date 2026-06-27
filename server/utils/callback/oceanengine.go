package callback

import (
	"context"
	"encoding/json"
	"fmt"
	"net/http"
	"time"

	"github.com/flipped-aurora/gin-vue-admin/server/utils/request"
)

var (
	oceanEngineApiUrl = "https://analytics.oceanengine.com/api/v2/conversion"
)

const (
	// 与 ad_platform.platform_key 的值保持一致
	oceanEngineName = "oceanengine"
)

// OceanEngineProvider 巨量引擎OCPC回传提供者
type OceanEngineProvider struct{}

// NewOceanEngineProvider 创建巨量引擎提供者
func NewOceanEngineProvider() *OceanEngineProvider {
	return &OceanEngineProvider{}
}

func (p *OceanEngineProvider) Name() string {
	return oceanEngineName
}

func (p *OceanEngineProvider) GetToken(ocpcKey string) string {
	return ocpcKey
}

// oceanEngineContext 巨量引擎回传context
type oceanEngineContext struct {
	Ad oceanEngineAd `json:"ad"`
}

// oceanEngineAd 巨量引擎回传ad
type oceanEngineAd struct {
	Callback string `json:"callback"`
}

// oceanEngineUploadRequest 巨量引擎回传请求体
type oceanEngineUploadRequest struct {
	EventType string             `json:"event_type"`
	Context   oceanEngineContext `json:"context"`
	Timestamp int64              `json:"timestamp"`
}

// oceanEngineUploadResponse 巨量引擎回传响应
type oceanEngineUploadResponse struct {
	Code    int    `json:"code"`
	Message string `json:"message"`
}

// conversionTypeMap 转化类型编号到巨量引擎事件名的映射
var conversionTypeMap = map[int]string{
	3:  "form",              // 表单提交成功
	35: "wechat",            // 微信复制按钮点击
	49: "active_register",   // 注册激活后登录
	30: "phone",             // 电话拨打
	19: "consult_effective", // 有效咨询
	27: "other",             // 其他
}

func (p *OceanEngineProvider) UploadConversion(ctx context.Context, req *ConversionRequest) error {
	if req.ClickId == "" {
		return fmt.Errorf("oceanengine callback requires clickid, but got empty")
	}

	eventType, ok := conversionTypeMap[req.ConversionType]
	if !ok {
		return fmt.Errorf("oceanengine unsupported conversion type: %d", req.ConversionType)
	}

	timestamp := req.ConversionTime
	if timestamp == 0 {
		timestamp = time.Now().UnixMilli()
	}

	body := oceanEngineUploadRequest{
		EventType: eventType,
		Context: oceanEngineContext{
			Ad: oceanEngineAd{
				Callback: req.ClickId,
			},
		},
		Timestamp: timestamp,
	}

	headers := map[string]string{
		"Content-Type": "application/json",
	}

	resp, err := request.HttpRequest(oceanEngineApiUrl, http.MethodPost, headers, nil, body)
	if err != nil {
		return fmt.Errorf("oceanengine request failed: %w", err)
	}
	defer resp.Body.Close()

	var result oceanEngineUploadResponse
	if err := json.NewDecoder(resp.Body).Decode(&result); err != nil {
		return fmt.Errorf("oceanengine decode response failed: %w", err)
	}

	if result.Code != 0 {
		return fmt.Errorf("oceanengine callback failed: code=%d message=%s", result.Code, result.Message)
	}

	return nil
}

// UploadConversionWithRetry 带重试的回传
func (p *OceanEngineProvider) UploadConversionWithRetry(ctx context.Context, req *ConversionRequest, maxRetries int) error {
	var lastErr error
	for i := 0; i < maxRetries; i++ {
		if i > 0 {
			time.Sleep(time.Second * time.Duration(i))
		}
		lastErr = p.UploadConversion(ctx, req)
		if lastErr == nil {
			return nil
		}
	}
	return fmt.Errorf("oceanengine upload failed after %d retries: %w", maxRetries, lastErr)
}

// init 在包初始化时自动注册巨量引擎提供者到默认工厂
func init() {
	GetDefaultFactory().Register(NewOceanEngineProvider())
}

// Ensure provider implements interface
var _ CallbackProvider = (*OceanEngineProvider)(nil)
