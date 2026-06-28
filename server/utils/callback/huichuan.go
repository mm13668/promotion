package callback

import (
	"context"
	"encoding/json"
	"fmt"
	"net/http"
	"time"

	"github.com/flipped-aurora/gin-vue-admin/server/utils/request"
)

const (
	// 与 ad_platform.platform_key 的值保持一致
	HuiChuanProviderName = "UC(超级汇川)"
	huichuanApiUrl       = "https://huichuan.uc.cn/callback/webapi"
)

// huichuanConversionTypeMap 内部转化类型到超级汇川event_type的映射
// 文档: https://chaojihuichuan.yuque.com/gwbisb/lv9c4s/onhoq0iemd63z0pp
var huichuanConversionTypeMap = map[int]int{
	3:  5,    // 表单提交成功 -> 表单提交
	35: 18,   // 微信复制按钮点击 -> 微信
	49: 12,   // 注册激活后登录 -> 注册(网页类)
	27: 14,   // 客户自定义类型 -> 其他
	19: 1002, // 有效咨询 -> 有效咨询
	30: 6,    // 电话拨通 -> 电话拨打
}

// HuichuanProvider 超级汇川OCPC回传提供者
type HuichuanProvider struct{}

// NewHuichuanProvider 创建超级汇川提供者
func NewHuichuanProvider() *HuichuanProvider {
	return &HuichuanProvider{}
}

func (p *HuichuanProvider) Name() string {
	return HuiChuanProviderName
}

func (p *HuichuanProvider) GetToken(ocpcKey string) string {
	// 超级汇川不需要token鉴权，通过uctrackid识别广告主
	return ocpcKey
}

// huichuanUploadResponse 超级汇川回传响应
type huichuanUploadResponse struct {
	Status  int    `json:"status"`
	Message string `json:"message"`
}

func (p *HuichuanProvider) UploadConversion(ctx context.Context, req *ConversionRequest) error {
	eventType, ok := huichuanConversionTypeMap[req.ConversionType]
	if !ok {
		return fmt.Errorf("huichuan unsupported conversion type: %d", req.ConversionType)
	}

	if req.LogidUrl == "" {
		return fmt.Errorf("huichuan callback requires logidUrl with uctrackid, but got empty")
	}

	eventTime := req.ConversionTime
	if eventTime == 0 {
		eventTime = time.Now().UnixMilli()
	}

	// link参数传入包含uctrackid的完整落地页URL(由HttpRequest自动做URL编码)
	// event_time为毫秒级时间戳
	params := map[string]string{
		"link":       req.LogidUrl,
		"event_type": fmt.Sprintf("%d", eventType),
		"event_time": fmt.Sprintf("%d", eventTime),
		"source":     "promotion_system",
	}

	headers := map[string]string{}

	resp, err := request.HttpRequest(huichuanApiUrl, http.MethodGet, headers, params, nil)
	if err != nil {
		return fmt.Errorf("huichuan request failed: %w", err)
	}
	defer resp.Body.Close()

	var result huichuanUploadResponse
	if err := json.NewDecoder(resp.Body).Decode(&result); err != nil {
		return fmt.Errorf("huichuan decode response failed: %w", err)
	}

	if result.Status != 0 {
		return fmt.Errorf("huichuan callback failed: status=%d message=%s", result.Status, result.Message)
	}

	return nil
}

// UploadConversionWithRetry 带重试的回传
func (p *HuichuanProvider) UploadConversionWithRetry(ctx context.Context, req *ConversionRequest, maxRetries int) error {
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
	return fmt.Errorf("huichuan upload failed after %d retries: %w", maxRetries, lastErr)
}

// init 在包初始化时自动注册超级汇川提供者到默认工厂
func init() {
	GetDefaultFactory().Register(NewHuichuanProvider())
}

// Ensure provider implements interface
var _ CallbackProvider = (*HuichuanProvider)(nil)
