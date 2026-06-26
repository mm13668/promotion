-- 问答模块：为 qa_answer 和 qa_reply 添加排序字段
-- 用于支持页面可视化中的拖动排序功能

ALTER TABLE `qa_answer` ADD COLUMN `sort` INT NOT NULL DEFAULT 0 COMMENT '排序值（越大越靠前）' AFTER `reply_count`;
ALTER TABLE `qa_answer` ADD INDEX `idx_answer_sort` (`sort`);

ALTER TABLE `qa_reply` ADD COLUMN `sort` INT NOT NULL DEFAULT 0 COMMENT '排序值（越大越靠前）' AFTER `status`;
ALTER TABLE `qa_reply` ADD INDEX `idx_reply_sort` (`sort`);
