package middleware

import (
	"net/http"
	"sync"
	"time"

	"github.com/flipped-aurora/gin-vue-admin/server/model/common/response"
	"github.com/flipped-aurora/gin-vue-admin/server/utils"
	"github.com/gin-gonic/gin"
)

type rateLimitEntry struct {
	count    int
	expireAt time.Time
}

type IPRateLimiter struct {
	mu      sync.Mutex
	entries map[string]*rateLimitEntry
	limit   int
	window  time.Duration
}

func NewIPRateLimiter(limit int, window time.Duration) *IPRateLimiter {
	rl := &IPRateLimiter{
		entries: make(map[string]*rateLimitEntry),
		limit:   limit,
		window:  window,
	}
	go rl.cleanup()
	return rl
}

func (rl *IPRateLimiter) Allow(ip string) bool {
	rl.mu.Lock()
	defer rl.mu.Unlock()

	now := time.Now()
	entry, ok := rl.entries[ip]
	if !ok || now.After(entry.expireAt) {
		rl.entries[ip] = &rateLimitEntry{
			count:    1,
			expireAt: now.Add(rl.window),
		}
		return true
	}
	if entry.count >= rl.limit {
		return false
	}
	entry.count++
	return true
}

func (rl *IPRateLimiter) cleanup() {
	ticker := time.NewTicker(10 * time.Minute)
	for range ticker.C {
		rl.mu.Lock()
		now := time.Now()
		for ip, entry := range rl.entries {
			if now.After(entry.expireAt) {
				delete(rl.entries, ip)
			}
		}
		rl.mu.Unlock()
	}
}

var contactFormLimiter = NewIPRateLimiter(3, 60*time.Second)

func ContactFormRateLimit() gin.HandlerFunc {
	return func(c *gin.Context) {
		ip := utils.GetClientIP(c)
		if !contactFormLimiter.Allow(ip) {
			response.FailWithMessage("提交过于频繁，请稍后再试", c)
			c.AbortWithStatus(http.StatusTooManyRequests)
			return
		}
		c.Next()
	}
}
