# 需求
增加空模板 template-00

模板目录
/Users/wangjingjun/work/promotion/server/uploads/template

模板的内容
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{{if .SeoTitle}}{{.SeoTitle}}{{else}}{{.QuestionTitle}}{{end}}</title>
    {{if .SeoKeywords}}
    <meta name="keywords" content="{{.SeoKeywords}}">
    {{end}}
    {{if .SeoDescription}}
    <meta name="description" content="{{.SeoDescription}}">
    {{end}}
</head>
<body>{{.QuestionContent}}
</body>

其他的数据上报统计，客服昵称替换等都需要保存这些功能
只是模板内容，自定义而已

样式全部都需要自定义
要求：移动端支持自适应

目的：我要在富文本中填写内容，通过模板生成展示出来，只需要展示模板内容

# 涉及文件
模板目录：/Users/wangjingjun/work/promotion/server/uploads/template/
发布更新推广链接函数位置：/Users/wangjingjun/work/promotion/server/service/promotion/link_service.go func (s *LinkService) PublishPromotionLink(linkId uint) error {
