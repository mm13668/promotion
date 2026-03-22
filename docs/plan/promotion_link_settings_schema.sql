-- ===============================
-- 推广链接：核心与配置表结构（含完整注释）
-- 覆盖：基本设置、资质公司、代码、颜色调整、评论设置
-- ===============================

CREATE TABLE IF NOT EXISTS `promotion_link` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `platform_id` BIGINT UNSIGNED NOT NULL COMMENT '推广平台ID（关联 ad_platform.id）',
  `account_id` BIGINT UNSIGNED NULL COMMENT '推广账户ID（外部系统或本系统账户表）',
  `region_id` BIGINT UNSIGNED NULL COMMENT '所属地区分类ID（关联 region_category.id）',
  `group_id` BIGINT UNSIGNED NULL COMMENT '客服分组ID（关联 promotion_group.id）',
  `domain_id` BIGINT UNSIGNED NULL COMMENT '绑定域名ID（关联 promotion_domain.id）',
  `question_id` BIGINT UNSIGNED NULL COMMENT '选择提问ID（关联 qa_question.id）',
--  `tags_json` JSON NULL COMMENT '标签数组（如“电脑端”“移动端”等）',
  `inquiry_count` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '咨询量统计',

  `visit_count` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '访问量统计',
  `copy_count` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '复制量统计',
  `convert_count` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '转化量统计',
  `follow_count` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '到粉量统计',
  
  `status` TINYINT UNSIGNED NOT NULL DEFAULT 1 COMMENT '状态：1-启用 2-停用',
  `https_enabled` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否开启HTTPS：0-否 1-是',
  `sort` INT NOT NULL DEFAULT 0 COMMENT '排序值（越大越靠前）',
  `remark` VARCHAR(255) NULL COMMENT '备注（仅后台展示）',
  `created_by` BIGINT UNSIGNED NULL COMMENT '创建人ID',
  `updated_by` BIGINT UNSIGNED NULL COMMENT '更新人ID',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted_at` DATETIME NULL COMMENT '删除时间（软删除）',
  PRIMARY KEY (`id`),
  KEY `idx_link_status` (`status`),
  KEY `idx_link_domain` (`domain_id`),
  KEY `idx_link_region` (`region_id`),
  KEY `idx_link_group` (`group_id`),
  KEY `idx_link_platform` (`platform_id`),
  CONSTRAINT `fk_link_platform` FOREIGN KEY (`platform_id`) REFERENCES `ad_platform`(`id`)
    ON UPDATE RESTRICT ON DELETE RESTRICT,
  CONSTRAINT `fk_link_question` FOREIGN KEY (`question_id`) REFERENCES `qa_question`(`id`)
    ON UPDATE RESTRICT ON DELETE SET NULL,
  CONSTRAINT `fk_link_domain` FOREIGN KEY (`domain_id`) REFERENCES `promotion_domain`(`id`)
    ON UPDATE RESTRICT ON DELETE SET NULL,
  CONSTRAINT `fk_link_region` FOREIGN KEY (`region_id`) REFERENCES `region_category`(`id`)
    ON UPDATE RESTRICT ON DELETE SET NULL,
  CONSTRAINT `fk_link_group` FOREIGN KEY (`group_id`) REFERENCES `promotion_group`(`id`)
    ON UPDATE RESTRICT ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='推广链接-核心表';

-- 基本设置（与核心表一对一，存储模板与组件开关）
 DROP TABLE IF EXISTS `promotion_link_basic` ;
 CREATE TABLE IF NOT EXISTS `promotion_link_basic` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '删除时间',
  `link_id` BIGINT UNSIGNED NOT NULL COMMENT '推广链接ID',
  `template_mobile_id` BIGINT UNSIGNED NULL COMMENT '手机端模板ID（关联 promotion_template_widget.id）',
  `template_pc_id` BIGINT UNSIGNED NULL COMMENT '电脑端模板ID（关联 promotion_template_widget.id）',
  `mobile_copy_widget_id` BIGINT UNSIGNED NULL COMMENT '手机复制插件ID（关联 promotion_template_widget.id）',
  `mobile_bottom_widget_id` BIGINT UNSIGNED NULL COMMENT '手机底部插件ID（关联 promotion_template_widget.id）',
  `pc_qrcode_widget_id` BIGINT UNSIGNED NULL COMMENT '电脑端二维码插件ID（关联 promotion_template_widget.id）',
  `show_12301_phone` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '显示12301投诉电话',
  `mobile_show_qrcode` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '移动端显示二维码',
  `pc_show_right_qrcode` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '电脑端右侧二维码',
  `auto_detect_device` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '自动判断移动电脑端',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `uk_basic_link` (`link_id` ASC),
  INDEX `idx_deleted_at` (`deleted_at` ASC),
  CONSTRAINT `fk_basic_template_mobile` FOREIGN KEY (`template_mobile_id`) REFERENCES `promotion_template_widget`(`id`) ON UPDATE RESTRICT ON DELETE SET NULL,
  CONSTRAINT `fk_basic_template_pc` FOREIGN KEY (`template_pc_id`) REFERENCES `promotion_template_widget`(`id`) ON UPDATE RESTRICT ON DELETE SET NULL,
  CONSTRAINT `fk_basic_copy_widget` FOREIGN KEY (`mobile_copy_widget_id`) REFERENCES `promotion_template_widget`(`id`) ON UPDATE RESTRICT ON DELETE SET NULL,
  CONSTRAINT `fk_basic_bottom_widget` FOREIGN KEY (`mobile_bottom_widget_id`) REFERENCES `promotion_template_widget`(`id`) ON UPDATE RESTRICT ON DELETE SET NULL,
  CONSTRAINT `fk_basic_qrcode_widget` FOREIGN KEY (`pc_qrcode_widget_id`) REFERENCES `promotion_template_widget`(`id`) ON UPDATE RESTRICT ON DELETE SET NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT = '推广链接基本设置表';

-- 资质公司（与链接一对一，可按链接覆盖企业信息）
CREATE TABLE IF NOT EXISTS `promotion_link_company` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `link_id` BIGINT UNSIGNED NOT NULL COMMENT '推广链接ID（关联 promotion_link.id）',
  `company_name` VARCHAR(128) NOT NULL COMMENT '公司名称',
  `icp_record_no` VARCHAR(64) NULL COMMENT 'ICP备案号',
  `license_no` VARCHAR(64) NULL COMMENT '许可证号',
  `homepage_url` VARCHAR(255) NULL COMMENT '首页链接',
  `about_url` VARCHAR(255) NULL COMMENT '关于我们链接',
  `logo_pc_url` VARCHAR(255) NULL COMMENT '电脑端LOGO地址',
  `logo_mobile_url` VARCHAR(255) NULL COMMENT '手机端LOGO地址',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted_at` DATETIME NULL COMMENT '删除时间（软删除）',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_company_link` (`link_id`),
  CONSTRAINT `fk_company_link` FOREIGN KEY (`link_id`) REFERENCES `promotion_link`(`id`)
    ON UPDATE RESTRICT ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='推广链接-资质公司表';

-- 代码片段（统计/转化/CSS，与链接一对一）
CREATE TABLE IF NOT EXISTS `promotion_link_code` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `link_id` BIGINT UNSIGNED NOT NULL COMMENT '推广链接ID（关联 promotion_link.id）',
  `stat_header_html` MEDIUMTEXT NULL COMMENT '网站统计-顶部代码（HTML/JS）',
  `stat_footer_html` MEDIUMTEXT NULL COMMENT '网站统计-底部代码（HTML/JS）',
  `conversion_script` MEDIUMTEXT NULL COMMENT '转化代码（JS）',
  `css_style_text` MEDIUMTEXT NULL COMMENT 'CSS 样式代码',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_code_link` (`link_id`),
  CONSTRAINT `fk_code_link` FOREIGN KEY (`link_id`) REFERENCES `promotion_link`(`id`)
    ON UPDATE RESTRICT ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='推广链接-代码片段表';

