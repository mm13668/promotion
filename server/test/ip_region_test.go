package test

import (
	"github.com/flipped-aurora/gin-vue-admin/server/utils"
	"testing"
)

func TestIp(t *testing.T) {
	res := utils.GetIpRegion("42.194.192.36")
	t.Log(res)
}
