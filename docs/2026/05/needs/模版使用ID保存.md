# 完善推广链接页面
/Users/wangjingjun/work/promotion/web/src/view/promotion/link/index.vue


## 实现

### promotion/link/index.vue页面下的基本设置 
手机端模版，
电脑端模版， 
手机复制插件， 
管理手机底部插件， 
管理电脑端二维码插件， 
以上5个筛选选择，最后需要保存的是ID，另外修复：如果点开这几个按钮，没获取到数据的话，就会提示报错

修改表 promotion_link_basic 的相应字段股的存储类型，改为存ID

### promotion/link/index.vue页面下的资质公司
PC LOGO 和 移动 LOGO 上传图片后，并没有展示出来，期望需要展示上传后的图片出来

# sql
增加或修改跟推广链接相关的表，直接在目录下，找到对应的表，修改即可，重写创建表语句
/Users/wangjingjun/work/promotion/docs/plan

 