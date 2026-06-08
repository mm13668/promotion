# Draft: OCPC回传转化类型标记

## Requirements (confirmed)
- [需求]: `landing_visits` 表新增 `conversion_type` 字段，记录用户访问触发的转化类型
- [转化类型值]: 微信复制按钮点击=35, 表单提交成功=3, 注册激活后登录(注册转化)=49
- [定时器改造]: `autoOcpcCallback` 需要判断访问记录是否触发到对应的转化类型，才能进行自动回传
- [SQL迁移]: 所有修改的SQL放在 docs/plan 下，一个文件

## Technical Analysis

### 现有流程
- `POST landingVisit/reportCopy` (promoApi.ReportCopy) → `UpdateCopyInfo` → 更新 landing_visits 的 is_copied/copied_at 等字段。**请求体中已有 visit ID** (`LandingVisitCopyReport.Id`)
- `POST landingMessage/create` (promoApi.CreateLandingMessage) → `CreateLandingMessage` → 创建 landing_messages 记录。**请求体中无 visit ID**
- `POST landingPhone/create` (promoApi.CreateLandingPhone) → `CreateLandingPhone` → 创建 landing_phones 记录。**请求体中无 visit ID**
- 定时器目前用 `copied_at IS NOT NULL` 判断"有转化行为"

### 改动点
1. **Model**: `LandingVisit` 增加 `ConversionType *uint8` 字段
2. **SQL**: `ALTER TABLE landing_visits ADD COLUMN conversion_type tinyint DEFAULT NULL COMMENT '转化类型:35=微信复制 3=表单提交 49=注册转化';`
3. **ReportCopy/UpdateCopyInfo**: 已有 visit ID → 同时写 `conversion_type=35`
4. **CreateLandingMessage**: 需要找到对应 landing_visits 记录 → 写 `conversion_type=3`
5. **CreateLandingPhone**: 需要找到对应 landing_visits 记录 → 写 `conversion_type=49`
6. **autoOcpcCallback**: 条件从 `copied_at IS NOT NULL` 改为 `conversion_type IS NOT NULL`

### 关键设计决策
CreateLandingMessage 和 CreateLandingPhone 目前没有 landing_visit_id，需要决定如何关联：

- **Option A**: 在 `LandingMessage`/`LandingPhone` 请求体中增加 `visitId` 字段，前端提交时传入（前端已有 visit ID，`init` 接口返回了 ID）
- **Option B**: 后端通过 `ip + link_id` 查找匹配的 landing_visits 记录

## Open Questions
- [待确认]: Message/Phone 提交时如何关联到 landing_visits 记录？

## Scope Boundaries
- IN: landing_visits 加字段、三个 API 写转化类型、定时器条件改造、SQL迁移文件
- EXCLUDE: 前端模板修改（只涉及后端改动）
