-- 落地页访问记录-新增企业微信添加时间字段
ALTER TABLE `landing_visits`
ADD COLUMN `wechat_followed_at` DATETIME NULL COMMENT '企业微信添加时间' AFTER `last_report_at`;
