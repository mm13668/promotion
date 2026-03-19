INSERT INTO region_category (name, sort, remark)
VALUES 
('北京', 99, NULL),
('新疆', 99, NULL),
('四川', 99, NULL),
('北海', 99, NULL)
ON DUPLICATE KEY UPDATE sort = VALUES(sort), remark = VALUES(remark);

INSERT INTO promotion_group (name, region_id, sort, remark)
VALUES 
('北京', (SELECT id FROM region_category WHERE name='北京' LIMIT 1), 99, NULL),
('新疆', (SELECT id FROM region_category WHERE name='新疆' LIMIT 1), 99, NULL),
('四川', (SELECT id FROM region_category WHERE name='四川' LIMIT 1), 99, NULL),
('北海', (SELECT id FROM region_category WHERE name='北海' LIMIT 1), 99, NULL)
ON DUPLICATE KEY UPDATE region_id = VALUES(region_id), sort = VALUES(sort), remark = VALUES(remark);

INSERT INTO group_member (nickname, region_id, group_id, real_name, wechat, mobile, gender, sort, remark)
VALUES
('法战', (SELECT id FROM region_category WHERE name='北京' LIMIT 1), (SELECT id FROM promotion_group WHERE name='北京' LIMIT 1), 'aaa', 'aaa', '15609958340', '男', 99, NULL),
('肖杰', (SELECT id FROM region_category WHERE name='北京' LIMIT 1), (SELECT id FROM promotion_group WHERE name='北京' LIMIT 1), 'aaa', '78041780263', '78041780263', '男', 99, NULL),
('阿浩', (SELECT id FROM region_category WHERE name='新疆' LIMIT 1), (SELECT id FROM promotion_group WHERE name='新疆' LIMIT 1), 'aaa', '15620877886', '15620877886', '男', 99, NULL),
('阿黑', (SELECT id FROM region_category WHERE name='新疆' LIMIT 1), (SELECT id FROM promotion_group WHERE name='新疆' LIMIT 1), 'aaa', '15287657662', '15287657662', '男', 99, NULL),
('阿富', (SELECT id FROM region_category WHERE name='新疆' LIMIT 1), (SELECT id FROM promotion_group WHERE name='新疆' LIMIT 1), 'aaa', '15084670974', '15084670974', '男', 99, NULL),
('真真', (SELECT id FROM region_category WHERE name='四川' LIMIT 1), (SELECT id FROM promotion_group WHERE name='四川' LIMIT 1), 'aaa', '18392313843', '18392313843', '女', 99, NULL),
('小霞', (SELECT id FROM region_category WHERE name='四川' LIMIT 1), (SELECT id FROM promotion_group WHERE name='四川' LIMIT 1), 'aaa', '17653003183', '17653003183', '女', 99, NULL),
('阿喜', (SELECT id FROM region_category WHERE name='四川' LIMIT 1), (SELECT id FROM promotion_group WHERE name='四川' LIMIT 1), 'aaa', '18288073958', '18288073958', '女', 99, NULL),
('阿鑫', (SELECT id FROM region_category WHERE name='四川' LIMIT 1), (SELECT id FROM promotion_group WHERE name='四川' LIMIT 1), 'aaa', '18268027803', '18268027803', '男', 99, NULL),
('小双', (SELECT id FROM region_category WHERE name='四川' LIMIT 1), (SELECT id FROM promotion_group WHERE name='四川' LIMIT 1), 'aaa', '18682392695', '18682392695', '女', 99, NULL)
ON DUPLICATE KEY UPDATE region_id=VALUES(region_id), group_id=VALUES(group_id), real_name=VALUES(real_name), wechat=VALUES(wechat), mobile=VALUES(mobile), gender=VALUES(gender), sort=VALUES(sort), remark=VALUES(remark);
