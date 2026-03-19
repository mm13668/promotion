-- ===============================
-- 广告数据统计管理：表结构
-- 说明：覆盖推广平台、活动/计划、关键词、点击明细、日汇总等
-- 要求：每张表与每个字段均提供中文注释
-- ===============================

-- 推广平台表（如：百度OCPC、百度CPC、360、神马、今日头条、抖音、OPPO、腾讯等）
CREATE TABLE IF NOT EXISTS `ad_platform` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `platform_key` VARCHAR(32) NOT NULL COMMENT '平台标识（英文小写短码，如 baidu_ocpc、toutiao 等）',
  `name` VARCHAR(64) NOT NULL COMMENT '平台名称（中文展示）',
  `status` TINYINT UNSIGNED NOT NULL DEFAULT 1 COMMENT '状态：1-启用 2-停用',
  `remark` VARCHAR(255) NULL COMMENT '备注信息',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_platform_key` (`platform_key`),
  KEY `idx_platform_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='广告统计-推广平台表';

-- 推广活动/计划表（按平台与链接归档）
CREATE TABLE IF NOT EXISTS `ad_campaign` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `platform_id` BIGINT UNSIGNED NOT NULL COMMENT '平台ID（关联 ad_platform.id）',
  `link_id` BIGINT UNSIGNED NULL COMMENT '推广链接ID（关联 promotion_link.id，可空）',
  `campaign_code` VARCHAR(64) NOT NULL COMMENT '活动/计划编号（来源平台或自定义）',
  `campaign_name` VARCHAR(128) NOT NULL COMMENT '活动/计划名称',
  `account_name` VARCHAR(128) NULL COMMENT '推广账户名称（可空）',
  `region_id` BIGINT UNSIGNED NULL COMMENT '所属地区ID（关联 region_category.id，可空）',
  `group_id` BIGINT UNSIGNED NULL COMMENT '所属客服分组ID（关联 promotion_group.id，可空）',
  `status` TINYINT UNSIGNED NOT NULL DEFAULT 1 COMMENT '状态：1-启用 2-停用',
  `remark` VARCHAR(255) NULL COMMENT '备注信息',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_campaign_code_platform` (`platform_id`,`campaign_code`),
  KEY `idx_campaign_status` (`status`),
  CONSTRAINT `fk_campaign_platform` FOREIGN KEY (`platform_id`) REFERENCES `ad_platform`(`id`)
    ON UPDATE RESTRICT ON DELETE CASCADE,
  CONSTRAINT `fk_campaign_link` FOREIGN KEY (`link_id`) REFERENCES `promotion_link`(`id`)
    ON UPDATE RESTRICT ON DELETE SET NULL,
  CONSTRAINT `fk_campaign_region` FOREIGN KEY (`region_id`) REFERENCES `region_category`(`id`)
    ON UPDATE RESTRICT ON DELETE SET NULL,
  CONSTRAINT `fk_campaign_group` FOREIGN KEY (`group_id`) REFERENCES `promotion_group`(`id`)
    ON UPDATE RESTRICT ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='广告统计-推广活动/计划表';

-- 关键词表（跟踪关键词与匹配信息）
CREATE TABLE IF NOT EXISTS `ad_keyword` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `campaign_id` BIGINT UNSIGNED NOT NULL COMMENT '活动/计划ID（关联 ad_campaign.id）',
  `keyword` VARCHAR(128) NOT NULL COMMENT '关键词',
  `match_type` ENUM('exact','phrase','broad','negative') NOT NULL DEFAULT 'broad' COMMENT '匹配方式：exact精确/phrase短语/broad广泛/negative否定',
  `landing_url` VARCHAR(255) NULL COMMENT '落地页URL（可覆盖链接默认地址）',
  `ocpc` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否OCPC：0-否 1-是',
  `status` TINYINT UNSIGNED NOT NULL DEFAULT 1 COMMENT '状态：1-启用 2-停用',
  `remark` VARCHAR(255) NULL COMMENT '备注信息',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_keyword_campaign` (`campaign_id`),
  KEY `idx_keyword_status` (`status`),
  CONSTRAINT `fk_keyword_campaign` FOREIGN KEY (`campaign_id`) REFERENCES `ad_campaign`(`id`)
    ON UPDATE RESTRICT ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='广告统计-关键词表';

