-- ===============================
-- 推广域名管理：表结构
-- 覆盖域名、证书、绑定关系与申请状态
-- ===============================

-- 域名表
CREATE TABLE IF NOT EXISTS `promotion_domain` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `domain` VARCHAR(255) NOT NULL COMMENT '域名（例如: bhpl.zoukawwo.cn）',
  `cname_target` VARCHAR(255) NULL COMMENT 'CNAME 解析目标（例如: bhpl.zoukawwo.cn.w.kunlunss.com）',
  `status` TINYINT UNSIGNED NOT NULL DEFAULT 1 COMMENT '状态：1-启用 2-停用',
  `https_status` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'HTTPS 状态：0-未开启 1-已开启 2-申请中 3-失败',
  `cert_mode` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '证书模式：0-平台申请 1-自有证书 2-复用证书',
  `remark` VARCHAR(255) NULL COMMENT '备注信息',
  `created_by` BIGINT UNSIGNED NULL COMMENT '创建人ID',
  `updated_by` BIGINT UNSIGNED NULL COMMENT '更新人ID',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted_at` DATETIME NULL COMMENT '删除时间（软删除）',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_domain_domain` (`domain`),
  KEY `idx_domain_status` (`status`),
  KEY `idx_domain_https` (`https_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='推广域名管理-域名表';

-- SSL 证书表（支持复用）
CREATE TABLE IF NOT EXISTS `ssl_certificate` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` VARCHAR(128) NOT NULL COMMENT '证书名称（自定义显示名）',
  `provider` VARCHAR(64) NULL COMMENT '证书提供商（例如: LetsEncrypt, Aliyun）',
  `type` VARCHAR(32) NULL COMMENT '证书类型（RSA/ECC等）',
  `serial_no` VARCHAR(128) NULL COMMENT '证书序列号',
  `issuer` VARCHAR(255) NULL COMMENT '签发者',
  `not_before` DATETIME NULL COMMENT '生效时间',
  `not_after` DATETIME NULL COMMENT '到期时间',
  `status` TINYINT UNSIGNED NOT NULL DEFAULT 1 COMMENT '状态：1-可用 2-申请中 3-已过期 4-作废 5-失败',
  `pem_path` VARCHAR(255) NULL COMMENT '证书文件路径（或对象存储KEY）',
  `key_path` VARCHAR(255) NULL COMMENT '私钥文件路径（或对象存储KEY）',
  `remark` VARCHAR(255) NULL COMMENT '备注信息',
  `created_by` BIGINT UNSIGNED NULL COMMENT '创建人ID',
  `updated_by` BIGINT UNSIGNED NULL COMMENT '更新人ID',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted_at` DATETIME NULL COMMENT '删除时间（软删除）',
  PRIMARY KEY (`id`),
  KEY `idx_cert_status` (`status`),
  KEY `idx_cert_expire` (`not_after`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='推广域名管理-SSL证书表';

-- 域名与证书绑定表
CREATE TABLE IF NOT EXISTS `domain_ssl_binding` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `domain_id` BIGINT UNSIGNED NOT NULL COMMENT '域名ID（关联 promotion_domain）',
  `cert_id` BIGINT UNSIGNED NULL COMMENT '证书ID（关联 ssl_certificate，可空）',
  `https_enabled` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否已开启HTTPS：0-否 1-是',
  `force_https` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否强制HTTPS跳转：0-否 1-是',
  `apply_status` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '申请状态：0-未申请 1-申请中 2-已开启 3-失败',
  `apply_message` VARCHAR(255) NULL COMMENT '申请结果描述/失败原因',
  `last_apply_at` DATETIME NULL COMMENT '最近申请时间',
  `remark` VARCHAR(255) NULL COMMENT '备注信息',
  `created_by` BIGINT UNSIGNED NULL COMMENT '创建人ID',
  `updated_by` BIGINT UNSIGNED NULL COMMENT '更新人ID',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted_at` DATETIME NULL COMMENT '删除时间（软删除）',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_domain_cert` (`domain_id`, `cert_id`),
  KEY `idx_binding_domain` (`domain_id`),
  KEY `idx_binding_status` (`apply_status`),
  CONSTRAINT `fk_binding_domain` FOREIGN KEY (`domain_id`) REFERENCES `promotion_domain`(`id`)
    ON UPDATE RESTRICT ON DELETE CASCADE,
  CONSTRAINT `fk_binding_cert` FOREIGN KEY (`cert_id`) REFERENCES `ssl_certificate`(`id`)
    ON UPDATE RESTRICT ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='推广域名管理-域名与证书绑定表';

