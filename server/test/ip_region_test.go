package test

import (
	"github.com/flipped-aurora/gin-vue-admin/server/utils"
	"testing"
)

func TestIp(t *testing.T) {
	res := utils.GetIpRegion("43.133.7.32")
	t.Log(res)
}
