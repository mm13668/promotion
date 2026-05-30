# Draft: OCPC回调功能

## Requirements (confirmed)
- [OCPC配置]: 在推广链接编辑页OCPC弹窗中，当回传方式=自动时，新增「浏览时长大于」的表单配置
- [百度OCPC回传]: 接入百度OCPC uploadConvertData API
- [工厂模式]: 回传接口用工厂模式设计，后续支持更多广告平台
- [自动回传]: 定时器每10分钟扫描，条件：duration > ocpc_min_duration && is_ocpc_callback=false && created_at>=最近1小时
- [手动回传]: landing_visits 列表页新增复制时间、是否回传字段展示；
  点击「未回传」确认后调用对应广告平台回传接口
- [SQL迁移]: 所有修改的SQL放在 docs/plan 下

## Technical Decisions
- promotion_link 新字段: ocpc_min_duration (int, 秒)
- landing_visits 新字段: referer_url, copied_at, is_ocpc_callback, ocpc_callback_at
- OCPC token: 直接用 ocpc_key 作为百度API的token
- logidUrl来源: landing page前端JS在init上报时携带 pageUrl: window.location.href，存入 referer_url 字段
- 自动回传条件: created_at >= now()-1h && is_ocpc_callback=false && duration > ocpc_min_duration
- 手动回传: 确认即回传，用link上已配置的ocpc_conversion_type
- 历史数据: 无 copied_at 的记录不参与回传
- 工厂模式: 定义 CallbackProvider 接口，先只实现百度OCPC
- 测试策略: 无单测，手动验证

## Research Findings
- PromotionLink 已有 OcpcKey, OcpcSecret, OcpcConversionType, OcpcCallbackType 字段
- LandingVisit 已有 Duration, IsCopied, CopiedServicePhone, CopiedServiceNickname, LastReportAt
- 已有 HttpRequest 工具在 server/utils/request/http.go
- 定时器模式: global.GVA_Timer.AddTaskByFunc("name", "cron表达式", func, desc, cron.WithSeconds())
- 现有 OCPC UI 在 link/index.vue 第391-423行，ocpcForm 对象在746行
- LandingVisit router 已有 public 和 private 路由组

## Open Questions
- [已解决] 字段命名：ocpc_min_duration, referer_url, copied_at, is_ocpc_callback, ocpc_callback_at
- [已解决] 前端模板修改 init 上报 pageUrl：包含在本需求内
- [已解决] 手动回传确认流程：确认即回传，用link已配转化类型
- [已解决] 自动回传条件：created_at最近1h + is_ocpc_callback=false
- [已解决] 工厂模式：先定义接口，只实现百度

## Scope Boundaries
- IN: promotion_link加字段、landing_visits加字段、OCPC配置UI、百度OCPC回传、工厂模式、自动定时器、手动回传UI、前端模板修改、SQL迁移脚本
- EXCLUDE: 导出功能、其他广告平台实现、单元测试
