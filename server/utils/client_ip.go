package utils

import (
	"net"
	"strings"

	"github.com/gin-gonic/gin"
)

// GetClientIP 获取用户真实IP
// 优先从 X-Forwarded-For 取第一个非内网IP，其次 X-Real-IP，最后回退到 Gin 的 ClientIP()
func GetClientIP(c *gin.Context) string {
	// 1. 尝试 X-Forwarded-For
	xForwardedFor := c.GetHeader("X-Forwarded-For")
	if xForwardedFor != "" {
		parts := strings.Split(xForwardedFor, ",")
		// 从右往左找到第一个公网 IP（X-Forwarded-For 格式: client, proxy1, proxy2）
		for i := len(parts) - 1; i >= 0; i-- {
			ip := strings.TrimSpace(parts[i])
			if ip != "" && !isPrivateIP(ip) {
				return ip
			}
		}
		// 如果全是内网 IP，取最左侧（最原始客户端）
		if first := strings.TrimSpace(parts[0]); first != "" {
			return first
		}
	}

	// 2. 尝试 X-Real-IP
	if xRealIP := c.GetHeader("X-Real-IP"); xRealIP != "" {
		return xRealIP
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
