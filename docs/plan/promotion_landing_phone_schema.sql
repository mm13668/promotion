CREATE TABLE `landing_phones` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  `deleted_at` datetime DEFAULT NULL COMMENT '删除时间',
  `link_id` varchar(255) NOT NULL COMMENT '推广链接ID',
  `phone` varchar(32) NOT NULL COMMENT '登录手机号',
  `ip` varchar(64) DEFAULT NULL COMMENT '访问IP',
  `user_agent` text DEFAULT NULL COMMENT '访问UA',
  PRIMARY KEY (`id`),
  KEY `idx_landing_phones_deleted_at` (`deleted_at`),
  KEY `idx_landing_phones_link_id` (`link_id`),
  KEY `idx_landing_phones_phone` (`phone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='落地页手机号收集表';
