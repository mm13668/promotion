# 需求
1. 在页面 /Users/wangjingjun/work/promotion_01/web/src/view/promotion/domain/index.vue 当 HTTPS状态 状态设置为开启时，记录开启时间，在列表中展示从开启那一刻起90天的倒计时，切换关闭，展示-，再次开启，重新倒计时
2. 在页面/Users/wangjingjun/work/promotion_01/web/src/view/layout/header/index.vue 顶部的合适位置，增加一个用户有效期的截止日期，当还剩下10天时，颜色标红，提示续期
sys_users.valid_util字段就是截止有效期，空就是不限时长