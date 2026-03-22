DROP TABLE IF EXISTS `promotion_template_widget`;
CREATE TABLE IF NOT EXISTS `promotion_template_widget` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '删除时间',
  `name` VARCHAR(128) NOT NULL COMMENT '名称',
  `type` TINYINT UNSIGNED NOT NULL COMMENT '类型 1=手机端模板 2=电脑端模板 3=手机复制插件 4=手机底部插件 5=电脑端二维码插件',
  PRIMARY KEY (`id`),
  INDEX `idx_widget_type` (`type` ASC),
  INDEX `idx_deleted_at` (`deleted_at` ASC)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT = '模板插件表';

-- 初始化示例数据
INSERT INTO `promotion_template_widget` (`name`, `type`) VALUES
('template-00', 1),
('template-01', 1),
('template-02', 1),
('template-03', 1),
('template-04', 1),
('template-05', 1),
('template-06', 1),
('template-07', 1),
('template-08', 1),
('template-09', 1),
('template-01', 2),
('template-02', 2),
('wechat-copy-1', 3),
('wechat-copy-2', 3),
('wechat-copy-3', 3),
('wechat-copy-4', 3),
('bottom-bar-1', 4),
('bottom-bar-2', 4),
('bottom-bar-3', 4),
('pc-qrcode-1', 5),
('pc-qrcode-2', 5),
('pc-qrcode-3', 5);
