package callback

import "context"

// ConversionRequest OCPC转化回传请求
type ConversionRequest struct {
	Token          string // 广告平台token
	LogidUrl       string // 点击URL(含bd_vid参数)
	ClickId        string // 广告点击ID(如巨量引擎的clickid)
	ConversionType int    // 转化类型编号
	ConversionTime int64  // 转化发生时间(unix时间戳,0表示不传)
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
