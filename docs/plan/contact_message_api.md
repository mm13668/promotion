# 官网留言 API

## 1. 提交留言

**接口：** `POST /api/promotion/contactMessage/create`

**请求体：**
```json
{
  "phone": "13800138000",
  "message": "我想咨询一下产品价格",
  "messageTime": "2026-06-28T12:00:00+08:00"
}
```

**响应：**
```json
{
  "code": 0,
  "data": {},
  "msg": "提交成功"
}
```

## 2. 获取留言列表（管理后台）

**接口：** `GET /api/promotion/contactMessage/list`

**请求参数：**
| 参数 | 类型 | 说明 |
|------|------|------|
| page | int | 页码 |
| pageSize | int | 每页数量 |
| phone | string | 手机号（模糊搜索） |
| isProcessed | bool | 是否已处理 |
| startTime | string | 留言开始时间 |
| endTime | string | 留言结束时间 |

**响应：**
```json
{
  "code": 0,
  "data": {
    "list": [
      {
        "ID": 1,
        "phone": "13800138000",
        "message": "我想咨询一下产品价格",
        "isProcessed": false,
        "messageTime": "2026-06-28T12:00:00+08:00",
        "CreatedAt": "2026-06-28T12:00:00+08:00",
        "UpdatedAt": "2026-06-28T12:00:00+08:00"
      }
    ],
    "total": 1,
    "page": 1,
    "pageSize": 10
  },
  "msg": "获取成功"
}
```

## 3. 更新留言处理状态

**接口：** `PUT /api/promotion/contactMessage/updateProcessed`

**请求体：**
```json
{
  "id": 1,
  "isProcessed": true
}
```

**响应：**
```json
{
  "code": 0,
  "data": {},
  "msg": "更新成功"
}
```
