package utils

import (
	"net"
	"strings"

	"github.com/gin-gonic/gin"
)

// GetClientIP 获取用户真实IP
// 阿里云CDN场景：优先 Ali-CDN-Real-IP，其次 X-Real-IP，再 X-Forwarded-For，最后回退
func GetClientIP(c *gin.Context) string {
	// 0. 阿里云CDN自动注入的真实客户端IP（最可靠）
	if aliIP := strings.TrimSpace(c.GetHeader("Ali-CDN-Real-IP")); aliIP != "" {
		if !isPrivateIP(aliIP) {
			return aliIP
		}
	}

	// 1. X-Real-IP
	if xRealIP := strings.TrimSpace(c.GetHeader("X-Real-IP")); xRealIP != "" {
		if !isPrivateIP(xRealIP) {
			return xRealIP
		}
	}

	// 2. X-Forwarded-For: client, proxy1, proxy2 (从右往左找第一个公网IP)
	if xff := c.GetHeader("X-Forwarded-For"); xff != "" {
		parts := strings.Split(xff, ",")
		for i := len(parts) - 1; i >= 0; i-- {
			ip := strings.TrimSpace(parts[i])
			if ip != "" && !isPrivateIP(ip) {
				return ip
			}
		}
		// 全是内网则取最左侧（最原始客户端）
		if first := strings.TrimSpace(parts[0]); first != "" {
			return first
		}
	}

	// 3. 回退到 Gin 默认
	return c.ClientIP()
}

// isPrivateIP 判断是否为内网/保留 IP
func isPrivateIP(ipStr string) bool {
	ip := net.ParseIP(ipStr)
	if ip == nil {
		return false
	}

	// 常见的私有/保留地址段
	privateCIDRs := []string{
		"10.0.0.0/8",
		"172.16.0.0/12",
		"192.168.0.0/16",
		"127.0.0.0/8",
		"::1/128",
		"fc00::/7",
	}

	for _, cidr := range privateCIDRs {
		_, network, _ := net.ParseCIDR(cidr)
		if network.Contains(ip) {
			return true
		}
	}
	return false
}
