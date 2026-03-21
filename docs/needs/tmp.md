# 完善推广链接页面


# 实现
推广平台从 api/promotion/getAdPlatformList?page=1&pageSize=10000 中获取

编号和标题不要
所属分类就是地区
客服分组 就是分组
选择提问 是从 api/promotion/getQAQuestionList?page=1&pageSize=10000 中获取


# sql
修改跟推广链接相关的表，直接在目录下，找到对应的表，修改或者删除字段即可，重写创建表语句
/Users/wangjingjun/work/promotion/docs/plan