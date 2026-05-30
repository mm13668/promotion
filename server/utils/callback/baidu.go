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
	baiduApiUrl = "https://ocpc.baidu.com/ocpcapi/api/uploadConvertData"
	baiduName   = "baidu"
)

// BaiduProvider 百度OCPC回传提供者
type BaiduProvider struct{}

// NewBaiduProvider 创建百度OCPC提供者
func NewBaiduProvider() *BaiduProvider {
	return &BaiduProvider{}
}

func (p *BaiduProvider) Name() string {
	return baiduName
}

// baiduConversionTypeItem 百度OCPC回传单个转化类型
type baiduConversionTypeItem struct {
	LogidUrl string `json:"logidUrl"`
	NewType  int    `json:"newType"`
}

// baiduUploadRequest 百度OCPC回传请求体
type baiduUploadRequest struct {
	Token            string                     `json:"token"`
	ConversionTypes  []baiduConversionTypeItem  `json:"conversionTypes"`
}

// baiduUploadResponse 百度OCPC回传响应
type baiduUploadResponse struct {
	Code    int    `json:"code"`
	Message string `json:"message"`
	Data    any    `json:"data"`
}

func (p *BaiduProvider) UploadConversion(ctx context.Context, req *ConversionRequest) error {
	body := baiduUploadRequest{
		Token: req.Token,
		ConversionTypes: []baiduConversionTypeItem{
			{
				LogidUrl: req.LogidUrl,
				NewType:  req.ConversionType,
			},
		},
	}

	headers := map[string]string{
		"Content-Type": "application/json",
	}

	resp, err := request.HttpRequest(baiduApiUrl, http.MethodPost, headers, nil, body)
	if err != nil {
		return fmt.Errorf("baidu ocpc request failed: %w", err)
	}
	defer resp.Body.Close()

	var result baiduUploadResponse
	if err := json.NewDecoder(resp.Body).Decode(&result); err != nil {
		return fmt.Errorf("baidu ocpc decode response failed: %w", err)
	}

	if result.Code != 0 {
		return fmt.Errorf("baidu ocpc api error: code=%d message=%s", result.Code, result.Message)
	}

	return nil
}

// GetBaiduToken 获取百度OCPC的token（直接使用ocpc_key）
// 后续如果百度需要动态获取token，可以在这里修改逻辑
func GetBaiduToken(ocpcKey string) string {
	return ocpcKey
}

// init 在包初始化时自动注册百度提供者到默认工厂
func init() {
	GetDefaultFactory().Register(NewBaiduProvider())
}

// Ensure provider implements interface
var _ CallbackProvider = (*BaiduProvider)(nil)

// UploadConversionWithRetry 带重试的回传
func (p *BaiduProvider) UploadConversionWithRetry(ctx context.Context, req *ConversionRequest, maxRetries int) error {
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
	return fmt.Errorf("baidu ocpc upload failed after %d retries: %w", maxRetries, lastErr)
}
