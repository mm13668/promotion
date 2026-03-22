-- ===============================
-- 问答模块：问题/回答/回复 表结构 + 基础数据管理表
-- 说明：覆盖“修改提问、修改回答、修改回复”三类页面的核心数据表 + 头像昵称/称号/个性签名/标签基础表
-- ===============================

-- 问题表
DROP TABLE IF EXISTS `qa_question`;
CREATE TABLE IF NOT EXISTS `qa_question` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `region_id` BIGINT UNSIGNED NULL COMMENT '所属分类ID',
  `title` VARCHAR(200) NOT NULL COMMENT '问题标题',
  `content` MEDIUMTEXT NOT NULL COMMENT '问题正文内容',
  `time_at` VARCHAR(50) NULL COMMENT '提问时间显示文本',
  `remark` VARCHAR(255) NULL COMMENT '备注信息',
  `nickname` VARCHAR(50) NULL COMMENT '提问者昵称',
  `avatar_url` VARCHAR(255) NULL COMMENT '提问者头像地址',
  `title_name` VARCHAR(50) NULL COMMENT '提问者称号',
  `signature` VARCHAR(255) NULL COMMENT '提问者个性签名',
  `follow_count` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '关注数',
  `look_count` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '浏览数',
  `favorite_count` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '收藏数',
  `like_count` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '点赞数',
  `label` JSON NULL COMMENT '标签数组',
  `sort` INT NOT NULL DEFAULT 0 COMMENT '排序值（越大越靠前）',
  `answer_count` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '回答数',
  `status` TINYINT UNSIGNED NOT NULL DEFAULT 2 COMMENT '状态：1-草稿 2-已发布 3-下线',
  `created_by` BIGINT UNSIGNED NULL COMMENT '创建人ID',
  `updated_by` BIGINT UNSIGNED NULL COMMENT '更新人ID',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted_at` DATETIME NULL COMMENT '删除时间（软删除）',
  PRIMARY KEY (`id`),
  KEY `idx_question_region` (`region_id`),
  KEY `idx_question_status` (`status`),
  KEY `idx_question_sort` (`sort`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='问答-问题表';

-- 回答表
DROP TABLE IF EXISTS `qa_answer`;
CREATE TABLE IF NOT EXISTS `qa_answer` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `question_id` BIGINT UNSIGNED NOT NULL COMMENT '所属问题ID',
  `nickname` VARCHAR(50) NULL COMMENT '回答者昵称',
  `avatar_url` VARCHAR(255) NULL COMMENT '回答者头像地址',
  `title_name` VARCHAR(50) NULL COMMENT '回答者称号',
  `signature` VARCHAR(255) NULL COMMENT '回答者个性签名',
  `level` INT UNSIGNED NULL COMMENT '等级',
  `content` MEDIUMTEXT NOT NULL COMMENT '回答正文内容',
  `follow_count` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '关注数',
  `favorite_count` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '收藏数',
  `like_count` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '点赞数',
  `time_text` VARCHAR(50) NULL COMMENT '时间显示文本（如：一个月前）',
  `skill` VARCHAR(255) NULL COMMENT '擅长领域',
  `audit_status` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '审核状态：0-未审核 1-已审核',
  `reply_count` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '回复数',
  `created_by` BIGINT UNSIGNED NULL COMMENT '创建人ID',
  `updated_by` BIGINT UNSIGNED NULL COMMENT '更新人ID',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted_at` DATETIME NULL COMMENT '删除时间（软删除）',
  PRIMARY KEY (`id`),
  KEY `idx_answer_question` (`question_id`),
  KEY `idx_answer_audit_status` (`audit_status`),
  CONSTRAINT `fk_answer_question` FOREIGN KEY (`question_id`) REFERENCES `qa_question`(`id`)
    ON UPDATE RESTRICT ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='问答-回答表';

