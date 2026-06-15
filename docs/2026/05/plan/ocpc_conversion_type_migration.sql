-- OCPC转化类型标记迁移脚本
-- 日期: 2026-05-30
-- 需求: landing_visits 记录用户访问触发的转化类型，用于OCPC自动回传判断

-- 1. landing_visits 表新增转化类型字段（varchar存储多个值，逗号分隔）
ALTER TABLE `landing_visits`
    ADD COLUMN `conversion_type` varchar(32) DEFAULT NULL COMMENT '转化类型(多个用逗号分隔):35=微信复制 3=表单提交 49=注册转化' AFTER `last_report_at`,
    ADD KEY `idx_conversion_type` (`conversion_type`);

-- 2. landing_messages 表新增关联访问记录ID（前端可传入 visitId 关联）
ALTER TABLE `landing_messages`
    ADD COLUMN `landing_visit_id` bigint unsigned DEFAULT NULL COMMENT '关联的访问记录ID' AFTER `user_agent`,
    ADD KEY `idx_landing_visit_id` (`landing_visit_id`);

-- 3. landing_phones 表新增关联访问记录ID（前端可传入 visitId 关联）
ALTER TABLE `landing_phones`
    ADD COLUMN `landing_visit_id` bigint unsigned DEFAULT NULL COMMENT '关联的访问记录ID' AFTER `user_agent`,
    ADD KEY `idx_landing_visit_id` (`landing_visit_id`);
