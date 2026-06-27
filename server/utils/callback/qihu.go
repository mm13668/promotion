package callback

import (
	"bytes"
	"context"
	"crypto/md5"
	"encoding/hex"
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"time"

	"github.com/flipped-aurora/gin-vue-admin/server/utils/request"
)

const (
	QihuProviderName = "360_ocpc"
	qihuApiUrl       = "https://convert.dop.360.cn/uploadWebConvert"
)

// qihuConversionTypeMap 转化类型编号到360点睛API事件名的映射
// 转化类型: 3=表单提交, 49=注册登录, 27=客户自定义, 19=有效咨询, 30=电话拨通
// 注意: 35(微信复制)不在360回传映射范围内
var qihuConversionTypeMap = map[int]string{
	3:  "SUBMIT",
	49: "REGISTERED",
	27: "COUSTOMIZE",
	19: "ADVISORY",
	30: "CALL",
}

type QihuProvider struct{}

func NewQihuProvider() *QihuProvider {
	return &QihuProvider{}
}

func (p *QihuProvider) Name() string {
	return QihuProviderName
}

func (p *QihuProvider) GetToken(ocpcKey string) string {
	return ocpcKey
}

type qihuUploadRequest struct {
	Data qihuRequestData `json:"data"`
}

type qihuRequestData struct {
	RequestTime  int64          `json:"request_time,omitempty"`
	DataIndustry string         `json:"data_industry"`
	DataDetail   qihuDataDetail `json:"data_detail"`
}

type qihuDataDetail struct {
	Qhclickid  string          `json:"qhclickid,omitempty"`
	TransID    string          `json:"trans_id,omitempty"`
	Event      string          `json:"event"`
	EventTime  int64           `json:"event_time,omitempty"`
	EventParam *qihuEventParam `json:"event_param,omitempty"`
}

type qihuEventParam struct {
	Value int64 `json:"value,omitempty"`
	Score int   `json:"score,omitempty"`
}

type qihuUploadResponse struct {
	Errno int    `json:"errno"`
	Error string `json:"error"`
}

func (p *QihuProvider) UploadConversion(ctx context.Context, req *ConversionRequest) error {
	if req.ClickId == "" {
		return fmt.Errorf("360 ocpc callback requires qhclickid, but got empty")
	}

	event, ok := qihuConversionTypeMap[req.ConversionType]
	if !ok {
		event = qihuConversionTypeMap[27]
		//return fmt.Errorf("360 ocpc unsupported conversion type: %d", req.ConversionType)
	}

	eventTime := req.ConversionTime
	if eventTime == 0 {
		eventTime = time.Now().Unix()
	}

	body := qihuUploadRequest{
		Data: qihuRequestData{
			RequestTime:  time.Now().Unix(),
			DataIndustry: "ocpc_ps_convert",
			DataDetail: qihuDataDetail{
				Qhclickid: req.ClickId,
				Event:     event,
				EventTime: eventTime,
			},
		},
	}

	// SUBMIT事件需要trans_id用于去重
	if event == "SUBMIT" {
		body.Data.DataDetail.TransID = generateQihuTransID(req.ClickId, event)
	}

	bodyBytes, err := json.Marshal(body)
	if err != nil {
		return fmt.Errorf("360 ocpc marshal request failed: %w", err)
	}

	appSign := calculateQihuAppSign(req.Secret, bodyBytes)

	headers := map[string]string{
		"Content-Type": "application/json;charset=utf-8",
		"App-Key":      req.Token,
		"App-Sign":     appSign,
	}

	resp, err := request.HttpRequest(qihuApiUrl, http.MethodPost, headers, nil, json.RawMessage(bodyBytes))
	if err != nil {
		return fmt.Errorf("360 ocpc request failed: %w", err)
	}
	defer resp.Body.Close()

	respBody, err := io.ReadAll(resp.Body)
	if err != nil {
		return fmt.Errorf("360 ocpc read response failed: %w", err)
	}

	var result qihuUploadResponse
	if err := json.Unmarshal(respBody, &result); err != nil {
		return fmt.Errorf("360 ocpc decode response failed: body=%s err=%w", string(respBody), err)
	}

	if result.Errno != 0 {
		return fmt.Errorf("360 ocpc callback failed: errno=%d error=%s", result.Errno, result.Error)
	}

	return nil
}

func (p *QihuProvider) UploadConversionWithRetry(ctx context.Context, req *ConversionRequest, maxRetries int) error {
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
	return fmt.Errorf("360 ocpc upload failed after %d retries: %w", maxRetries, lastErr)
}

// calculateQihuAppSign 计算360点睛API签名
// App-Sign = md5(Secret + POSTDATA)
func calculateQihuAppSign(secret string, body []byte) string {
	buf := bytes.NewBufferString(secret)
	buf.Write(body)
	hash := md5.Sum(buf.Bytes())
	return hex.EncodeToString(hash[:])
}

// generateQihuTransID 生成trans_id用于去重
func generateQihuTransID(clickid string, event string) string {
	data := clickid + event
	hash := md5.Sum([]byte(data))
	return hex.EncodeToString(hash[:])
}

func init() {
	GetDefaultFactory().Register(NewQihuProvider())
}

var _ CallbackProvider = (*QihuProvider)(nil)
