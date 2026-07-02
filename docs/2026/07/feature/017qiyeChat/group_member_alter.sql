-- 客服成员表-新增获客助手链接字段
ALTER TABLE `group_member`
ADD COLUMN `customer_assist_link` VARCHAR(255) NULL COMMENT '获客助手链接' AFTER `remark`;
