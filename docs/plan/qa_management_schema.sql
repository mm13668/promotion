-- ===============================
-- 问答模块：问题/回答/回复 表结构
-- 说明：覆盖“修改提问、修改回答、修改回复”三类页面的核心数据表
-- ===============================

-- 问题表
CREATE TABLE IF NOT EXISTS `qa_question` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `account_id` BIGINT UNSIGNED NOT NULL COMMENT '所属账号ID（发布者/归属账号）',
  `category_id` BIGINT UNSIGNED NULL COMMENT '所属分类ID（可空）',
  `title` VARCHAR(200) NOT NULL COMMENT '问题标题',
  `content` MEDIUMTEXT NOT NULL COMMENT '问题正文内容（HTML/Markdown）',
  `cover_url` VARCHAR(255) NULL COMMENT '头图地址URL',
  `status` TINYINT UNSIGNED NOT NULL DEFAULT 1 COMMENT '问题状态：1-草稿 2-已发布 3-下线',
  `is_pinned` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否置顶：0-否 1-是',
  `is_private` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否私密：0-否 1-是',
  `view_count` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '浏览量',
  `like_count` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '点赞数',
  `favorite_count` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '收藏数',
  `answer_count` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '回答数',
  `sort` INT NOT NULL DEFAULT 0 COMMENT '排序值（越大越靠前）',
  `remark` VARCHAR(255) NULL COMMENT '备注信息',
  `created_by` BIGINT UNSIGNED NULL COMMENT '创建人ID',
  `updated_by` BIGINT UNSIGNED NULL COMMENT '更新人ID',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted_at` DATETIME NULL COMMENT '删除时间（软删除）',
  PRIMARY KEY (`id`),
  KEY `idx_question_account` (`account_id`),
  KEY `idx_question_category` (`category_id`),
  KEY `idx_question_status` (`status`),
  KEY `idx_question_sort` (`sort`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='问答-问题表';

-- 回答表
CREATE TABLE IF NOT EXISTS `qa_answer` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `question_id` BIGINT UNSIGNED NOT NULL COMMENT '所属问题ID',
  `author_id` BIGINT UNSIGNED NOT NULL COMMENT '回答者账号ID',
  `nickname` VARCHAR(100) NULL COMMENT '昵称',
  `avatar_url` VARCHAR(255) NULL COMMENT '头像地址',
  `title` VARCHAR(100) NULL COMMENT '称号',
  `signature` VARCHAR(255) NULL COMMENT '个性签名',
  `level` INT UNSIGNED NULL COMMENT '等级',
  `content` MEDIUMTEXT NOT NULL COMMENT '回答正文内容（HTML/Markdown）',
  `images_json` JSON NULL COMMENT '图片列表（JSON数组，存图片URL）',
  `follow_count` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '关注数',
  `favorite_count` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '收藏数',
  `time_text` VARCHAR(50) NULL COMMENT '时间显示文本（如：一个月前）',
  `skill` VARCHAR(255) NULL COMMENT '擅长领域',
  `audit_status` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '审核状态：0-未审核 1-已审核',
  `is_accepted` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否被采纳：0-否 1-是',
  `like_count` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '点赞数',
  `reply_count` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '回复数',
  `sort` INT NOT NULL DEFAULT 0 COMMENT '排序值（越大越靠前）',
  `remark` VARCHAR(255) NULL COMMENT '备注信息',
  `created_by` BIGINT UNSIGNED NULL COMMENT '创建人ID',
  `updated_by` BIGINT UNSIGNED NULL COMMENT '更新人ID',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted_at` DATETIME NULL COMMENT '删除时间（软删除）',
  PRIMARY KEY (`id`),
  KEY `idx_answer_question` (`question_id`),
  KEY `idx_answer_author` (`author_id`),
  KEY `idx_answer_status` (`status`),
  CONSTRAINT `fk_answer_question` FOREIGN KEY (`question_id`) REFERENCES `qa_question`(`id`)
    ON UPDATE RESTRICT ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='问答-回答表';

