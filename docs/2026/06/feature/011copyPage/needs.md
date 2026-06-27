# 需求
页面可视化管理
/Users/wangjingjun/work/promotion/web/src/view/qa/page-visual/index.vue
右边的
评论管理 回复管理

支持拖动排序，更新表 表qa_reply 和qa_answer 增加排序字段，左边预览跟随者位置变化



相应的这个页面的 评论管理 回复管理 也需要增加排序字段的编辑和展示
/Users/wangjingjun/work/promotion/web/src/view/qa/question/index.vue


最后在发布落地页时候，需要根据排序值，从大到小，排序查询出来生成静态页面
// PublishPromotionLink 发布推广链接，生成移动端和PC端页面
func (s *LinkService) PublishPromotionLink(