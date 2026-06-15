-- ============================================================
-- OCPC回传功能 - 数据库迁移脚本
-- 日期：2026-05-30
-- 说明：
--   1. promotion_link 表新增 ocpc_min_duration 字段
--   2. landing_visits 表新增 referer_url / copied_at /
--      is_ocpc_callback / ocpc_callback_at 字段
-- ============================================================

-- 1. promotion_link 表：新增自动回传最小浏览时长字段
ALTER TABLE `promotion_link`
    ADD COLUMN `ocpc_min_duration` int DEFAULT 30 COMMENT '自动回传最小浏览时长(秒)' AFTER `ocpc_callback_type`;

-- 2. landing_visits 表：新增OCPC回传相关字段
ALTER TABLE `landing_visits`
    ADD COLUMN `referer_url` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '访问落地页完整URL(含bd_vid)' AFTER `last_report_at`,
    ADD COLUMN `copied_at` datetime DEFAULT NULL COMMENT '复制时间' AFTER `copied_service_nickname`,
    ADD COLUMN `is_ocpc_callback` tinyint(1) DEFAULT 0 COMMENT '是否已OCPC回传' AFTER `copied_at`,
    ADD COLUMN `ocpc_callback_at` datetime DEFAULT NULL COMMENT 'OCPC回传时间' AFTER `is_ocpc_callback`;
