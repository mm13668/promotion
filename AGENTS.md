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

---

参考资料：
- gin-vue-admin 官方说明见本仓库 [README.md](file:///Users/wangjingjun/work/promotion/README.md)
- 业务与数据库方案清单见 [docs/plan](file:///Users/wangjingjun/work/promotion/docs/plan)

