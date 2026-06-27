# 需求
接入巨量引擎api回传

回传的实现在 /Users/wangjingjun/work/promotion/server/utils/callback 

落地页「API回传」技术开发说明
https://event-manager.oceanengine.com/docs/8650/h5_api_docs

https://event-manager.oceanengine.com/docs/8650/app_api_docs

https://event-manager.oceanengine.com/docs/8650/all_events

表中设置的回传类型字段 promotion_link.ocpc_conversion_type
3 表单提交成功 35 微信复制按钮点击 49注册激活后登录

对应下方巨量引擎api回传类型：
事件英文名 事件中文名
form 表单提交
wechat 微信复制
active_register 注册



完成落地页API技术对接
获取广告参数信息
您将落地页链接输入到我们巨量引擎中后，我们会自动为你的链接增加 4 个参数adid=__AID__&creativeid=__CID__&creativetype=__CTYPE__&clickid=__CLICKID__
举个例子：原始的 url 是 https://demo.test-domain.com/test/page/，我们会给这个落地页后增加这组参数，变成 https://demo.test-domain.com/test/page/?adid=__AID__&creativeid=__CID__&creativetype=__CTYPE__&clickid=__CLICKID__。需要注意的是，如果原来的url 已有参数，我们会在 query 里增加这些参数，并且有可能会改变原有参数的顺序。例如原有的 url 是 https://demo.test-domain.com/test/page?a=b&c=d#fragment，我们拼接参数后url会变成 https://demo.test-domain.com/test/page?adid=__AID__&c=d&creativeid=__CID__&a=b&creativetype=__CTYPE__&clickid=__CLICKID#fragment。
您可以在落地页的 query 参数中，获取 clickid 这个参数，这个就是我们的关键广告信息。
进行转化回调
获取到 clickid 的参数以后，调用我们的回传接口进行转化上报。
更多目标事件名称可见https://event-manager.oceanengine.com/docs/8650/all_events/
请求地址 : https://analytics.oceanengine.com/api/v2/conversion
请求方法：POST
请求体：
{
"event_type": "form",
"context": {
"ad": {
"callback": "EPHk9cX3pv4CGJax4ZENKI7w4MDev_4C",//callback 这里需要填写的就是从启动参数里获取的 clickid
}

    },
    "timestamp": 1604888786102
}

返回值：
{
"code":0,
"message":"成功"
}

