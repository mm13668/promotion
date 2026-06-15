-- 用户管理：sys_users 表增加用户使用截止有效期字段
-- 适用数据库：MySQL InnoDB
-- 执行时机：部署时执行，建议先备份数据
-- 作者：Sisyphus
-- 日期：2026-05-28

ALTER TABLE `sys_users`
    ADD COLUMN `valid_until` int(11) DEFAULT NULL COMMENT '用户使用截止有效期（Unix时间戳，NULL表示无限制）'
    AFTER `enable`;
