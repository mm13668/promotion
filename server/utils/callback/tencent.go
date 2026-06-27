package callback

import (
	"context"
	"crypto/rand"
	"encoding/hex"
	"encoding/json"
	"fmt"
	"net/http"
	"net/url"
	"strconv"
	"time"

	"github.com/flipped-aurora/gin-vue-admin/server/utils/request"
)

const (
	QQGDTName = "qq_gdt"
)

// qqConversionTypeMap 转化类型编号到腾讯广点通API action_type的映射
// 转化类型: 3=表单提交成功, 49=注册激活后登录, 27=客户自定义类型, 19=有效咨询, 30=电话拨通
// 注意: 35(微信复制按钮点击)不在广点通回传映射范围内
var qqConversionTypeMap = map[int]string{
	3:  "CONFIRM_EFFECTIVE_LEADS",
	49: "REGISTER",
	27: "CUSTOM",
	19: "ONLINE_CONSULT",
	30: "MAKE_PHONE_CALL",
}

// QQGDTProvider 腾讯广点通OCPC回传提供者
type QQGDTProvider struct{}

// NewQQGDTProvider 创建腾讯广点通提供者
func NewQQGDTProvider() *QQGDTProvider {
	return &QQGDTProvider{}
}

func (p *QQGDTProvider) Name() string {
	return QQGDTName
}

func (p *QQGDTProvider) GetToken(ocpcKey string) string {
	return ocpcKey
}

// qqGDTUploadRequest 广点通API回传请求体（非callback方式）
type qqGDTUploadRequest struct {
	AccountID       int64         `json:"account_id"`
	UserActionSetID int64         `json:"user_action_set_id"`
	Actions         []qqGDTAction `json:"actions"`
}

// qqGDTAction 广点通行为数据
type qqGDTAction struct {
	ActionTime int64  `json:"action_time"`
	URL        string `json:"url"`
	ActionType string `json:"action_type"`
}

// qqGDTUploadResponse 广点通API回传响应
type qqGDTUploadResponse struct {
	Code    int    `json:"code"`
	Message string `json:"message"`
	TraceID string `json:"trace_id"`
}

// ExtractQQCallbackURL 从URL中提取__CALLBACK__参数并URL解码
// 腾讯广点通的点击URL中包含__CALLBACK__参数，其值为URL编码的回调地址
func ExtractQQCallbackURL(rawURL string) string {
	if rawURL == "" {
		return ""
	}
	u, err := url.Parse(rawURL)
	if err != nil {
		return ""
	}
	cb := u.Query().Get("__CALLBACK__")
	if cb == "" {
		return ""
	}
	// URL解码回调地址
	decoded, err := url.QueryUnescape(cb)
	if err != nil {
		return ""
	}
	return decoded
}

// generateNonce 生成随机nonce字符串
func generateNonce() string {
	b := make([]byte, 16)
	_, _ = rand.Read(b)
	return hex.EncodeToString(b)
}

// parseQQConfig 从Secret中解析广点通配置
// Secret格式: {"account_id":123,"user_action_set_id":456}
func parseQQConfig(secret string) (accountID, userActionSetID int64, err error) {
	if secret == "" {
		return 0, 0, fmt.Errorf("qq gdt config not found in ocpc_secret")
	}
	var cfg struct {
		AccountID       int64 `json:"account_id"`
		UserActionSetID int64 `json:"user_action_set_id"`
	}
	if err := json.Unmarshal([]byte(secret), &cfg); err != nil {
		return 0, 0, fmt.Errorf("qq gdt invalid config format: %w", err)
	}
	if cfg.AccountID == 0 || cfg.UserActionSetID == 0 {
		return 0, 0, fmt.Errorf("qq gdt config missing required fields: account_id or user_action_set_id")
	}
	return cfg.AccountID, cfg.UserActionSetID, nil
}

func (p *QQGDTProvider) UploadConversion(ctx context.Context, req *ConversionRequest) error {
	actionType, ok := qqConversionTypeMap[req.ConversionType]
	if !ok {
		return fmt.Errorf("qq gdt unsupported conversion type: %d", req.ConversionType)
	}

	// 优先使用CallbackUrl（从HTTP referer中提取的__CALLBACK__）
	callbackURL := req.CallbackUrl
	useCallbackMethod := callbackURL != ""

	// 如果没有CallbackUrl，尝试从LogidUrl中提取__CALLBACK__
	if !useCallbackMethod {
		callbackURL = ExtractQQCallbackURL(req.LogidUrl)
		useCallbackMethod = callbackURL != ""
	}

	timestamp := req.ConversionTime
	if timestamp == 0 {
		timestamp = time.Now().Unix()
	}

	nonce := generateNonce()
	headers := map[string]string{
		"Content-Type": "application/json",
		"access-token": req.Token,
		"timestamp":    strconv.FormatInt(timestamp, 10),
		"nonce":        nonce,
	}

	if useCallbackMethod {
		// 回调方式：使用__CALLBACK__中的URL
		body := map[string]interface{}{
			"actions": []map[string]interface{}{
				{
					"action_time": timestamp,
					"url":         req.LogidUrl,
					"action_type": actionType,
				},
			},
		}

		resp, err := request.HttpRequest(callbackURL, http.MethodPost, headers, nil, body)
		if err != nil {
			return fmt.Errorf("qq gdt callback request failed: %w", err)
		}
		defer resp.Body.Close()

		var result qqGDTUploadResponse
		if err := json.NewDecoder(resp.Body).Decode(&result); err != nil {
			return fmt.Errorf("qq gdt decode response failed: %w", err)
		}

		if result.Code != 0 {
			return fmt.Errorf("qq gdt callback failed: code=%d message=%s trace_id=%s", result.Code, result.Message, result.TraceID)
		}

		return nil
	}

	// 非回调方式：使用click_id
	if req.ClickId == "" {
		return fmt.Errorf("qq gdt requires either __CALLBACK__ or click_id (qz_gdt/gdt_vid), none found")
	}

	accountID, userActionSetID, err := parseQQConfig(req.Secret)
	if err != nil {
		return fmt.Errorf("qq gdt config error: %w", err)
	}

	apiURL := "https://api.e.qq.com/v3.0/user_actions/add"
	body := qqGDTUploadRequest{
		AccountID:       accountID,
		UserActionSetID: userActionSetID,
		Actions: []qqGDTAction{
			{
				ActionTime: timestamp,
				URL:        req.LogidUrl,
				ActionType: actionType,
			},
		},
	}

	resp, err := request.HttpRequest(apiURL, http.MethodPost, headers, nil, body)
	if err != nil {
		return fmt.Errorf("qq gdt request failed: %w", err)
	}
	defer resp.Body.Close()

	var result qqGDTUploadResponse
	if err := json.NewDecoder(resp.Body).Decode(&result); err != nil {
		return fmt.Errorf("qq gdt decode response failed: %w", err)
	}

	if result.Code != 0 {
		return fmt.Errorf("qq gdt callback failed: code=%d message=%s trace_id=%s", result.Code, result.Message, result.TraceID)
	}

	return nil
}

// UploadConversionWithRetry 带重试的回传
func (p *QQGDTProvider) UploadConversionWithRetry(ctx context.Context, req *ConversionRequest, maxRetries int) error {
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
	return fmt.Errorf("qq gdt upload failed after %d retries: %w", maxRetries, lastErr)
}

func init() {
	GetDefaultFactory().Register(NewQQGDTProvider())
}

var _ CallbackProvider = (*QQGDTProvider)(nil)
