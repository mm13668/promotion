# 完善推广链接页面


# 实现

## 基本设置 
管理手机端模版，关键表字段：ID 名称 内容 类型1
管理电脑端模版，关键表字段：ID 名称 内容 类型2
管理手机复制插件，关键表字段：ID 名称 内容 类型3
管理手机底部插件，关键表字段：ID 名称 内容 类型4
管理电脑端二维码插件，关键表字段：ID 名称 内容 类型5
以上5个统一使用一张模板插件表，用类型来区分
建立增删改差，支持按照模板插件类型筛选，内容 使用富文本组件 richtext 
import RichEdit from '@/components/richtext/rich-edit.vue'

然后基本设置这些模板插件，就从模板插件表中查出来，再选择

## 资质公司
PC LOGO 和 移动 LOGO 要支持上传图片，使用上传组建
import UploadImage from '@/components/upload/image.vue'


## 颜色调整
聚焦颜色框时，弹出颜色选择组建，选择如#ff0000

# sql
增加或修改跟推广链接相关的表，直接在目录下，找到对应的表，修改即可，重写创建表语句
/Users/wangjingjun/work/promotion/docs/plan

# 最后告诉我，怎么新建新的菜单