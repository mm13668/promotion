# 需求
模版内容增加 ##ta## 根据客服成员的性别 发布更新时替换成 他 或 她

1. 发布更新推广链接 
// 4. 查询所有客服信息，用于前端随机展示
group_member表 性别字段gender 值：男 女
性别需要 参考昵称 nickname 的传递，传到模板文件去替换

2. 参考下面，修改模板
已有 html = html.replace(/##昵称加号码##/g, wechatHtml);
替换参考代码 html = html.replace(/##ta##/g, wechatHtml);


# 涉及文件
模板目录：/Users/wangjingjun/work/promotion/server/uploads/template/
发布更新推广链接函数位置：/Users/wangjingjun/work/promotion/server/service/promotion/link_service.go 
func (s *LinkService) PublishPromotionLink(linkId uint) error {