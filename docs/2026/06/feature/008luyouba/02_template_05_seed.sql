-- template-05 (旅游吧样式) PC端模板注册
-- 在 type=2 中查找最新的排序，然后添加 template-05
INSERT INTO `promotion_template_widget` (`name`, `type`, `created_at`, `updated_at`)
SELECT 'template-05', 2, NOW(), NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM `promotion_template_widget` WHERE `name` = 'template-05' AND `type` = 2
);
