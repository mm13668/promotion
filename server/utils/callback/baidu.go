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
	// 与 ad_platform.platform_key 的值保持一致
	baiduName = "baidu_ocpc"
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

func (p *BaiduProvider) GetToken(ocpcKey string) string {
	return ocpcKey
}

// baiduConversionTypeItem 百度OCPC回传单个转化类型
type baiduConversionTypeItem struct {
	LogidUrl string `json:"logidUrl"`
	NewType  int    `json:"newType"`
}

// baiduUploadRequest 百度OCPC回传请求体
type baiduUploadRequest struct {
	Token           string                    `json:"token"`
	ConversionTypes []baiduConversionTypeItem `json:"conversionTypes"`
}

type baiduResponseError struct {
	Code     int    `json:"code"`
	Message  string `json:"message"`
	Position string `json:"position"`
}

type baiduResponseHeader struct {
	Desc   string               `json:"desc"`
	Status int                  `json:"status"`
	Errors []baiduResponseError `json:"errors,omitempty"`
}

// baiduUploadResponse 百度OCPC回传响应
type baiduUploadResponse struct {
	Header baiduResponseHeader `json:"header"`
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

	header := result.Header
	switch header.Status {
	case 0:
		return nil
	case 1:
		return fmt.Errorf("baidu ocpc partial success: desc=%s errors=%v", header.Desc, header.Errors)
	case 2:
		return fmt.Errorf("baidu ocpc all failed: desc=%s errors=%v", header.Desc, header.Errors)
	case 3:
		return fmt.Errorf("baidu ocpc token invalid: desc=%s", header.Desc)
	case 4:
		return fmt.Errorf("baidu ocpc server error: desc=%s", header.Desc)
	default:
		return fmt.Errorf("baidu ocpc unknown status: status=%d desc=%s", header.Status, header.Desc)
	}
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
