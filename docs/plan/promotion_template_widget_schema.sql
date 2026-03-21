CREATE TABLE IF NOT EXISTS `promotion_template_widget` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted_at` DATETIME NULL DEFAULT NULL COMMENT '删除时间',
  `name` VARCHAR(128) NOT NULL COMMENT '名称',
  `content` LONGTEXT NOT NULL COMMENT '内容（富文本）',
  `type` TINYINT UNSIGNED NOT NULL COMMENT '类型 1=手机端模板 2=电脑端模板 3=手机复制插件 4=手机底部插件 5=电脑端二维码插件',
  `status` TINYINT UNSIGNED NOT NULL DEFAULT 1 COMMENT '状态 0=禁用 1=启用',
  PRIMARY KEY (`id`),
  INDEX `idx_widget_type` (`type` ASC),
  INDEX `idx_deleted_at` (`deleted_at` ASC)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT = '模板插件表';

-- 初始化示例数据
INSERT INTO `promotion_template_widget` (`name`, `content`, `type`, `status`) VALUES
('移动端--模板--01', '<div>移动端模板1内容</div>', 1, 1),
('移动端--模板--02', '<div>移动端模板2内容</div>', 1, 1),
('移动端--模板--03', '<div>移动端模板3内容</div>', 1, 1),
('移动端--模板--04', '<div>移动端模板4内容</div>', 1, 1),
('移动端--模板--05', '<div>移动端模板5内容</div>', 1, 1),
('移动端--模板--06', '<div>移动端模板6内容</div>', 1, 1),
('移动端--模板--07', '<div>移动端模板7内容</div>', 1, 1),
('移动端--模板--08', '<div>移动端模板8内容</div>', 1, 1),
('电脑端--模板--01', '<div>电脑端模板1内容</div>', 2, 1),
('电脑端--模板--02', '<div>电脑端模板2内容</div>', 2, 1),
('电脑端--模板--03', '<div>电脑端模板3内容</div>', 2, 1),
('电脑端--模板--04', '<div>电脑端模板4内容</div>', 2, 1),
('电脑端--模板--05', '<div>电脑端模板5内容</div>', 2, 1),
('微信复制弹窗1', '<div>微信复制弹窗1内容</div>', 3, 1),
('微信复制弹窗2', '<div>微信复制弹窗2内容</div>', 3, 1),
('一键复制插件', '<div>一键复制插件内容</div>', 3, 1),
('底部联系栏', '<div>底部联系栏内容</div>', 4, 1),
('底部悬浮按钮', '<div>底部悬浮按钮内容</div>', 4, 1),
('底部咨询栏', '<div>底部咨询栏内容</div>', 4, 1),
('右侧固定二维码', '<div>右侧固定二维码内容</div>', 5, 1),
('弹窗二维码', '<div>弹窗二维码内容</div>', 5, 1),
('底部二维码', '<div>底部二维码内容</div>', 5, 1);