-- 回复表（回答下的评论/楼中楼）
DROP TABLE IF EXISTS `qa_reply`;
CREATE TABLE IF NOT EXISTS `qa_reply` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `answer_id` BIGINT UNSIGNED NOT NULL COMMENT '所属回答ID',
  `parent_id` BIGINT UNSIGNED NULL COMMENT '父级回复ID（为空表示直接回复回答）',
  `nickname` VARCHAR(50) NULL COMMENT '回复者昵称',
  `avatar_url` VARCHAR(255) NULL COMMENT '回复者头像地址',
  `title_name` VARCHAR(50) NULL COMMENT '回复者称号',
  `signature` VARCHAR(255) NULL COMMENT '回复者个性签名',
  `level` INT UNSIGNED NULL COMMENT '等级',
  `content` TEXT NOT NULL COMMENT '回复内容',
  `follow_count` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '关注数',
  `favorite_count` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '收藏数',
  `like_count` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '点赞数',
  `time_text` VARCHAR(50) NULL COMMENT '时间显示文本（如：一个月前）',
  `skill` VARCHAR(255) NULL COMMENT '擅长领域',
  `audit_status` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '审核状态：0-未审核 1-已审核',
  `status` TINYINT UNSIGNED NOT NULL DEFAULT 1 COMMENT '回复状态：1-正常 2-隐藏 3-下线',
  `created_by` BIGINT UNSIGNED NULL COMMENT '创建人ID',
  `updated_by` BIGINT UNSIGNED NULL COMMENT '更新人ID',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted_at` DATETIME NULL COMMENT '删除时间（软删除）',
  PRIMARY KEY (`id`),
  KEY `idx_reply_answer` (`answer_id`),
  KEY `idx_reply_parent` (`parent_id`),
  KEY `idx_reply_audit_status` (`audit_status`),
  CONSTRAINT `fk_reply_answer` FOREIGN KEY (`answer_id`) REFERENCES `qa_answer`(`id`)
    ON UPDATE RESTRICT ON DELETE CASCADE,
  CONSTRAINT `fk_reply_parent` FOREIGN KEY (`parent_id`) REFERENCES `qa_reply`(`id`)
    ON UPDATE RESTRICT ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='问答-回复表';

-- ----------------------------
-- 基础数据管理表
-- ----------------------------

-- ----------------------------
-- Table structure for qa_avatar_nickname 头像昵称管理表
-- ----------------------------
DROP TABLE IF EXISTS `qa_avatar_nickname`;
CREATE TABLE `qa_avatar_nickname` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `avatar_url` varchar(255) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '头像地址',
  `nickname` varchar(50) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '昵称',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '状态 1:启用 0:禁用',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted_at` datetime DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`),
  KEY `idx_status` (`status`),
  KEY `idx_sort` (`sort`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='QA头像昵称管理表';

-- ----------------------------
-- Table structure for qa_title 称号管理表
-- ----------------------------
DROP TABLE IF EXISTS `qa_title`;
CREATE TABLE `qa_title` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '称号名称',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '状态 1:启用 0:禁用',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted_at` datetime DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name` (`name`),
  KEY `idx_status` (`status`),
  KEY `idx_sort` (`sort`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='QA称号管理表';

-- 插入默认称号数据
INSERT INTO `qa_title` (`name`, `sort`) VALUES
('旅游达人', 1),
('精彩旅行家', 2),
('热爱旅行者', 3),
('行走的梦想家', 4),
('观光旅客', 5),
('旅游探索者', 6),
('追求自由旅行', 7),
('海边星辰', 8),
('潜水家', 9),
('自助旅行狂人', 10),
('奇幻旅程', 11),
('放飞梦想的旅人', 12),
('世界游走者', 13),
('发现者', 14),
('探索者', 15),
('漫游者', 16),
('放心旅行者', 17),
('细心旅行家', 18),
('狂热旅客', 19),
('登山勇士', 20);

-- ----------------------------
-- Table structure for qa_signature 个性签名管理表
-- ----------------------------
DROP TABLE IF EXISTS `qa_signature`;
CREATE TABLE `qa_signature` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `content` varchar(255) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '个性签名内容',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '状态 1:启用 0:禁用',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted_at` datetime DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_content` (`content`),
  KEY `idx_status` (`status`),
  KEY `idx_sort` (`sort`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='QA个性签名管理表';

-- 插入默认个性签名数据
INSERT INTO `qa_signature` (`content`, `sort`) VALUES
('假如生活欺骗了你，不如一路向西去大理。', 1),
('旅行对我来说，是恢复青春的活力水。', 2),
('接受突如其来的失去，珍惜不期而遇的惊喜。', 3),
('世界这么大，我要出去给人看看。', 4),
('步履不停，脚步不止。', 5),
('脚长在自己身上，往前走就对了。', 6),
('旅行，就是从自己活腻的地方到别人活腻的地方去。', 7),
('旅行要学会随遇而安，淡然一点，走走停停。', 8),
('旅行，就是一次心灵的逃避，一种精神的徜徉。', 9),
('旅行，就是离开生活常态，去寻找另一个自己的过程。', 10),
('漫无目的的流浪，任凭大自然左右，不做生活的奴隶。', 11),
('感受不同的风景，充实自己的心灵，留下一份美好的回忆。', 12),
('人生不止有苟且，还有诗和远方', 13),
('旅行，是平凡生活的必备梦想', 14),
('跟我的司机永远在路上', 15),
('下一站，你去哪儿', 16),
('仗剑走天涯 四海皆为家', 17),
('旅行之于我，是一个迷失自己，然后发现自己的过程。', 18),
('梦想便是想仗剑走天涯，看一看世界的繁华。', 19),
('每一次旅行对我而言都是一份礼物，开心的、新奇的、惊喜的、真实的。', 20);

-- ----------------------------
-- Table structure for qa_tag 标签管理表
-- ----------------------------
DROP TABLE IF EXISTS `qa_tag`;
CREATE TABLE `qa_tag` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '标签名称',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '状态 1:启用 0:禁用',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted_at` datetime DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name` (`name`),
  KEY `idx_status` (`status`),
  KEY `idx_sort` (`sort`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='QA标签管理表';

-- 插入默认标签数据
INSERT INTO `qa_tag` (`name`, `sort`) VALUES
('自由行', 1),
('亲子游', 2),
('品质游', 3),
('半自助游', 4),
('自助游', 5),
('美食', 6),
('跟团游', 7),
('私人订制', 8);