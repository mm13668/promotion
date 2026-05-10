-- 给所有表添加uuid字段，用于标记记录属于哪个用户
-- 执行时间: 2024年

-- ad_platform
ALTER TABLE `ad_platform` ADD COLUMN `uuid` varchar(100) DEFAULT NULL COMMENT '用户UUID' AFTER `id`;
ALTER TABLE `ad_platform` ADD INDEX `idx_platform_uuid` (`uuid`);

-- group_member
ALTER TABLE `group_member` ADD COLUMN `uuid` varchar(100) DEFAULT NULL COMMENT '用户UUID' AFTER `id`;
ALTER TABLE `group_member` ADD INDEX `idx_member_uuid` (`uuid`);

-- promotion_domain
ALTER TABLE `promotion_domain` ADD COLUMN `uuid` varchar(100) DEFAULT NULL COMMENT '用户UUID' AFTER `id`;
ALTER TABLE `promotion_domain` ADD INDEX `idx_domain_uuid` (`uuid`);

-- promotion_group
ALTER TABLE `promotion_group` ADD COLUMN `uuid` varchar(100) DEFAULT NULL COMMENT '用户UUID' AFTER `id`;
ALTER TABLE `promotion_group` ADD INDEX `idx_group_uuid` (`uuid`);

-- promotion_link
ALTER TABLE `promotion_link` ADD COLUMN `uuid` varchar(100) DEFAULT NULL COMMENT '用户UUID' AFTER `id`;
ALTER TABLE `promotion_link` ADD INDEX `idx_link_uuid` (`uuid`);

-- promotion_link_basic
ALTER TABLE `promotion_link_basic` ADD COLUMN `uuid` varchar(100) DEFAULT NULL COMMENT '用户UUID' AFTER `id`;
ALTER TABLE `promotion_link_basic` ADD INDEX `idx_basic_uuid` (`uuid`);

-- promotion_link_code
ALTER TABLE `promotion_link_code` ADD COLUMN `uuid` varchar(100) DEFAULT NULL COMMENT '用户UUID' AFTER `id`;
ALTER TABLE `promotion_link_code` ADD INDEX `idx_code_uuid` (`uuid`);

-- promotion_link_comment
ALTER TABLE `promotion_link_comment` ADD COLUMN `uuid` varchar(100) DEFAULT NULL COMMENT '用户UUID' AFTER `id`;
ALTER TABLE `promotion_link_comment` ADD INDEX `idx_comment_uuid` (`uuid`);

-- promotion_link_company
ALTER TABLE `promotion_link_company` ADD COLUMN `uuid` varchar(100) DEFAULT NULL COMMENT '用户UUID' AFTER `id`;
ALTER TABLE `promotion_link_company` ADD INDEX `idx_company_uuid` (`uuid`);

-- promotion_link_theme
ALTER TABLE `promotion_link_theme` ADD COLUMN `uuid` varchar(100) DEFAULT NULL COMMENT '用户UUID' AFTER `id`;
ALTER TABLE `promotion_link_theme` ADD INDEX `idx_theme_uuid` (`uuid`);

-- qa_answer
ALTER TABLE `qa_answer` ADD COLUMN `uuid` varchar(100) DEFAULT NULL COMMENT '用户UUID' AFTER `id`;
ALTER TABLE `qa_answer` ADD INDEX `idx_answer_uuid` (`uuid`);

-- qa_avatar_nickname
ALTER TABLE `qa_avatar_nickname` ADD COLUMN `uuid` varchar(100) DEFAULT NULL COMMENT '用户UUID' AFTER `id`;
ALTER TABLE `qa_avatar_nickname` ADD INDEX `idx_avatar_uuid` (`uuid`);

-- qa_question
ALTER TABLE `qa_question` ADD COLUMN `uuid` varchar(100) DEFAULT NULL COMMENT '用户UUID' AFTER `id`;
ALTER TABLE `qa_question` ADD INDEX `idx_question_uuid` (`uuid`);

-- qa_reply
ALTER TABLE `qa_reply` ADD COLUMN `uuid` varchar(100) DEFAULT NULL COMMENT '用户UUID' AFTER `id`;
ALTER TABLE `qa_reply` ADD INDEX `idx_reply_uuid` (`uuid`);

-- qa_signature
ALTER TABLE `qa_signature` ADD COLUMN `uuid` varchar(100) DEFAULT NULL COMMENT '用户UUID' AFTER `id`;
ALTER TABLE `qa_signature` ADD INDEX `idx_signature_uuid` (`uuid`);

-- qa_tag
ALTER TABLE `qa_tag` ADD COLUMN `uuid` varchar(100) DEFAULT NULL COMMENT '用户UUID' AFTER `id`;
ALTER TABLE `qa_tag` ADD INDEX `idx_tag_uuid` (`uuid`);

-- qa_title
ALTER TABLE `qa_title` ADD COLUMN `uuid` varchar(100) DEFAULT NULL COMMENT '用户UUID' AFTER `id`;
ALTER TABLE `qa_title` ADD INDEX `idx_title_uuid` (`uuid`);

-- region_category
ALTER TABLE `region_category` ADD COLUMN `uuid` varchar(100) DEFAULT NULL COMMENT '用户UUID' AFTER `id`;
ALTER TABLE `region_category` ADD INDEX `idx_region_uuid` (`uuid`);

update `ad_platform` set uuid='4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b';
update `group_member` set uuid='4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b';
update `promotion_domain` set uuid='4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b';
update `promotion_group` set uuid='4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b';
update `promotion_link` set uuid='4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b';
update `promotion_link_basic` set uuid='4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b';
update `promotion_link_code` set uuid='4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b';
update `promotion_link_comment` set uuid='4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b';
update `promotion_link_company` set uuid='4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b';
update `promotion_link_theme` set uuid='4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b';
update `qa_answer` set uuid='4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b';
update `qa_avatar_nickname` set uuid='4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b';
update `qa_question` set uuid='4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b';
update `qa_reply` set uuid='4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b';
update `qa_signature` set uuid='4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b';
update `qa_tag` set uuid='4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b';
update `qa_title` set uuid='4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b';
update `region_category` set uuid='4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b';