-- 颜色与样式配置（与链接一对一）
CREATE TABLE IF NOT EXISTS `promotion_link_theme` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `link_id` BIGINT UNSIGNED NOT NULL COMMENT '推广链接ID（关联 promotion_link.id）',
  `color_wechat_phone` VARCHAR(16) NULL COMMENT '“微信/电话”颜色（HEX 或 CSS 变量）',
  `color_service_name` VARCHAR(16) NULL COMMENT '客服名称颜色（HEX 或 CSS 变量）',
  `color_copyright` VARCHAR(16) NULL COMMENT '版权颜色（HEX 或 CSS 变量）',
  `bold_all` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '一键加粗：0-否 1-是',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_theme_link` (`link_id`),
  CONSTRAINT `fk_theme_link` FOREIGN KEY (`link_id`) REFERENCES `promotion_link`(`id`)
    ON UPDATE RESTRICT ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='推广链接-颜色调整表';

-- 评论设置（与链接一对一）
CREATE TABLE IF NOT EXISTS `promotion_link_comment` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `link_id` BIGINT UNSIGNED NOT NULL COMMENT '推广链接ID（关联 promotion_link.id）',
  `enable_comment` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '开启评论：0-否 1-是',
  `permission` ENUM('mobile_login','guest') NOT NULL DEFAULT 'mobile_login' COMMENT '评论权限：mobile_login-手机端登录可评论，guest-游客可评论',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_comment_link` (`link_id`),
  CONSTRAINT `fk_comment_link` FOREIGN KEY (`link_id`) REFERENCES `promotion_link`(`id`)
    ON UPDATE RESTRICT ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='推广链接-评论设置表';
