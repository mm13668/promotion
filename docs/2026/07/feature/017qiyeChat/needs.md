# 需求
落地页接入企业微信添加和加粉丝回调

## 成员管理
在页面 /Users/wangjingjun/work/promotion/web/src/view/promotion/member/index.vue
增加获客助手链接的编辑
表group_member 增加字段 获客助手链接

## 推广链接设置是否优先使用获客助手链接
在页面 /Users/wangjingjun/work/promotion/web/src/view/promotion/link/index.vue
显示12301投诉电话上方增加 是否优先使用获客助手链接，备注是开启跳转到添加企业微信账号

## 模板插件
在页面/Users/wangjingjun/work/promotion/server/uploads/plugins
修改 bottom-bar-* 插件，支持优先使用获客助手链接
开关开启，使用获客助手链接
放在移动端底部，文字 【点此咨询 给您详细介绍】，可以做成底部悬浮的按钮

## 推广链接-发布更新
在页面 /Users/wangjingjun/work/promotion/server/api/v1/promotion/link.go 
// PublishPromotionLink 发布推广链接，生成移动端和PC端页面
func (s *LinkService) PublishPromotionLink(linkId uint) error {

发布推广链接时，如果开启了优先使用获客助手链接，开关数据传到模板插件中，
开关开启，bottom-bar-*  使用获客助手链接，用户点击该链接，直接跳转到企业微信添加微信了

## 添加企业微信成功回调通知添加成功
在适当位置实现这个功能