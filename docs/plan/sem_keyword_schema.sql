-- ===============================
-- SEM关键词管理表
-- ===============================

-- 1. SEM关键词表
CREATE TABLE IF NOT EXISTS `sem_keyword` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  `deleted_at` datetime DEFAULT NULL COMMENT '删除时间',
  `name` varchar(128) NOT NULL COMMENT '关键词名称',
  `type` tinyint unsigned NOT NULL DEFAULT '1' COMMENT '类型 1=主关键词 2=长尾关键词 3=品牌关键词',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态 0=禁用 1=启用',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`),
  KEY `idx_keyword_type` (`type`),
  KEY `idx_keyword_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='SEM关键词表';

-- 2. 推广链接关键词关联表
CREATE TABLE IF NOT EXISTS `promotion_link_sem_keyword` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  `deleted_at` datetime DEFAULT NULL COMMENT '删除时间',
  `link_id` bigint unsigned NOT NULL COMMENT '推广链接ID',
  `keyword_id` bigint unsigned NOT NULL COMMENT '关键词ID',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`),
  KEY `idx_link_sem_link` (`link_id`),
  KEY `idx_link_sem_keyword` (`keyword_id`),
  UNIQUE KEY `uk_link_keyword` (`link_id`, `keyword_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='推广链接关键词关联表';

-- 3. 插入示例数据
INSERT INTO `sem_keyword` (`name`, `type`, `sort`, `status`, `description`) VALUES
('旅游咨询', 1, 1, 1, '主关键词'),
('旅游攻略', 2, 2, 1, '长尾关键词'),
('旅游线路推荐', 2, 3, 1, '长尾关键词'),
('旅游服务', 3, 4, 1, '品牌关键词'),
('专业旅游咨询', 2, 5, 1, '长尾关键词');