-- 点击明细表（原始日志，支持按维度统计）
CREATE TABLE IF NOT EXISTS `ad_click_log` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `occurred_at` DATETIME NOT NULL COMMENT '发生时间',
  `platform_id` BIGINT UNSIGNED NOT NULL COMMENT '平台ID（关联 ad_platform.id）',
  `campaign_id` BIGINT UNSIGNED NULL COMMENT '活动/计划ID（关联 ad_campaign.id，可空）',
  `keyword_id` BIGINT UNSIGNED NULL COMMENT '关键词ID（关联 ad_keyword.id，可空）',
  `link_id` BIGINT UNSIGNED NULL COMMENT '推广链接ID（关联 promotion_link.id，可空）',
  `region_id` BIGINT UNSIGNED NULL COMMENT '地区ID（关联 region_category.id，可空）',
  `device_type` ENUM('pc','mobile','tablet','other') NOT NULL DEFAULT 'other' COMMENT '设备类型',
  `page_position` ENUM('top','bottom','unknown') NOT NULL DEFAULT 'unknown' COMMENT '页面位置：top-页首 bottom-页尾 unknown-未知',
  `page_no` INT UNSIGNED NULL COMMENT '搜索结果页码（可空）',
  `rank_pos` INT UNSIGNED NULL COMMENT '排名位置（可空）',
  `search_term` VARCHAR(255) NULL COMMENT '搜索词（query）',
  `referrer` VARCHAR(255) NULL COMMENT '来源页面（Referer）',
  `url` VARCHAR(255) NULL COMMENT '访问URL（落地页）',
  `ip` VARBINARY(16) NULL COMMENT '访客IP（IPv4/IPv6，二进制存储）',
  `ua` VARCHAR(255) NULL COMMENT 'User-Agent 简要',
  `os` VARCHAR(64) NULL COMMENT '操作系统',
  `browser` VARCHAR(64) NULL COMMENT '浏览器',
  `call_phone` VARCHAR(32) NULL COMMENT '咨询电话（如页面捕获到）',
  `ocpc` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否OCPC：0-否 1-是',
  `cost` DECIMAL(12,2) NULL COMMENT '单次点击成本（元，若平台返回）',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '入库时间',
  PRIMARY KEY (`id`),
  KEY `idx_click_time` (`occurred_at`),
  KEY `idx_click_platform` (`platform_id`),
  KEY `idx_click_campaign` (`campaign_id`),
  KEY `idx_click_keyword` (`keyword_id`),
  KEY `idx_click_link` (`link_id`),
  KEY `idx_click_region` (`region_id`),
  KEY `idx_click_device` (`device_type`),
  CONSTRAINT `fk_click_platform` FOREIGN KEY (`platform_id`) REFERENCES `ad_platform`(`id`)
    ON UPDATE RESTRICT ON DELETE CASCADE,
  CONSTRAINT `fk_click_campaign` FOREIGN KEY (`campaign_id`) REFERENCES `ad_campaign`(`id`)
    ON UPDATE RESTRICT ON DELETE SET NULL,
  CONSTRAINT `fk_click_keyword` FOREIGN KEY (`keyword_id`) REFERENCES `ad_keyword`(`id`)
    ON UPDATE RESTRICT ON DELETE SET NULL,
  CONSTRAINT `fk_click_link` FOREIGN KEY (`link_id`) REFERENCES `promotion_link`(`id`)
    ON UPDATE RESTRICT ON DELETE SET NULL,
  CONSTRAINT `fk_click_region` FOREIGN KEY (`region_id`) REFERENCES `region_category`(`id`)
    ON UPDATE RESTRICT ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='广告统计-点击明细表';

-- 日汇总表（按维度聚合指标）
CREATE TABLE IF NOT EXISTS `ad_daily_summary` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `summary_date` DATE NOT NULL COMMENT '统计日期（yyyy-mm-dd）',
  `platform_id` BIGINT UNSIGNED NOT NULL COMMENT '平台ID（关联 ad_platform.id）',
  `campaign_id` BIGINT UNSIGNED NULL COMMENT '活动/计划ID（关联 ad_campaign.id，可空）',
  `keyword_id` BIGINT UNSIGNED NULL COMMENT '关键词ID（关联 ad_keyword.id，可空）',
  `link_id` BIGINT UNSIGNED NULL COMMENT '推广链接ID（关联 promotion_link.id，可空）',
  `region_id` BIGINT UNSIGNED NULL COMMENT '地区ID（关联 region_category.id，可空）',
  `device_type` ENUM('pc','mobile','tablet','other') NOT NULL DEFAULT 'other' COMMENT '设备类型维度',
  `impressions` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '展现量',
  `clicks` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '点击量',
  `unique_ips` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '独立IP数',
  `uv` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '访客数（UV）',
  `pv` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '浏览量（PV）',
  `calls` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '有效来电数',
  `leads` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '线索（表单/咨询）',
  `conversions` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '转化数',
  `cost` DECIMAL(14,2) NOT NULL DEFAULT 0 COMMENT '消耗（元）',
  `avg_rank` DECIMAL(6,2) NULL COMMENT '平均排名（可空）',
  `ocpc` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否OCPC聚合：0-否 1-是',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_summary_dims` (
    `summary_date`,`platform_id`,`campaign_id`,`keyword_id`,`link_id`,`region_id`,`device_type`,`ocpc`
  ),
  KEY `idx_summary_platform_date` (`platform_id`,`summary_date`),
  CONSTRAINT `fk_summary_platform` FOREIGN KEY (`platform_id`) REFERENCES `ad_platform`(`id`)
    ON UPDATE RESTRICT ON DELETE CASCADE,
  CONSTRAINT `fk_summary_campaign` FOREIGN KEY (`campaign_id`) REFERENCES `ad_campaign`(`id`)
    ON UPDATE RESTRICT ON DELETE SET NULL,
  CONSTRAINT `fk_summary_keyword` FOREIGN KEY (`keyword_id`) REFERENCES `ad_keyword`(`id`)
    ON UPDATE RESTRICT ON DELETE SET NULL,
  CONSTRAINT `fk_summary_link` FOREIGN KEY (`link_id`) REFERENCES `promotion_link`(`id`)
    ON UPDATE RESTRICT ON DELETE SET NULL,
  CONSTRAINT `fk_summary_region` FOREIGN KEY (`region_id`) REFERENCES `region_category`(`id`)
    ON UPDATE RESTRICT ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='广告统计-日汇总表';

