-- 落地页留言表：增加 processed 字段（是否已处理）
-- 执行时间：2026-06-28
-- 说明：标记留言是否已被客服处理，0=未处理，1=已处理

ALTER TABLE `landing_messages`
ADD COLUMN `processed` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否已处理（0:未处理 1:已处理）' AFTER `landing_visit_id`;
