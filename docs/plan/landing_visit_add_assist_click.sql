-- 访问记录表：增加获客助手点击字段
-- 在 landing_visits 表增加 is_clicked_assist 和 clicked_assist_at

ALTER TABLE `landing_visits`
    ADD COLUMN `is_clicked_assist` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否点击获客助手链接' AFTER `wechat_followed_at`,
    ADD COLUMN `clicked_assist_at` datetime DEFAULT NULL COMMENT '点击获客助手时间' AFTER `is_clicked_assist`,
    ADD INDEX `idx_is_clicked_assist` (`is_clicked_assist`);
