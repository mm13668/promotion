-- 推广链接基本设置-新增是否优先使用获客助手链接字段
ALTER TABLE `promotion_link_basic`
ADD COLUMN `prefer_customer_assist` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否优先使用获客助手链接' AFTER `show12301_phone`;
