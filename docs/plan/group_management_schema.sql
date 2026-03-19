-- ===============================
-- 分组管理：地区分类表
-- 用于维护地区层级与排序
-- ===============================
CREATE TABLE IF NOT EXISTS `region_category` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` VARCHAR(64) NOT NULL COMMENT '地区分类名称',
  `parent_id` BIGINT UNSIGNED NULL COMMENT '父级分类ID（顶级为空）',
  `sort` INT NOT NULL DEFAULT 0 COMMENT '排序值（越大越靠前）',
  `remark` VARCHAR(255) NULL COMMENT '备注信息',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted_at` DATETIME NULL COMMENT '删除时间（软删除）',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_region_name` (`name`),
  KEY `idx_region_parent` (`parent_id`),
  KEY `idx_region_sort` (`sort`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='分组管理-地区分类表';

-- ===============================
-- 分组管理：成员表
-- 记录分组成员的基本信息与归属
-- ===============================
CREATE TABLE IF NOT EXISTS `group_member` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `nickname` VARCHAR(64) NOT NULL COMMENT '昵称（界面显示名）',
  `region_id` BIGINT UNSIGNED NOT NULL COMMENT '地区ID（关联region_category）',
  `group_id` BIGINT UNSIGNED NOT NULL COMMENT '所属分组ID（关联promotion_group）',
  `real_name` VARCHAR(64) NULL COMMENT '真实姓名',
  `wechat` VARCHAR(64) NULL COMMENT '微信号',
  `mobile` VARCHAR(20) NULL COMMENT '手机号',
  `gender` ENUM('男','女','未知') NOT NULL DEFAULT '未知' COMMENT '性别',
  `sort` INT NOT NULL DEFAULT 0 COMMENT '排序值（越大越靠前）',
  `remark` VARCHAR(255) NULL COMMENT '备注信息',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted_at` DATETIME NULL COMMENT '删除时间（软删除）',
  PRIMARY KEY (`id`),
  KEY `idx_member_region` (`region_id`),
  KEY `idx_member_group` (`group_id`),
  KEY `idx_member_sort` (`sort`),
  CONSTRAINT `fk_member_region` FOREIGN KEY (`region_id`) REFERENCES `region_category`(`id`)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT,
  CONSTRAINT `fk_member_group` FOREIGN KEY (`group_id`) REFERENCES `promotion_group`(`id`)
    ON UPDATE RESTRICT
    ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='分组管理-成员表';

-- ===============================
-- 分组管理：分组表
-- 归属于某个地区，可配置排序与备注
-- ===============================
CREATE TABLE IF NOT EXISTS `promotion_group` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` VARCHAR(64) NOT NULL COMMENT '分组名称',
  `region_id` BIGINT UNSIGNED NOT NULL COMMENT '所属地区ID（关联region_category）',
  `sort` INT NOT NULL DEFAULT 0 COMMENT '排序值（越大越靠前）',
  `remark` VARCHAR(255) NULL COMMENT '备注信息',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted_at` DATETIME NULL COMMENT '删除时间（软删除）',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_group_name` (`name`),
  KEY `idx_group_region` (`region_id`),
  KEY `idx_group_sort` (`sort`),
  CONSTRAINT `fk_group_region` FOREIGN KEY (`region_id`) REFERENCES `region_category`(`id`)
    ON UPDATE RESTRICT
    ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='分组管理-分组表';
