CREATE TABLE `landing_messages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  `deleted_at` datetime DEFAULT NULL COMMENT '删除时间',
  `link_id` varchar(255) NOT NULL COMMENT '推广链接ID',
  `link_url` varchar(255) NOT NULL COMMENT '访问链接',
  `name` varchar(255) DEFAULT NULL COMMENT '留言人姓名',
  `phone` varchar(32) DEFAULT NULL COMMENT '留言人手机号',
  `content` text NOT NULL COMMENT '留言内容',
  `email` varchar(255) DEFAULT NULL COMMENT '留言人邮箱',
  `ip` varchar(64) DEFAULT NULL COMMENT '访问IP',
  `user_agent` text DEFAULT NULL COMMENT '访问UA',
  PRIMARY KEY (`id`),
  KEY `idx_landing_messages_deleted_at` (`deleted_at`),
  KEY `idx_landing_messages_link_id` (`link_id`),
  KEY `idx_landing_messages_phone` (`phone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='落地页留言表';