-- 回复表（回答下的评论/楼中楼）
CREATE TABLE IF NOT EXISTS `qa_reply` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `answer_id` BIGINT UNSIGNED NOT NULL COMMENT '所属回答ID',
  `parent_id` BIGINT UNSIGNED NULL COMMENT '父级回复ID（为空表示直接回复回答）',
  `author_id` BIGINT UNSIGNED NOT NULL COMMENT '回复者账号ID',
  `nickname` VARCHAR(100) NULL COMMENT '昵称',
  `avatar_url` VARCHAR(255) NULL COMMENT '头像地址',
  `title` VARCHAR(100) NULL COMMENT '称号',
  `signature` VARCHAR(255) NULL COMMENT '个性签名',
  `level` INT UNSIGNED NULL COMMENT '等级',
  `content` TEXT NOT NULL COMMENT '回复内容（纯文本或HTML）',
  `follow_count` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '关注数',
  `favorite_count` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '收藏数',
  `time_text` VARCHAR(50) NULL COMMENT '时间显示文本（如：一个月前）',
  `skill` VARCHAR(255) NULL COMMENT '擅长领域',
  `audit_status` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '审核状态：0-未审核 1-已审核',
  `status` TINYINT UNSIGNED NOT NULL DEFAULT 1 COMMENT '回复状态：1-正常 2-隐藏 3-下线',
  `like_count` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '点赞数',
  `remark` VARCHAR(255) NULL COMMENT '备注信息',
  `created_by` BIGINT UNSIGNED NULL COMMENT '创建人ID',
  `updated_by` BIGINT UNSIGNED NULL COMMENT '更新人ID',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted_at` DATETIME NULL COMMENT '删除时间（软删除）',
  PRIMARY KEY (`id`),
  KEY `idx_reply_answer` (`answer_id`),
  KEY `idx_reply_parent` (`parent_id`),
  KEY `idx_reply_status` (`status`),
  CONSTRAINT `fk_reply_answer` FOREIGN KEY (`answer_id`) REFERENCES `qa_answer`(`id`)
    ON UPDATE RESTRICT ON DELETE CASCADE,
  CONSTRAINT `fk_reply_parent` FOREIGN KEY (`parent_id`) REFERENCES `qa_reply`(`id`)
    ON UPDATE RESTRICT ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='问答-回复表';

-- 标签表（用于问题打标签）
CREATE TABLE IF NOT EXISTS `qa_tag` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` VARCHAR(64) NOT NULL COMMENT '标签名称',
  `slug` VARCHAR(64) NULL COMMENT '标签别名/缩写（用于唯一标识）',
  `description` VARCHAR(255) NULL COMMENT '标签描述',
  `is_active` TINYINT(1) NOT NULL DEFAULT 1 COMMENT '是否有效：0-否 1-是',
  `sort` INT NOT NULL DEFAULT 0 COMMENT '排序值（越大越靠前）',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted_at` DATETIME NULL COMMENT '删除时间（软删除）',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_tag_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='问答-标签表';

-- 问题与标签关联表（多对多）
CREATE TABLE IF NOT EXISTS `qa_question_tag` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `question_id` BIGINT UNSIGNED NOT NULL COMMENT '问题ID',
  `tag_id` BIGINT UNSIGNED NOT NULL COMMENT '标签ID',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_question_tag` (`question_id`,`tag_id`),
  KEY `idx_qt_tag` (`tag_id`),
  CONSTRAINT `fk_qt_question` FOREIGN KEY (`question_id`) REFERENCES `qa_question`(`id`)
    ON UPDATE RESTRICT ON DELETE CASCADE,
  CONSTRAINT `fk_qt_tag` FOREIGN KEY (`tag_id`) REFERENCES `qa_tag`(`id`)
    ON UPDATE RESTRICT ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='问答-问题标签关联表';

