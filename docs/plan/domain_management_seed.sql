INSERT INTO promotion_domain (domain, cname_target, status, https_status, cert_mode, remark, created_by, updated_by)
VALUES
('bhpl.zoukawwo.cn', NULL, 2, 0, 0, '示例：已停用，未开启HTTPS', NULL, NULL),
('bhpl.zoukawwo.cn', 'bhpl.zoukawwo.cn.w.kunlunss.com', 1, 1, 0, '示例：启用，HTTPS已开启', NULL, NULL)
ON DUPLICATE KEY UPDATE
  cname_target = VALUES(cname_target),
  status = VALUES(status),
  https_status = VALUES(https_status),
  cert_mode = VALUES(cert_mode),
  remark = VALUES(remark);

-- 如需创建示例证书：
-- INSERT INTO ssl_certificate (name, provider, type, serial_no, issuer, not_before, not_after, status, remark)
-- VALUES ('LetsEncrypt-示例', 'LetsEncrypt', 'RSA', 'SN-DEMO', 'LE', NOW(), DATE_ADD(NOW(), INTERVAL 90 DAY), 1, '自动申请示例');

