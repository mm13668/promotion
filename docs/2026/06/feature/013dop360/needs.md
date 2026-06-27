# 需求
接入360点睛实效平台 搜索推广api回传

回传的实现在 /Users/wangjingjun/work/promotion/server/utils/callback 

落地页「API回传」技术开发说明，请务必先阅读文档内容
https://dop.360.cn/static/api.pdf

表中设置的回传类型字段 promotion_link.ocpc_conversion_type
3 表单提交成功 35 微信复制按钮点击 49 注册激活后登录  27 客户自定义类型 19 有效咨询 30电话拨通

除了 35 微信复制按钮点击 其他的对应如下
api回传类型：
转化类型 转化类型描述 移动推广转化名称 PC 搜索转化名称 移动搜索转化名称 展示广告转化名称
SUBMIT 成功提交表单内容 表单提交 表单提交 表单提交 线索转化
REGISTERED 成功产生一次注册 × 注册 注册 注册转化
COUSTOMIZE 客户自定义类型 × 客户自定义 客户自定义 自定义转化
ADVISORY 有效咨询 咨询 一句话咨询 一句话咨询 咨询转化
CALL 有效电话拨打 电话拨打 有效电话拨打 有效电话拨打 有效电话转化

id label value

URL: https://convert.dop.360.cn/uploadWebConvert
HEADER:
App-Key: $Key
App-Sign: md5($Secret.POSTDATA)
Content-Type: application/json;charset=utf-8',
POSTDATA:
{"data":{"request_time":1545033743,"data_industry":"ocpc_ps_convert","data_detail":{"qhclickid
":"9356596331006111412","trans_id":"202cb962ac59075b964b07152d234b70","event":"SUBMI
T","event_time":1545033743 ,"event_param":{"value":2345}}}}
说明：PC 搜索、移动搜索、移动推广、PC 展示等对应的字段及回传要求不同，如不清楚需要回传的数
据所属产品线，还请及时和账户投放人员沟通。
4.3 返回结果说明
{"errno":0,"error":"Success"}
4.4 请求参数说明
参数 是否必填 


ocpc_ps_convert 【PC 搜索推广】


4.4 请求参数说明
参数 是否必填 父节点 类型 & 描述 格式
data 是 OBJECT
request_time 否 data int32
数据发送时间 UTC 时间戳，自 1970 年起，精确到秒
data_industry 是 data string
数据应用方
ENUM(
ocpc_web_convert，
ocpc_ps_convert，
ocpc_ms_convert，ocpc_zs_convert)
其中：
ocpc_web_convert 【移动推广】
ocpc_ps_convert 【PC 搜索推广】
ocpc_ms_convert 【移动搜索】
ocpc_zs_convert 【展示广告】
data_source 否 data string
已授权的第三方咨询工具名称
该名称为枚举类型, 在对接时 360 为各
第三方咨询工具定义参数值
注：由第三方咨询工具上报数据时必填
且非空；由客户自己上报数据时无需填
写此参数
data_detail 是 data OBJECT
数据详细信息
impression_id 是 data_detail string
曝光 ID
data_industry=ocpc_web_convert
时即移动推广，必填且非空
其他产品线不需要该值
qhclickid 是 data_detail String
点击 ID
data_industry=ocpc_ps_convert
data_industry=ocpc_ms_convert
data_industry=ocpc_zs_convert
以上三个该值必填且非空
jzqs 否 data_detail String
展示广告主 ID
data_industry=ocpc_zs_convert
即展示广告，必填且非空，在 API 及
Secret 信息界面获取该值。
trans_id 否 data_detail String
表单或订单唯一值
对重复提交表单或者订单进行去重使用
（比如把表单填写内容做个 MD5 填
入；把订单时间或者订单 ID 做个 MD5
填入。将根据该值进行去重）。当
data_industry=ocpc_web_convert
360 点睛实效平台
奇虎 360 科技有限公司 - 10 -
data_industry=ocpc_ps_convert
data_industry=ocpc_ms_convert
且
当 event=SUBMIT 或 event=ORDER
时, 必填且非空
当 data_industry=ocpc_zs_convert
时，必填且非空
event 是 data_detail string. 转化类型 参数值详见下文
4.5 转化类型参数值
event_time 否 data_detail int32. 转化时间 UTC 时间戳，自 1970 年起，精确到秒
event_param 否 data_detail OBJECT
数据详细信息
仅当
data_industry=ocpc_zs_convert
data_industry=ocpc_ps_convert
data_industry=ocpc_ms_convert
且当 event=ORDER 时,
存在该字段, 定义：订单金额
非必填. 单位为分.
格式：{"value":2345}
仅当
data_industry=ocpc_ps_convert
data_industry=ocpc_ms_convert
存在该字段, 定义：价值分
支持全部转化类型
非必填. 大于 0 的正整数
格式：{"score":123}
仅当
data_industry=ocpc_zs_convert
存在该字段, 定义：业务名称
支持全部转化类型
非必填. 字符串类型
格式：{"bname":"RPG"}
4.5 转化类型参数值
转化类型 转化类型描述 移动推广转化名称 PC 搜索转化名称 移动搜索转化名称 