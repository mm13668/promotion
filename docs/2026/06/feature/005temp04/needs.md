# 需求
增加老毛桃模板 template-03

模板目录
/Users/wangjingjun/work/promotion/server/uploads/template

模板的内容布局要参考 https://www.laomaotao.net/help/2020/0806/8620.html
可以参考其他模板的变量使用
要做的跟官网差不多的样子，然后查看新闻详情页的模样
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


要求：移动端支持自适应

# 涉及文件
模板目录：/Users/wangjingjun/work/promotion/server/uploads/template/
发布更新推广链接函数位置：/Users/wangjingjun/work/promotion/server/service/promotion/link_service.go func (s *LinkService) PublishPromotionLink(linkId uint) error {
