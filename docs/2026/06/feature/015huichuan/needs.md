# 需求
接入超级汇川网页转化API数据上报

回传的实现在 /Users/wangjingjun/work/promotion/server/utils/callback 

落地页「API回传」技术开发说明，请务必先阅读文档内容
https://chaojihuichuan.yuque.com/gwbisb/lv9c4s/onhoq0iemd63z0pp#

表中设置的回传类型字段 promotion_link.ocpc_conversion_type
3 表单提交成功 35 微信复制按钮点击 49 注册激活后登录  27 客户自定义类型 19 有效咨询 30电话拨通

除了 35 微信复制按钮点击 其他的对应如下
api回传类型：
转化ID	转化类型名称
5	表单提交
18	微信
12	注册(网页类)
14	其他
1002	有效咨询
6	电话拨打
