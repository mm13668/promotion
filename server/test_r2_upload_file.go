package main

import (
	"mime/multipart"
	"os"
	"path/filepath"

	"github.com/flipped-aurora/gin-vue-admin/server/global"
	"github.com/flipped-aurora/gin-vue-admin/server/utils/upload"
	"gopkg.in/yaml.v3"
)

// 加载配置
func loadConfig() error {
	data, err := os.ReadFile("config.yaml")
	if err != nil {
		return err
	}
	return yaml.Unmarshal(data, &global.GVA_CONFIG)
}

func main() {
	// 切换到server目录
	if err := os.Chdir("/Users/wangjingjun/work/promotion/server"); err != nil {
		panic(err)
	}

	// 加载配置
	if err := loadConfig(); err != nil {
		panic("加载配置失败: " + err.Error())
	}

	// 要上传的文件路径
	filePath := "/Users/wangjingjun/work/promotion/server/uploads/dist/V4N9HIZs/pc/index.html"

	// 打开文件
	file, err := os.Open(filePath)
	if err != nil {
		panic("打开文件失败: " + err.Error())
	}
	defer file.Close()

	// 构造multipart.FileHeader
	fileInfo, err := file.Stat()
	if err != nil {
		panic("获取文件信息失败: " + err.Error())
	}

	fh := &multipart.FileHeader{
		Filename: filepath.Base(filePath),
		Size:     fileInfo.Size(),
		Header:   make(map[string][]string),
	}

	// 调用上传函数
	r2 := &upload.CloudflareR2{}
	url, key, err := r2.UploadFile(fh)
	if err != nil {
		panic("上传失败: " + err.Error())
	}

	println("上传成功！")
	println("文件URL:", url)
	println("文件Key:", key)
}
