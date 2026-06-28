-- =============================================
-- 官网留言表
-- =============================================
CREATE TABLE IF NOT EXISTS `contact_messages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `phone` varchar(20) NOT NULL DEFAULT '' COMMENT '手机号',
  `message` varchar(500) NOT NULL DEFAULT '' COMMENT '留言信息',
  `is_processed` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否已处理 0-未处理 1-已处理',
  `message_time` datetime(3) DEFAULT NULL COMMENT '留言时间',
  `created_at` datetime(3) DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime(3) DEFAULT NULL COMMENT '更新时间',
  `deleted_at` datetime(3) DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`),
  KEY `idx_phone` (`phone`),
  KEY `idx_is_processed` (`is_processed`),
  KEY `idx_message_time` (`message_time`),
  KEY `idx_deleted_at` (`deleted_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='官网留言表-官网留言功能，用户提交手机号和留言信息';
