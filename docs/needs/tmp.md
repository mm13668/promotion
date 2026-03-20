# 修正页面选择

1. 【分组管理】里面的地区ID要通过【地区分类】中表查出来，比如 /api/promotion/getRegionCategoryList?page=1&pageSize=10000 ，然后筛选选择

2. 【成员管理】地区ID要通过【地区分类】中表查出来，比如 /api/promotion/getRegionCategoryList?page=1&pageSize=10000 ，
然后筛选选择；分组ID要通过【分组管理】中表查出来，比如 http://localhost:8080/api/promotion/getPromotionGroupList?page=1&pageSize=10000 ，然后筛选选择