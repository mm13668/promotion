# 需求
根据问题管理页面 /Users/wangjingjun/work/promotion/web/src/view/qa/question/index.vue 需要编辑的字段，帮我重新设计sql表，并实现前后端的逻辑

新增菜单：
- 头像昵称管理
- 称号管理
- 个性签名管理
- 标签管理

使用接口请求替换：
```称号管理
          <el-select v-model="form.title" clearable filterable placeholder="选填称号" style="width: 100%">
            <el-option label="选择称号" value="" />
            <el-option label="旅游达人" value="旅游达人" />
            <el-option label="精彩旅行家" value="精彩旅行家" />
            <el-option label="热爱旅行者" value="热爱旅行者" />
            <el-option label="行走的梦想家" value="行走的梦想家" />
            <el-option label="观光旅客" value="观光旅客" />
            <el-option label="旅游探索者" value="旅游探索者" />
            <el-option label="追求自由旅行" value="追求自由旅行" />
            <el-option label="海边星辰" value="海边星辰" />
            <el-option label="潜水家" value="潜水家" />
            <el-option label="自助旅行狂人" value="自助旅行狂人" />
            <el-option label="奇幻旅程" value="奇幻旅程" />
            <el-option label="放飞梦想的旅人" value="放飞梦想的旅人" />
            <el-option label="世界游走者" value="世界游走者" />
            <el-option label="发现者" value="发现者" />
            <el-option label="探索者" value="探索者" />
            <el-option label="漫游者" value="漫游者" />
            <el-option label="放心旅行者" value="放心旅行者" />
            <el-option label="细心旅行家" value="细心旅行家" />
            <el-option label="狂热旅客" value="狂热旅客" />
            <el-option label="登山勇士" value="登山勇士" />
          </el-select>
```

```个性签名

          <el-select v-model="form.signature" clearable filterable  placeholder="选填" style="width: 100%">
            <el-option label="选择个性签名" value="" />
            <el-option label="假如生活欺骗了你，不如一路向西去大理。" value="假如生活欺骗了你，不如一路向西去大理。" />
            <el-option label="旅行对我来说，是恢复青春的活力水。" value="旅行对我来说，是恢复青春的活力水。" />
            <el-option label="接受突如其来的失去，珍惜不期而遇的惊喜。" value="接受突如其来的失去，珍惜不期而遇的惊喜。" />
            <el-option label="世界这么大，我要出去给人看看。" value="世界这么大，我要出去给人看看。" />
            <el-option label="步履不停，脚步不止。" value="步履不停，脚步不止。" />
            <el-option label="脚长在自己身上，往前走就对了。" value="脚长在自己身上，往前走就对了。" />
            <el-option label="旅行，就是从自己活腻的地方到别人活腻的地方去。" value="旅行，就是从自己活腻的地方到别人活腻的地方去。" />
            <el-option label="旅行要学会随遇而安，淡然一点，走走停停。" value="旅行要学会随遇而安，淡然一点，走走停停。" />
            <el-option label="旅行，就是一次心灵的逃避，一种精神的徜徉。" value="旅行，就是一次心灵的逃避，一种精神的徜徉。" />
            <el-option label="旅行，就是离开生活常态，去寻找另一个自己的过程。" value="旅行，就是离开生活常态，去寻找另一个自己的过程。" />
            <el-option label="漫无目的的流浪，任凭大自然左右，不做生活的奴隶。" value="漫无目的的流浪，任凭大自然左右，不做生活的奴隶。" />
            <el-option label="感受不同的风景，充实自己的心灵，留下一份美好的回忆。" value="感受不同的风景，充实自己的心灵，留下一份美好的回忆。" />
            <el-option label="人生不止有苟且，还有诗和远方" value="人生不止有苟且，还有诗和远方" />
            <el-option label="旅行，是平凡生活的必备梦想" value="旅行，是平凡生活的必备梦想" />
            <el-option label="跟我的司机永远在路上" value="跟我的司机永远在路上" />
            <el-option label="下一站，你去哪儿" value="下一站，你去哪儿" />
            <el-option label="仗剑走天涯 四海皆为家" value="仗剑走天涯 四海皆为家" />
            <el-option label="旅行之于我，是一个迷失自己，然后发现自己的过程。" value="旅行之于我，是一个迷失自己，然后发现自己的过程。" />
            <el-option label="梦想便是想仗剑走天涯，看一看世界的繁华。" value="梦想便是想仗剑走天涯，看一看世界的繁华。" />
            <el-option label="每一次旅行对我而言都是一份礼物，开心的、新奇的、惊喜的、真实的。" value="每一次旅行对我而言都是一份礼物，开心的、新奇的、惊喜的、真实的。" />
          </el-select>
```

```标签

          <el-select v-model="form.label" clearable filterable multiple placeholder="选填标签" style="width: 100%">
            <el-option label="选择标签" value="" />
            <el-option label="自由行" value="自由行" />
            <el-option label="亲子游" value="亲子游" />
            <el-option label="品质游" value="品质游" />
            <el-option label="半自助游" value="半自助游" />
            <el-option label="自助游" value="自助游" />
            <el-option label="美食" value="美食" />
            <el-option label="跟团游" value="跟团游" />
            <el-option label="私人订制" value="私人订制" />
          </el-select>
```

## 页面中的头像和昵称的修改支持选择【头像昵称管理】中的数据，也支持手写，头像也支持上传
## 参考代码
```接口请求，筛选数据
const loadBasicOptions = async () => {
  const [r] = await Promise.all([
    getRegionCategoryList({ page: 1, pageSize: 10000 }),
  ])
  if (r.code === 0) regionOptions.value = r.data.list || []
}
loadBasicOptions()
```

## 设计相应的表，放在 /Users/wangjingjun/work/promotion/docs/plan/qa_management_schema.sql 之前的sql可以直接覆盖

## 最后告诉我需要新增的菜单，和其他注意事项