# 需求
问题管理页面 /Users/wangjingjun/work/promotion/web/src/view/qa/question/index.vue

## 新增回答中，称号要改为选择称号，内容如下
            <option selected="selected" value="">选择称号</option>
            <option value="旅游达人">旅游达人</option>
            <option value="精彩旅行家">精彩旅行家</option>
            <option value="热爱旅行者">热爱旅行者</option>
            <option value="行走的梦想家">行走的梦想家</option>
            <option value="观光旅客">观光旅客</option>
            <option value="旅游探索者">旅游探索者</option>
            <option value="追求自由旅行">追求自由旅行</option>
            <option value="海边星辰">海边星辰</option>
            <option value="潜水家">潜水家</option>
            <option value="自助旅行狂人">自助旅行狂人</option>
            <option value="奇幻旅程">奇幻旅程</option>
            <option value="放飞梦想的旅人">放飞梦想的旅人</option>
            <option value="世界游走者">世界游走者</option>
            <option value="发现者">发现者</option>
            <option value="探索者">探索者</option>
            <option value="漫游者">漫游者</option>
            <option value="放心旅行者">放心旅行者</option>
            <option value="细心旅行家">细心旅行家</option>
            <option value="狂热旅客">狂热旅客</option>
            <option value="登山勇士">登山勇士</option>

## 新增回答中，个性签名要改为选择个性签名，内容如下，只需要文字
<ul><li class="selected">选择个性签名</li><li>假如生活欺骗了你，不如一路向西去大理。</li><li>旅行对我来说，是恢复青春的活力水。</li><li>接受突如其来的失去，珍惜不期而遇的惊喜。</li><li>世界这么大，我要出去给人看看。</li><li>步履不停，脚步不止。</li><li>脚长在自己身上，往前走就对了。</li><li>旅行，就是从自己活腻的地方到别人活腻的地方去。</li><li>旅行要学会随遇而安，淡然一点，走走停停。</li><li>旅行，就是一次心灵的逃避，一种精神的徜徉。</li><li>旅行，就是离开生活常态，去寻找另一个自己的过程。</li><li>漫无目的的流浪，任凭大自然左右，不做生活的奴隶。</li><li>感受不同的风景，充实自己的心灵，留下一份美好的回忆。</li><li>人生不止有苟且，还有诗和远方</li><li>旅行，是平凡生活的必备梦想</li><li>跟我的司机永远在路上</li><li>下一站，你去哪儿</li><li>仗剑走天涯 四海皆为家</li><li>旅行之于我，是一个迷失自己，然后发现自己的过程。</li><li>梦想便是想仗剑走天涯，看一看世界的繁华。</li><li>每一次旅行对我而言都是一份礼物，开心的、新奇的、惊喜的、真实的。</li></ul>

## 新增回答中，去掉状态字段，包括修改sql /Users/wangjingjun/work/promotion/docs/plan/qa_management_schema.sql 文件中对应的字段，并且去除qa_answer表中不需要的字段