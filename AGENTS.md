# 项目规范与协作指南（AGENTS）

本文定义本仓库的工程化规范、协作流程与 AI/MCP 编辑器协作约定，确保多人协作可持续交付与质量稳定。

## 1. 总览

- 技术栈：Go(Gin) + Gorm / MySQL / Redis；前端 Vue3 + Vite + Element Plus
- 工作区：VSCode 工作区文件支持联调调试，见 [gin-vue-admin.code-workspace](file:///Users/wangjingjun/work/promotion/gin-vue-admin.code-workspace)
- 业务文档与 SQL：集中在 [docs/plan](file:///Users/wangjingjun/work/promotion/docs/plan)
- MCP 集成：编辑器配置见 [.trae/config.json](file:///Users/wangjingjun/work/promotion/.trae/config.json)，服务端参数见 [server/config.yaml](file:///Users/wangjingjun/work/promotion/server/config.yaml)

## 2. 目录与命名

- 后端：[server](file:///Users/wangjingjun/work/promotion/server)
  - api（输入/输出绑定）、service（业务逻辑）、model（数据结构）、router（路由）、utils（工具）、config（配置结构体）
  - 包名使用小写、短名；文件名使用下划线分隔；函数/结构体使用驼峰命名
- 前端：[web](file:///Users/wangjingjun/work/promotion/web)
  - src/api、src/view、src/components、src/utils 等分层清晰；组件名使用大驼峰；文件名使用小写中划线
- 文档：[docs/plan](file:///Users/wangjingjun/work/promotion/docs/plan)
  - 模块_用途_schema.sql：仅建表/注释
  - 模块_用途_seed.sql：演示数据或种子数据
  - 模块_用途_api.md：接口与查询示例

## 3. Git 流程与提交

- 分支模型：main（稳定）、dev（集成）、feature/*（功能）、fix/*（修复）
- 提交信息：采用 Conventional Commits
  - feat: 新功能
  - fix: 缺陷修复
  - docs: 文档更新
  - refactor: 重构（无功能变更）
  - perf: 性能优化
  - test: 测试相关
  - chore/build/ci: 其他工程化变更

## 4. 后端开发规范（Go/Gin）

- 分层约定
  - api 层做入参校验与 DTO 绑定，不写业务
  - service 层实现业务编排与事务控制
  - model 定义 ORM 模型、请求/响应结构体
  - router 集中声明路由与中间件
- 配置管理
  - 统一通过 [server/config.yaml](file:///Users/wangjingjun/work/promotion/server/config.yaml) 管理；敏感信息使用环境变量或密钥管理系统，不写死
  - CORS 白名单严格配置，避免放开 *
- 日志与错误
  - 使用 zap 记录关键路径日志；禁止输出敏感数据（如 token/密码）
  - 统一响应结构（code/data/msg），与前端 error-handling 对齐
- ORM 与数据库
  - 使用 Gorm；事务显式控制（Begin/Commit/Rollback），避免在循环内频繁开启事务
  - 默认软删除采用 deleted_at 字段，审计字段 created_at/updated_at/created_by/updated_by 建议保留
  - 表和字段必须写 COMMENT，字符集一律 utf8mb4，存储引擎 InnoDB
  - 外键策略：父子强依赖使用 CASCADE；可选关系使用 SET NULL；跨域弱耦合使用 RESTRICT
  - 索引命名：uk_*（唯一）、idx_*（普通）
- API 设计
  - RESTful 风格，资源名建议使用复数；分页参数 page/pageSize，过滤与排序使用 querystring
  - Swagger：安装 swag 后在 server 目录执行 `swag init`，访问 /swagger 查看

## 5. 前端开发规范（Vue3/Vite）

- 代码风格
  - 使用 Composition API；组件名大驼峰，props 使用小驼峰
  - 状态管理使用 Pinia；网络请求封装在 [web/src/utils/request.js](file:///Users/wangjingjun/work/promotion/web/src/utils/request.js)
  - UI 统一使用 Element Plus；主题色统一管理，变量集中
- 路由与权限
  - 路由守卫与动态菜单遵循 gin-vue-admin 既有模式，权限点与后端保持一致
- 构建与脚本
  - 开发：`npm run serve`；构建：`npm run build`；预览：`npm run preview`

## 6. 数据库与文档规范

- 新增表必须：
  - 表级 COMMENT 说明业务归属
  - 每个字段提供 COMMENT；时间/审计/软删除字段建议保留
  - 创建必要索引；保持命名统一
- 文档产出：
  - 建表脚本放入 docs/plan，遵循命名规范
  - 如需提供接口样例或查询示例，补充 *_api.md
  - 涉及演示/回归校验的数据，提供 *_seed.sql

## 7. 接口联调与响应约定

- 统一响应结构（示例）：
  ```json
  { "code": 0, "data": { /* payload */ }, "msg": "ok" }
  ```
- 错误处理：后端返回明确的业务错误码与信息；前端在 request 拦截器中统一处理未登录/权限不足等场景
- 分页返回：`list` + `total` + 分页参数回显

## 8. 安全与合规

- 密钥/令牌不入库、不入仓；请使用环境变量或密钥管理服务
- 日志脱敏：屏蔽密码、密钥、手机号等敏感字段
- CORS/CSRF：严格来源白名单；对跨域接口进行风控验证
- 文件上传：限制类型/大小；统一存储策略；校验扩展名与 MIME

## 9. AI / MCP 协作规范

- 编辑器侧配置：见 [.trae/config.json](file:///Users/wangjingjun/work/promotion/.trae/config.json)
- 服务端侧配置：见 [server/config.yaml](file:///Users/wangjingjun/work/promotion/server/config.yaml) 中 `mcp` 段
- 产出物规范：
  - 自动生成/辅助生成的 SQL 必须包含表及字段注释
  - 所有新文档统一落在 [docs/plan](file:///Users/wangjingjun/work/promotion/docs/plan)
  - 禁止将编译产物与大文件入库；遵循 .gitignore 管理

## 10. 质量保障与发布

- 本地验证
  - 后端：编译通过，`swag init` 可生成文档；关键路径用单测保障（如有）
  - 前端：开发启动无错误；构建通过且预览正常
- Code Review
  - 提交 PR 至 dev 分支；至少 1 名 reviewer 审核通过
  - 关注：安全、性能、边界条件、命名与注释完整度
- 发布
  - 打包镜像与部署脚本位于 [deploy](file:///Users/wangjingjun/work/promotion/deploy)
  - Kubernetes Ingress 示例见 [deploy/kubernetes/web/gva-web-ingress.yaml](file:///Users/wangjingjun/work/promotion/deploy/kubernetes/web/gva-web-ingress.yaml)

## 11. 推广页面自动生成系统

### 11.1 核心功能

本系统实现推广页面的自动化生成，支持移动端和PC端双端适配，通过模板、插件、变量的组合，快速生成可定制的推广落地页。

**核心特性：**
- 双端适配：移动端（m）和PC端（pc）独立生成
- 模板系统：支持多模板切换，灵活定制页面样式
- 插件系统：可插拔的功能组件（底部栏、二维码、复制微信等）
- 变量替换：支持动态数据注入（客服信息、公司信息、问答内容等）
- 客服随机分配：基于本地存储的客服随机选择机制
- 访问统计：自动上报访问时长、复制事件等数据

### 11.2 目录结构

```
server/uploads/
├── dist/                    # 生成的推广页面输出目录
│   └── {randomCode}/        # 每个推广链接的随机编号目录
│       ├── m/               # 移动端页面
│       │   └── index.html
│       └── pc/              # PC端页面
│           └── index.html
├── plugins/                 # 插件目录
│   ├── bottom-bar-1/        # 移动端底部栏插件
│   │   └── index.html
│   ├── pc-qrcode-1/         # PC端二维码插件
│   │   └── index.html
│   └── wechat-copy-1/       # 微信复制插件
│       └── index.html
└── template/                # 模板目录
    ├── mobile/              # 移动端模板
    │   └── template-01/
    │       ├── index.html
    │       ├── style.css
    │       └── script.js
    └── pc/                  # PC端模板
        └── template-01/
            ├── index.html
            ├── style.css
            └── script.js
```

### 11.3 核心方法：PublishPromotionLink

**位置：** `server/service/promotion/link_service.go`

**功能：** 发布推广链接，生成移动端和PC端页面

**执行流程：**

```go
func (s *LinkService) PublishPromotionLink(linkId uint) error
```

**详细步骤：**

1. **查询链接信息**
   - 从 `promotion_link` 表查询推广链接基本信息
   - 如果 `random_code` 为空，生成8位随机编号

2. **查询关联配置**
   - `promotion_link_basic`：基本设置（模板ID、插件ID、显示配置等）
   - `promotion_link_company`：公司信息（公司名、ICP备案号、Logo等）
   - `promotion_link_code`：代码设置（自定义代码）
   - `promotion_link_theme`：主题设置（颜色、字体等）
   - `promotion_link_comment`：评论设置

3. **查询问答内容**
   - 从 `qa_question` 表查询问题信息
   - 从 `qa_answer` 表查询回答列表（仅审核通过的）
   - 从 `qa_reply` 表查询回复列表（仅审核通过的）
   - 组装成 `QaQuestion` 结构体，包含问题、回答、回复的完整数据

4. **查询客服信息**
   - 从 `group_member` 表查询指定区域和分组的客服成员
   - 过滤条件：`region_id`、`group_id`、`status=1`、`deleted_at IS NULL`
   - 序列化为 JSON 字符串，用于前端随机选择

5. **查询模板和插件**
   - 从 `promotion_template_widget` 表查询：
     - 移动端模板：`template_mobile_id`
     - PC端模板：`template_pc_id`
     - 微信复制插件：`mobile_copy_widget_id`
     - 底部栏插件：`mobile_bottom_widget_id`
     - PC端二维码插件：`pc_qrcode_widget_id`

6. **生成页面**
   - 创建随机编号目录：`{distBasePath}/{randomCode}/m` 和 `{distBasePath}/{randomCode}/pc`
   - 调用 `PageGenerator` 生成移动端和PC端页面
   - 更新链接的 `mobile_url` 和 `pc_url` 字段

### 11.4 页面生成器：PageGenerator

**位置：** `server/service/promotion/page_generator.go`

**核心方法：**

#### LoadTemplate
```go
func (g *PageGenerator) LoadTemplate(templatePath string, data TemplateData) (string, error)
```
- 加载指定模板的 HTML、CSS、JS 文件
- 合并 CSS 和 JS 到 HTML 中
- 使用 Go template 语法渲染数据

#### LoadPlugin
```go
func (g *PageGenerator) LoadPlugin(pluginName string, data map[string]string) (string, error)
```
- 加载指定插件的 HTML 文件
- 支持变量替换（如 `{{wechat}}`、`{{phone}}` 等）

#### InjectPlugin
```go
func (g *PageGenerator) InjectPlugin(html string, selector string, pluginHTML string) string
```
- 将插件 HTML 注入到指定选择器位置
- 移动端插件选择器：`<div id="plugin-copy"></div>`、`<div id="plugin-bottom"></div>`
- PC端插件选择器：`<div id="plugin-qrcode"></div>`

#### BuildTemplateData
```go
func (g *PageGenerator) BuildTemplateData(link promotion.PromotionLink, basic promotion.PromotionLinkBasic, company promotion.PromotionLinkCompany, question QaQuestion, isMobile bool) TemplateData
```
- 组装模板渲染数据
- 处理富文本内容（HTML 转义）
- 区分移动端和PC端的 Logo URL

#### GeneratePageWithData
```go
func (g *PageGenerator) GeneratePageWithData(data TemplateData, templateName string, plugins map[string]string, isMobile bool, outputPath string) (string, error)
```
- 完整的页面生成流程
- 加载模板 → 注入插件 → 写入文件

### 11.5 模板系统

**模板目录：** `server/uploads/template/`

**移动端模板：** `mobile/template-01/`
- `index.html`：主模板文件，使用 Go template 语法
- `style.css`：样式文件，自动内联到 HTML
- `script.js`：脚本文件，自动内联到 HTML

**PC端模板：** `pc/template-01/`
- 结构同移动端模板

**模板变量：**
```go
type TemplateData struct {
    LinkID                uint
    ServiceListJSON       string        // 客服列表JSON
    LogoURL               string        // Logo地址
    CompanyName           string        // 公司名称
    IcpRecordNo           string        // ICP备案号
    HomepageURL           string        // 官网地址
    AboutURL              string        // 关于我们地址
    QrcodeURL             string        // 二维码地址
    Year                  int           // 当前年份
    Show12301Phone        bool          // 是否显示12301电话
    QuestionTitle         string        // 问题标题
    QuestionTags          []string      // 问题标签
    QuestionAvatar        string        // 问题头像
    QuestionNickname      string        // 问题昵称
    QuestionTitleName     string        // 问题称号
    QuestionTimeAt        string        // 问题时间
    QuestionContent       template.HTML // 问题内容
    QuestionFollowCount   int           // 问题关注数
    QuestionLookCount     int           // 问题浏览数
    QuestionFavoriteCount int           // 问题收藏数
    QuestionLikeCount     int           // 问题点赞数
    Answers               []Answer      // 回答列表
}
```

**模板语法示例：**
```html
<!-- 变量输出 -->
{{.QuestionTitle}}

<!-- 条件判断 -->
{{if .QuestionTitleName}}
<span class="title">{{.QuestionTitleName}}</span>
{{end}}

<!-- 循环遍历 -->
{{range .QuestionTags}}
<span class="tag">{{.}}</span>
{{end}}

<!-- 嵌套循环 -->
{{range .Answers}}
<div class="answer">
    {{.Content}}
    {{range .Replies}}
    <div class="reply">{{.Content}}</div>
    {{end}}
</div>
{{end}}
```

### 11.6 插件系统

**插件目录：** `server/uploads/plugins/`

#### 移动端底部栏插件：`bottom-bar-1/`
- **功能：** 固定在页面底部的操作栏
- **包含：** 电话咨询、复制微信两个按钮
- **样式：** 白色背景，微信按钮绿色渐变
- **交互：** 点击电话调用 `callPhone()`，点击微信调用 `copyWechat()`

#### 微信复制插件：`wechat-copy-1/`
- **功能：** 复制微信号并显示成功弹窗
- **包含：** 复制逻辑、成功弹窗、去微信、拨打电话按钮
- **上报：** 复制成功后上报到 `/api/promotion/landingVisit/reportCopy`
- **兼容：** 支持现代浏览器和旧版浏览器的复制方式

#### PC端二维码插件：`pc-qrcode-1/`
- **功能：** 显示客服二维码
- **位置：** 页面侧边栏
- **样式：** 固定定位，悬浮显示

**插件变量替换：**
```go
pluginData := map[string]string{
    "wechat":    "",      // 微信号
    "phone":     "",      // 电话号码
    "qrcodeUrl": "",      // 二维码地址
}
```

**插件注入位置：**
- 移动端复制插件：`<div id="plugin-copy"></div>`
- 移动端底部栏插件：`<div id="plugin-bottom"></div>`
- PC端二维码插件：`<div id="plugin-qrcode"></div>`

### 11.7 客服随机分配机制

**实现位置：** 模板的 `<script>` 标签内

**逻辑流程：**

1. **获取客服列表**
   ```javascript
   const serviceListStr = {{.ServiceListJSON}} || "[]";
   const serviceList = JSON.parse(serviceListStr);
   ```

2. **检查本地存储**
   ```javascript
   const savedService = localStorage.getItem('promotion_service_' + window.location.pathname);
   ```

3. **随机选择或使用缓存**
   - 如果本地有缓存且有效，使用缓存的客服
   - 如果没有缓存或缓存无效，随机选择一个客服并保存到本地存储

4. **暴露全局变量**
   ```javascript
   window.currentService = currentService;
   window.wechat = currentService.wechat;
   window.phone = currentService.mobile;
   ```

5. **替换页面内容**
   - 替换 `##客服昵称##` 为可点击的客服信息
   - 替换 `.wechat` 元素为微信号
   - 替换 `.phone` 元素为电话号码

### 11.8 访问统计上报

**上报接口：**
- 初始化访问：`POST /api/promotion/landingVisit/init`
- 上报时长：`POST /api/promotion/landingVisit/reportDuration`
- 上报复制：`POST /api/promotion/landingVisit/reportCopy`

**上报逻辑：**

1. **初始化访问**
   ```javascript
   fetch('/api/promotion/landingVisit/init', {
       method: 'POST',
       headers: { 'Content-Type': 'application/json' },
       body: JSON.stringify({
           referer: document.referrer,
           userAgent: navigator.userAgent,
           linkId: Number(window.LINK_ID)
       })
   })
   ```

2. **定时上报时长**
   - 移动端：每5秒上报一次
   - PC端：每30秒上报一次
   - 使用 `setInterval` 定时器

3. **上报复制事件**
   - 复制成功后立即上报
   - 包含客服电话和昵称信息

### 11.9 数据流转图

```
数据库查询
    ↓
PublishPromotionLink
    ↓
查询链接、配置、问答、客服信息
    ↓
组装 TemplateData
    ↓
PageGenerator.GeneratePageWithData
    ↓
加载模板 (HTML + CSS + JS)
    ↓
注入插件 (复制、底部栏、二维码)
    ↓
写入文件 (dist/{randomCode}/m/index.html)
    ↓
更新链接 URL
    ↓
用户访问页面
    ↓
前端随机选择客服
    ↓
上报访问统计
```

### 11.10 开发注意事项

**新增模板：**
1. 在 `server/uploads/template/mobile/` 或 `server/uploads/template/pc/` 下创建新目录
2. 创建 `index.html`、`style.css`、`script.js` 文件
3. 使用 Go template 语法编写模板
4. 在数据库 `promotion_template_widget` 表中注册模板

**新增插件：**
1. 在 `server/uploads/plugins/` 下创建新目录
2. 创建 `index.html` 文件
3. 使用 `{{变量名}}` 语法支持变量替换
4. 在数据库 `promotion_template_widget` 表中注册插件

**修改页面生成逻辑：**
- 主要修改 `PageGenerator` 的方法
- 注意保持向后兼容性
- 测试移动端和PC端双端效果

**调试技巧：**
- 查看生成的 HTML 文件：`server/uploads/dist/{randomCode}/m/index.html`
- 检查模板渲染：查看 HTML 中的变量是否正确替换
- 检查插件注入：查看插件 HTML 是否正确插入
- 检查客服分配：查看浏览器控制台的 `window.currentService`

---

参考资料：
- gin-vue-admin 官方说明见本仓库 [README.md](file:///Users/wangjingjun/work/promotion/README.md)
- 业务与数据库方案清单见 [docs/plan](file:///Users/wangjingjun/work/promotion/docs/plan)

