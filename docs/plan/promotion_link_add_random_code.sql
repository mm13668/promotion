-- 推广链接表添加随机编号字段
ALTER TABLE `promotion_link` 
ADD COLUMN `random_code` VARCHAR(32) NULL COMMENT '随机编号，用于静态页面路径' AFTER `pc_url`,
ADD UNIQUE INDEX `uk_random_code` (`random_code` ASC);