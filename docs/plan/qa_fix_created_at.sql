-- 修复已存在的 created_at = '0000-00-00 00:00:00' 的脏数据
-- Error 1292 (22007): Incorrect datetime value: '0000-00-00' for column 'created_at'
-- 原因：GORM Save() 会把零值 CreatedAt 写入 UPDATE 语句，MySQL 严格模式拒绝 '0000-00-00'
-- 代码修复：已将 qa_service.go 等文件中的 Save() 替换为 Updates()，跳过零值字段

UPDATE qa_question   SET created_at = NOW() WHERE created_at = '0000-00-00 00:00:00' OR created_at IS NULL;
UPDATE qa_answer     SET created_at = NOW() WHERE created_at = '0000-00-00 00:00:00' OR created_at IS NULL;
UPDATE qa_reply      SET created_at = NOW() WHERE created_at = '0000-00-00 00:00:00' OR created_at IS NULL;
UPDATE promotion_link t2
  JOIN (SELECT id FROM promotion_link WHERE created_at = '0000-00-00 00:00:00' OR created_at IS NULL) t1 ON t2.id = t1.id
  SET t2.created_at = NOW();
