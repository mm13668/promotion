-- =============================================
-- 新闻资讯表
-- =============================================
CREATE TABLE IF NOT EXISTS `news` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '新闻标题',
  `summary` text COMMENT '新闻摘要',
  `content` longtext COMMENT '新闻内容(富文本)',
  `cover_image` varchar(500) DEFAULT '' COMMENT '封面图片',
  `author` varchar(100) DEFAULT '' COMMENT '作者',
  `category_id` bigint(20) unsigned DEFAULT '0' COMMENT '分类ID',
  `source` varchar(200) DEFAULT '' COMMENT '来源',
  `source_url` varchar(500) DEFAULT '' COMMENT '来源链接',
  `status` tinyint(1) DEFAULT '0' COMMENT '状态 0-草稿 1-已发布',
  `is_top` tinyint(1) DEFAULT '0' COMMENT '是否置顶 0-否 1-是',
  `sort` int(11) DEFAULT '0' COMMENT '排序值(越小越靠前)',
  `view_count` int(11) DEFAULT '0' COMMENT '浏览次数',
  `like_count` int(11) DEFAULT '0' COMMENT '点赞次数',
  `publish_time` datetime(3) DEFAULT NULL COMMENT '发布时间',
  `published_path` varchar(500) DEFAULT '' COMMENT '发布路径',
  `seo_keywords` text COMMENT 'SEO关键词',
  `seo_description` text COMMENT 'SEO描述',
  `created_at` datetime(3) DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime(3) DEFAULT NULL COMMENT '更新时间',
  `deleted_at` datetime(3) DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`),
  KEY `idx_category_id` (`category_id`),
  KEY `idx_status` (`status`),
  KEY `idx_sort` (`sort`),
  KEY `idx_publish_time` (`publish_time`),
  KEY `idx_deleted_at` (`deleted_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='新闻资讯表-新闻资讯管理功能';

-- =============================================
-- 新闻分类表
-- =============================================
CREATE TABLE IF NOT EXISTS `news_categories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '分类名称',
  `sort` int(11) DEFAULT '0' COMMENT '排序',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态 0-禁用 1-启用',
  `remark` varchar(500) DEFAULT '' COMMENT '备注',
  `created_at` datetime(3) DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime(3) DEFAULT NULL COMMENT '更新时间',
  `deleted_at` datetime(3) DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name` (`name`),
  KEY `idx_status` (`status`),
  KEY `idx_sort` (`sort`),
  KEY `idx_deleted_at` (`deleted_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='新闻分类表-新闻资讯分类管理';
