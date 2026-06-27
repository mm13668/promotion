package callback

import (
	"context"
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"net/http/httptest"
	"testing"
	"time"
)

func TestOceanEngineProvider_Name(t *testing.T) {
	p := NewOceanEngineProvider()
	if p.Name() != "oceanengine" {
		t.Errorf("expected name 'oceanengine', got '%s'", p.Name())
	}
}

func TestOceanEngineProvider_GetToken(t *testing.T) {
	p := NewOceanEngineProvider()
	token := p.GetToken("test-token")
	if token != "test-token" {
		t.Errorf("expected token 'test-token', got '%s'", token)
	}
}

func TestOceanEngineProvider_UploadConversion_EmptyClickId(t *testing.T) {
	p := NewOceanEngineProvider()
	req := &ConversionRequest{
		ClickId:        "",
		ConversionType: 3,
	}
	err := p.UploadConversion(context.Background(), req)
	if err == nil {
		t.Error("expected error for empty clickid, got nil")
	}
}

func TestOceanEngineProvider_UploadConversion_UnsupportedType(t *testing.T) {
	p := NewOceanEngineProvider()
	req := &ConversionRequest{
		ClickId:        "test_click_id",
		ConversionType: 999,
	}
	err := p.UploadConversion(context.Background(), req)
	if err == nil {
		t.Error("expected error for unsupported conversion type, got nil")
	}
}

func TestOceanEngineProvider_UploadConversion_Success(t *testing.T) {
	// 创建模拟服务器
	var receivedBody []byte
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		var err error
		receivedBody, err = io.ReadAll(r.Body)
		if err != nil {
			t.Errorf("failed to read request body: %v", err)
		}
		w.Header().Set("Content-Type", "application/json")
		w.Write([]byte(`{"code":0,"message":"成功"}`))
	}))
	defer server.Close()

	// 保存原始URL，测试后恢复
	originalUrl := oceanEngineApiUrl
	oceanEngineApiUrl = server.URL
	defer func() { oceanEngineApiUrl = originalUrl }()

	p := NewOceanEngineProvider()
	req := &ConversionRequest{
		ClickId:        "EPHk9cX3pv4CGJax4ZENKI7w4MDev_4C",
		ConversionType: 3, // form
		ConversionTime: 1604888786102,
	}

	err := p.UploadConversion(context.Background(), req)
	if err != nil {
		t.Errorf("expected no error, got: %v", err)
	}

	// 验证请求体
	var body oceanEngineUploadRequest
	if err := json.Unmarshal(receivedBody, &body); err != nil {
		t.Errorf("failed to unmarshal request body: %v", err)
	}

	if body.EventType != "form" {
		t.Errorf("expected event_type 'form', got '%s'", body.EventType)
	}
	if body.Context.Ad.Callback != "EPHk9cX3pv4CGJax4ZENKI7w4MDev_4C" {
		t.Errorf("expected callback 'EPHk9cX3pv4CGJax4ZENKI7w4MDev_4C', got '%s'", body.Context.Ad.Callback)
	}
	if body.Timestamp != 1604888786102 {
		t.Errorf("expected timestamp 1604888786102, got %d", body.Timestamp)
	}
	fmt.Println("receivedBody", string(receivedBody))
}

func TestOceanEngineProvider_UploadConversion_FormSubmit(t *testing.T) {
	testConversionType(t, 3, "form")
}

func TestOceanEngineProvider_UploadConversion_WechatCopy(t *testing.T) {
	testConversionType(t, 35, "wechat")
}

func TestOceanEngineProvider_UploadConversion_Register(t *testing.T) {
	testConversionType(t, 49, "active_register")
}

func testConversionType(t *testing.T, conversionType int, expectedEventType string) {
	t.Helper()

	var receivedBody []byte
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		receivedBody, _ = io.ReadAll(r.Body)
		w.Header().Set("Content-Type", "application/json")
		w.Write([]byte(`{"code":0,"message":"成功"}`))
	}))
	defer server.Close()

	originalUrl := oceanEngineApiUrl
	oceanEngineApiUrl = server.URL
	defer func() { oceanEngineApiUrl = originalUrl }()

	p := NewOceanEngineProvider()
	req := &ConversionRequest{
		ClickId:        "test_click_id",
		ConversionType: conversionType,
	}

	err := p.UploadConversion(context.Background(), req)
	if err != nil {
		t.Errorf("expected no error for conversion type %d, got: %v", conversionType, err)
	}

	var body oceanEngineUploadRequest
	json.Unmarshal(receivedBody, &body)

	if body.EventType != expectedEventType {
		t.Errorf("expected event_type '%s' for conversion type %d, got '%s'", expectedEventType, conversionType, body.EventType)
	}
}

func TestOceanEngineProvider_UploadConversion_DefaultTimestamp(t *testing.T) {
	var receivedBody []byte
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		receivedBody, _ = io.ReadAll(r.Body)
		w.Header().Set("Content-Type", "application/json")
		w.Write([]byte(`{"code":0,"message":"成功"}`))
	}))
	defer server.Close()

	originalUrl := oceanEngineApiUrl
	oceanEngineApiUrl = server.URL
	defer func() { oceanEngineApiUrl = originalUrl }()

	before := time.Now().UnixMilli()
	p := NewOceanEngineProvider()
	req := &ConversionRequest{
		ClickId:        "test_click_id",
		ConversionType: 3,
		ConversionTime: 0, // 不传时间，应使用当前时间
	}

	err := p.UploadConversion(context.Background(), req)
	if err != nil {
		t.Errorf("expected no error, got: %v", err)
	}

	after := time.Now().UnixMilli()

	var body oceanEngineUploadRequest
	json.Unmarshal(receivedBody, &body)

	if body.Timestamp < before || body.Timestamp > after {
		t.Errorf("expected timestamp between %d and %d, got %d", before, after, body.Timestamp)
	}
}

func TestOceanEngineProvider_UploadConversion_ApiError(t *testing.T) {
	server := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "application/json")
		w.Write([]byte(`{"code":40001,"message":"invalid parameter"}`))
	}))
	defer server.Close()

	originalUrl := oceanEngineApiUrl
	oceanEngineApiUrl = server.URL
	defer func() { oceanEngineApiUrl = originalUrl }()

	p := NewOceanEngineProvider()
	req := &ConversionRequest{
		ClickId:        "test_click_id",
		ConversionType: 3,
	}

	err := p.UploadConversion(context.Background(), req)
	if err == nil {
		t.Error("expected error for API error response, got nil")
	}
}

func TestOceanEngineFactory_HasOceanEngineProvider(t *testing.T) {
	factory := GetDefaultFactory()
	provider, err := factory.GetProvider("oceanengine")
	if err != nil {
		t.Errorf("expected to find oceanengine provider, got error: %v", err)
	}
	if provider == nil {
		t.Error("expected provider instance, got nil")
	}
	if provider.Name() != "oceanengine" {
		t.Errorf("expected provider name 'oceanengine', got '%s'", provider.Name())
	}
}
