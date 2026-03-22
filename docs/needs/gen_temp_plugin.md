# 需求
生成模版和插件

## 参考图片，并按照管理后台配置，结合推广链接的配置，根据模板、插件和内容生成静态页面，html5静态页面生成方案，

## 有些插件和模版需要事先实现的，给我生成，放在
1. 生成的模版文件放在目录 /Users/wangjingjun/work/promotion/server/uploads/template 下，mobile是移动端，pc是PC端
2. 生成的模版文件放在目录 /Users/wangjingjun/work/promotion/server/uploads/plugins 下，以wechat-copy开头是手机复制插件，bottom-bar开头是手机底部插件,pc-qrcode开头是电脑端二维码插件

## 然后根据这些模版插件，完善一个实现生成静态推广页面，并返回生成推广链接的后端逻辑

# 推广链接相关
sql: /Users/wangjingjun/work/promotion/docs/plan/promotion_link_settings_schema.sql
管理后台前端页面：/Users/wangjingjun/work/promotion/web/src/view/promotion/link/index.vue
业务生成推广链接代码：
```业务生成推广链接代码
// PublishPromotionLink 发布推广链接，生成移动端和PC端页面
func (s *LinkService) PublishPromotionLink(
```

# 模版
## 模板目录结构
templates/
├── mobile/
│    ├── template-08/
│    │    ├── index.html
│    │    ├── style.css
│    │    └── script.js
│
├── pc/
│    ├── template-01/

## 模板写法
<div class="title">{{title}}</div>
<div class="question">{{question}}</div>
<div class="content">{{content}}</div>

<!-- 插件插槽 -->
<div id="plugin-copy"></div>
<div id="plugin-bottom"></div>

# 插件
## 插件目录结构
plugins/
├── wechat-copy-1/
│    ├── index.html
│    ├── style.css
│    └── script.js
│
├── bottom-bar-1/

## 插件 HTML 示例（复制微信）
<div class="wechat-copy">
  <button onclick="copyWechat()">复制微信</button>
</div>

function copyWechat() {
const wechat = "{{wechat}}";
navigator.clipboard.writeText(wechat);
alert("复制成功");
}

# 插件注入方式：字符串替换
html = html.replace(
'<div id="plugin-copy"></div>',
pluginHtml
);

# CSS / JS 合并策略
推荐做法：
1️⃣ 插件样式隔离（很关键）
.wechat-copy {
position: fixed;
bottom: 100px;
}

👉 加前缀防污染：

.plugin-wechat-copy { }
2️⃣ JS隔离
(function(){
function copyWechat(){...}
window.copyWechat = copyWechat;
})();

# 静态化部署
本地生成
/dist/123.html

# 生成简单代码示例
/Users/wangjingjun/work/promotion/docs/needs/gen_code.md