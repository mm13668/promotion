# 需求
问题管理页面 /Users/wangjingjun/work/promotion/web/src/view/qa/question/index.vue
回答管理页面 /Users/wangjingjun/work/promotion/web/src/view/qa/answer/index.vue
回复管理页面 /Users/wangjingjun/work/promotion/web/src/view/qa/reply/index.vue

根据文件 /Users/wangjingjun/work/promotion/docs/plan/qa_management_schema.sql 下的表设计的关联关系，把 回答管理 和 回答中的 回复管理 放在同一个页面问题管理页面展示编辑,为了方便集中管理

问题管理页面中的所有的状态 改为el-switch开关的模式 ，所有的 内容 改为富文本编辑器 <RichEdit v-model="form.content" :height="400" />

回答管理 和 回复管理 中的状态 同样改为el-switch开关的模式 ，内容改为富文本编辑器


# 需求2
根据图片内容，不要修改图片字段，修改一下文件中的创建表语句，并在问题管理页面页面实现图片那种编辑管理
/Users/wangjingjun/work/promotion/docs/plan/qa_management_schema.sql