# 需求
接入腾讯广点通-API转化归因回传数据

回传的实现在 /Users/wangjingjun/work/promotion/server/utils/callback 

落地页「API回传」技术开发说明，请务必先阅读文档内容
https://datanexus.qq.com/doc/develop/guider/interface/conversion/trackingcgi_api_web#1-%E8%BD%AC%E5%8C%96%E6%95%B0%E6%8D%AE%E4%B8%8A%E6%8A%A5%E8%AF%B4%E6%98%8E%E5%8F%8A%E7%A4%BA%E4%BE%8B

表中设置的回传类型字段 promotion_link.ocpc_conversion_type
3 表单提交成功 35 微信复制按钮点击 49 注册激活后登录  27 客户自定义类型 19 有效咨询 30电话拨通

除了 35 微信复制按钮点击 其他的对应如下
api回传类型：
转化类型 转化类型描述
CONFIRM_EFFECTIVE_LEADS 表单预约
REGISTER 注册
CUSTOM 客户自定义类型 关键行为
ONLINE_CONSULT 在线咨询
MAKE_PHONE_CALL 电话拨打
