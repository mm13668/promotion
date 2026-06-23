# 需求
1. 修改后台提示词
页面 /Users/wangjingjun/work/promotion/web/src/view/qa/question/index.vue 
内容（客服昵称使用统一`##昵称加号码##`代替）替换为 内容（客服昵称号码使用统一`##昵称加号码##`代替，仅昵称使用统一`##昵称##`代替，客服号码使用统一`##号码##`代替）

2. 根据提示词，修改模板
   /Users/wangjingjun/work/promotion/server/uploads/template
html = html.replace(/##昵称加号码##/g, wechatHtml);

其中，##昵称## 只是展示昵称，点击没有其他反应
##号码## 只展示替换为展示号码，点击号码，的作用跟 ##昵称加号码## 一样，都需要弹窗复制号码