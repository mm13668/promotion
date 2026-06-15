-- ===============================
-- 推广链接基本设置表 - 添加SEO字段
-- ===============================

-- 添加SEO相关字段到 promotion_link_basic 表
ALTER TABLE `promotion_link_basic`
ADD COLUMN `seo_keywords` VARCHAR(500) NULL COMMENT 'SEO关键词（逗号分隔）' AFTER `auto_detect_device`,
ADD COLUMN `seo_description` VARCHAR(500) NULL COMMENT 'SEO描述' AFTER `seo_keywords`,
ADD COLUMN `seo_title` VARCHAR(255) NULL COMMENT 'SEO标题' AFTER `seo_description`;
