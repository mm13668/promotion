# 完善推广链接页面 /Users/wangjingjun/work/promotion/web/src/view/promotion/link/index.vue
## 推广链接页面 给每一条记录：
- 列表增加统计数据字段：访问、复制次数、转化、到粉	
- 增加一个推广链接按钮，点击后，弹出一个对话框，展示这个记录的移动端和pc端的推广链接
- 增加一个发布更新按钮，点击后，弹出确认框，确认后，调用接口，生成这个记录对应问题的移动端和PC端的html5页面的文件，然后更新这个记录的推广链接
- 增加一个OCPC按钮，点击后，弹出一个提交表单的对话框，表单内容包括：推广平台、Key、Secret，转化类型，回传方式，这几个字段直接放在表 promotion_link 中
提交后，调用接口，更新这个记录的OCPC信息

其中：
- 推广平台：管理页面 /Users/wangjingjun/work/promotion/web/src/view/ad/platform/index.vue 表ad_platform，展示这个推广链接对应的平台
- Key：每个推广平台都有一个Key
- Secret：每个推广平台都有一个Secret
- 转化类型：可选值有：
    1. 表单提交(线索转化)
    2. 有效电话拨打
    3. 一句话咨询(咨询转化)
    4. 订单(订单转化)
    5. 注册(注册转化)
    6. 创建角色(创建角色转化)
    7. 客户自定义类型

- 回传方式：可选值有：1. 手动回传 2. 自动回传

## 注意
增加的字段记得补充在sql中
/Users/wangjingjun/work/promotion/docs/plan/promotion_link_settings_schema.sql