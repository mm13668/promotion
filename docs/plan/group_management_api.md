# 分组管理数据模型与接口设计（MySQL）

## 数据表
- region_category：所属分类分类
- promotion_group：分组，归属于某个所属分类
- group_member：成员，归属于某个分组并关联所属分类

## 字段概览
- region_category(id, name, parent_id, sort, remark, created_at, updated_at, deleted_at)
- promotion_group(id, name, region_id, sort, remark, created_at, updated_at, deleted_at)
- group_member(id, nickname, region_id, group_id, real_name, wechat, mobile, gender, sort, remark, created_at, updated_at, deleted_at)

## 性别取值
- 男 / 女 / 未知

## 常用查询
- 按所属分类列出分组  
  SELECT * FROM promotion_group WHERE region_id = ? ORDER BY sort DESC, id DESC;
- 分页查询成员（带筛选）  
  SELECT * FROM group_member 
  WHERE (region_id = ? OR ? IS NULL) 
    AND (group_id = ? OR ? IS NULL) 
    AND (nickname LIKE CONCAT('%', ?, '%') OR ? IS NULL)
  ORDER BY sort DESC, id DESC
  LIMIT ?, ?;

## 典型接口（REST）
- 所属分类
  - POST /api/regions
  - GET /api/regions?page=&pageSize=
  - PUT /api/regions/:id
  - DELETE /api/regions/:id
- 分组
  - POST /api/groups
  - GET /api/groups?regionId=
  - PUT /api/groups/:id
  - DELETE /api/groups/:id
- 成员
  - POST /api/members
  - GET /api/members?regionId=&groupId=&keyword=&page=&pageSize=
  - PUT /api/members/:id
  - DELETE /api/members/:id

## 约束与建议
- name、nickname 建议建立唯一或组合唯一视业务而定
- 外键用 RESTRICT/ CASCADE，删除分组时级联删除成员
- 所有表保留 sort 字段以支持配置化排序

