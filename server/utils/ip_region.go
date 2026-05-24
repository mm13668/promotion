package utils

import (
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"sync"
	"time"

	"golang.org/x/text/encoding/simplifiedchinese"
	"golang.org/x/text/transform"
)

var ipCache sync.Map

type pconlineIpResponse struct {
	IP   string `json:"ip"`
	Pro  string `json:"pro"`
	City string `json:"city"`
	Addr string `json:"addr"`
}

type ipCacheEntry struct {
	Region   string
	CachedAt time.Time
}

const (
	ipCacheTTL   = 24 * time.Hour
	ipApiTimeout = 3 * time.Second
	ipApiURL     = "https://whois.pconline.com.cn/ipJson.jsp"
)

// GetIpRegion resolves IP to province/city (e.g. "广东省 广州市").
// Uses PCOnline's free IP API + in-memory cache.
// Returns empty string on failure.
func GetIpRegion(ip string) string {
	if ip == "" || ip == "127.0.0.1" || ip == "::1" {
		return ""
	}

	if cached, ok := ipCache.Load(ip); ok {
		entry := cached.(ipCacheEntry)
		if time.Since(entry.CachedAt) < ipCacheTTL {
			return entry.Region
		}
		ipCache.Delete(ip)
	}

	region := queryPconline(ip)
	ipCache.Store(ip, ipCacheEntry{Region: region, CachedAt: time.Now()})
	return region
}

func queryPconline(ip string) string {
	client := &http.Client{Timeout: ipApiTimeout}
	url := fmt.Sprintf("%s?ip=%s&json=true", ipApiURL, ip)

	resp, err := client.Get(url)
	if err != nil {
		return ""
	}
	defer resp.Body.Close()

	// PCOnline API returns GBK-encoded data; decode to UTF-8.
	utf8Reader := transform.NewReader(resp.Body, simplifiedchinese.GBK.NewDecoder())
	body, err := io.ReadAll(utf8Reader)
	if err != nil {
		return ""
	}

	var result pconlineIpResponse
	if err := json.Unmarshal(body, &result); err != nil {
		return ""
	}

	return formatRegion(result)
}

func formatRegion(r pconlineIpResponse) string {
	if r.Addr != "" {
		return r.Addr
	}
	if r.Addr == "" && r.Pro == "" && r.City == "" {
		return ""
	}
	if r.Pro == r.City || r.City == "" {
		return fmt.Sprintf("%s %s", r.Addr, r.Pro)
	}
	return fmt.Sprintf("%s %s %s", r.Addr, r.Pro, r.City)
}
