-- ===============================
-- 活动数据：表结构
-- 说明：覆盖活动数据的基础信息、市场字典、套餐字典
-- 要求：每张表与每个字段均提供中文注释
-- ===============================

-- 市场字典表（如“北京市场”“上海市场”等）
CREATE TABLE IF NOT EXISTS `activity_market` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `code` VARCHAR(32) NOT NULL COMMENT '市场编码（英文短码，唯一）',
  `name_cn` VARCHAR(64) NOT NULL COMMENT '市场中文名称',
  `name_en` VARCHAR(64) NULL COMMENT '市场英文名称',
  `status` TINYINT UNSIGNED NOT NULL DEFAULT 1 COMMENT '状态：1-启用 2-停用',
  `sort` INT NOT NULL DEFAULT 0 COMMENT '排序值（越大越靠前）',
  `remark` VARCHAR(255) NULL COMMENT '备注信息',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted_at` DATETIME NULL COMMENT '删除时间（软删除）',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_market_code` (`code`),
  KEY `idx_market_status` (`status`),
  KEY `idx_market_sort` (`sort`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='活动数据-市场字典表';

-- 套餐字典表（可定义常用套餐与默认金额）
CREATE TABLE IF NOT EXISTS `activity_package` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` VARCHAR(128) NOT NULL COMMENT '套餐名称',
  `default_total_amount` DECIMAL(14,2) NULL COMMENT '默认总金额（可为空，表示不设默认）',
  `status` TINYINT UNSIGNED NOT NULL DEFAULT 1 COMMENT '状态：1-启用 2-停用',
  `sort` INT NOT NULL DEFAULT 0 COMMENT '排序值（越大越靠前）',
  `remark` VARCHAR(255) NULL COMMENT '备注信息',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted_at` DATETIME NULL COMMENT '删除时间（软删除）',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_package_name` (`name`),
  KEY `idx_package_status` (`status`),
  KEY `idx_package_sort` (`sort`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='活动数据-套餐字典表';

-- 活动数据表（列表页展示：中文名称、英文名称、市场、总金额、套餐名称、图片链接）
CREATE TABLE IF NOT EXISTS `activity_data` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name_cn` VARCHAR(128) NOT NULL COMMENT '中文名称',
  `name_en` VARCHAR(128) NULL COMMENT '英文名称',
  `market_id` BIGINT UNSIGNED NULL COMMENT '市场ID（关联 activity_market.id，可空）',
  `total_amount` DECIMAL(14,2) NOT NULL DEFAULT 0 COMMENT '总金额（元）',
  `package_id` BIGINT UNSIGNED NULL COMMENT '套餐ID（关联 activity_package.id，可空）',
  `image_url` VARCHAR(255) NULL COMMENT '图片链接（展示缩略图或详情图）',
  `status` TINYINT UNSIGNED NOT NULL DEFAULT 1 COMMENT '状态：1-启用 2-停用',
  `sort` INT NOT NULL DEFAULT 0 COMMENT '排序值（越大越靠前）',
  `remark` VARCHAR(255) NULL COMMENT '备注信息',
  `created_by` BIGINT UNSIGNED NULL COMMENT '创建人ID',
  `updated_by` BIGINT UNSIGNED NULL COMMENT '更新人ID',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted_at` DATETIME NULL COMMENT '删除时间（软删除）',
  PRIMARY KEY (`id`),
  KEY `idx_activity_market` (`market_id`),
  KEY `idx_activity_package` (`package_id`),
  KEY `idx_activity_status` (`status`),
  KEY `idx_activity_sort` (`sort`),
  CONSTRAINT `fk_activity_market` FOREIGN KEY (`market_id`) REFERENCES `activity_market`(`id`)
    ON UPDATE RESTRICT ON DELETE SET NULL,
  CONSTRAINT `fk_activity_package` FOREIGN KEY (`package_id`) REFERENCES `activity_package`(`id`)
    ON UPDATE RESTRICT ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='活动数据-主数据表';

