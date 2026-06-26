# 需求
增加模板 template-05

框架样式照搬，内容替换为模板内容，模板没有的内容，自己决定写死，还是怎么样

模板目录
/Users/wangjingjun/work/promotion/server/uploads/template

模板的内容布局要参考 https://tieba.baidu.com/f?kw=%E6%97%85%E6%B8%B8%E5%90%A7&fr=home

我已经下载页面在
/Users/wangjingjun/work/promotion/docs/2026/06/feature/008luyouba/旅游吧吧-百度贴吧.html
/Users/wangjingjun/work/promotion/docs/2026/06/feature/008luyouba/旅游吧吧-百度贴吧_files

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

其他的数据上报统计，昵称替换等都需要保存这些功能

要求：移动端支持自适应

# 涉及文件
模板目录：/Users/wangjingjun/work/promotion/server/uploads/template/
发布更新推广链接函数位置：/Users/wangjingjun/work/promotion/server/service/promotion/link_service.go func (s *LinkService) PublishPromotionLink(linkId uint) error {


包含的功能：
- SEO 标题/关键词/描述 (SeoTitle, SeoKeywords, SeoDescription)
- 客服随机分配与本地存储缓存
- 全局复制微信 + 上报 reportCopy
- 变量替换 (##昵称加号码##, ##昵称##, ##号码##, ##ta##)
- 访问统计上报 (init + 定时 duration)
- 登录/注册弹窗 + 手机号提交
- 回复输入/发布 (集成 landingMessage/create)
- 插件插槽 (#plugin-copy, #plugin-bottom, #plugin-qrcode)