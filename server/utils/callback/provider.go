package callback

import (
	"context"
	"net/url"
)

// ConversionRequest OCPC转化回传请求
type ConversionRequest struct {
	Token          string // 广告平台token
	Secret         string // 广告平台Secret(用于签名)
	LogidUrl       string // 点击URL(含bd_vid参数)
	ClickId        string // 广告点击ID(如巨量引擎的clickid)
	ConversionType int    // 转化类型编号
	ConversionTime int64  // 转化发生时间(unix时间戳,0表示不传)
}

// ExtractClickId 从URL中提取广告点击ID参数
// 根据平台名称提取对应的点击ID参数
func ExtractClickId(rawUrl string, providerName string) string {
	if rawUrl == "" {
		return ""
	}
	u, err := url.Parse(rawUrl)
	if err != nil {
		return ""
	}
	switch providerName {
	case QihuProviderName:
		return u.Query().Get("qhclickid")
	default:
		return u.Query().Get("clickid")
	}
}

// CallbackProvider OCPC回传提供者接口
// 后续接入其他广告平台时，实现此接口即可
type CallbackProvider interface {
	// Name 返回广告平台唯一标识
	Name() string
	// GetToken 解析 ocpc_key 为平台需要的 token
	GetToken(ocpcKey string) string
	// UploadConversion 上传转化数据到广告平台
	UploadConversion(ctx context.Context, req *ConversionRequest) error
}
