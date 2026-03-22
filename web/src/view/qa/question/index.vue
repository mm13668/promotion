<template>
  <div>
    <div class="gva-search-box">
      <el-form :inline="true">
        <el-form-item>
          <el-button type="primary" icon="plus" @click="openForm()">新增</el-button>
          <el-button type="primary" icon="search" @click="getTableData()">查询</el-button>
        </el-form-item>
      </el-form>
    </div>
    <div class="gva-table-box">
      <el-table :data="tableData" row-key="ID" style="width:100%">
        <el-table-column prop="ID" label="ID" width="80" />
        <el-table-column prop="title" label="标题" min-width="200" />
        <el-table-column prop="status" label="状态" width="120">
          <template #default="{ row }">
            <el-switch 
              v-model="row.status" 
              :active-value="2" 
              :inactive-value="3" 
              active-text="启用"
              inactive-text="关闭"
              @change="updateQuestionStatus(row)"
            />
          </template>
        </el-table-column>
        <el-table-column prop="answer_count" label="回答数" width="100" />
        <el-table-column prop="sort" label="排序" width="100" />
        <el-table-column fixed="right" label="操作" width="280">
          <template #default="{ row }">
            <el-button type="primary" link @click="openAnswerPanel(row)">查看回答</el-button>
            <el-button type="primary" link @click="openForm(row)">编辑</el-button>
            <el-button type="primary" link @click="remove(row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
      <el-pagination class="mt-4" background layout="total, sizes, prev, pager, next, jumper"
        :current-page="page" :page-size="pageSize" :total="total"
        @size-change="handleSizeChange" @current-change="handleCurrentChange" />
    </div>

    <!-- 回答列表抽屉 -->
    <el-drawer v-model="drawerAnswer" size="800" :show-close="false">
      <template #header>
        <div class="flex justify-between items-center">
          <span class="text-lg">回答管理 - 问题：{{ currentQuestion?.title }}</span>
          <div>
            <el-button @click="drawerAnswer=false">关闭</el-button>
            <el-button type="primary" @click="openAnswerForm()">新增回答</el-button>
          </div>
        </div>
      </template>
      <el-table :data="answerList" row-key="ID" style="width:100%">
        <el-table-column prop="ID" label="ID" width="80" />
        <el-table-column prop="nickname" label="昵称" width="120" />
        <el-table-column prop="level" label="等级" width="80" />
        <el-table-column prop="auditStatus" label="审核状态" width="100">
          <template #default="{ row }">
            <el-tag :type="row.auditStatus === 1 ? 'success' : 'warning'">
              {{ row.auditStatus === 1 ? '已审核' : '未审核' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="content" label="内容" min-width="200" show-overflow-tooltip />
        <el-table-column prop="likeCount" label="点赞" width="80" />
        <el-table-column prop="reply_count" label="回复数" width="100" />
        <el-table-column fixed="right" label="操作" width="280">
          <template #default="{ row }">
            <el-button type="primary" link @click="openReplyPanel(row)">查看回复</el-button>
            <el-button type="primary" link @click="openAnswerForm(row)">编辑</el-button>
            <el-button type="primary" link @click="removeAnswer(row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-drawer>

    <!-- 回复列表抽屉 -->
    <el-drawer v-model="drawerReply" size="800" :show-close="false">
      <template #header>
        <div class="flex justify-between items-center">
          <span class="text-lg">回复管理 - 回答ID：{{ currentAnswer?.ID }}</span>
          <div>
            <el-button @click="drawerReply=false">关闭</el-button>
            <el-button type="primary" @click="openReplyForm()">新增回复</el-button>
          </div>
        </div>
      </template>
      <el-table :data="replyList" row-key="ID" style="width:100%">
        <el-table-column prop="ID" label="ID" width="80" />
        <el-table-column prop="nickname" label="昵称" width="120" />
        <el-table-column prop="level" label="等级" width="80" />
        <el-table-column prop="auditStatus" label="审核状态" width="100">
          <template #default="{ row }">
            <el-tag :type="row.auditStatus === 1 ? 'success' : 'warning'">
              {{ row.auditStatus === 1 ? '已审核' : '未审核' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="content" label="内容" min-width="200" show-overflow-tooltip />
        <el-table-column prop="parent_id" label="父级ID" width="100" />
        <el-table-column prop="status" label="状态" width="120">
          <template #default="{ row }">
            <el-switch 
              v-model="row.status" 
              :active-value="1" 
              :inactive-value="3" 
              active-text="正常" 
              inactive-text="下线"
              @change="updateReplyStatus(row)"
            />
          </template>
        </el-table-column>
        <el-table-column fixed="right" label="操作" width="200">
          <template #default="{ row }">
            <el-button type="primary" link @click="openReplyForm(row)">编辑</el-button>
            <el-button type="primary" link @click="removeReply(row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-drawer>

    <!-- 问题编辑抽屉 -->
    <el-drawer v-model="drawer" :size="appStore.drawerSize" :show-close="false">
      <template #header>
        <div class="flex justify-between items-center">
          <span class="text-lg">{{ form.ID ? '编辑' : '新增' }}问题</span>
          <div>
            <el-button @click="drawer=false">取消</el-button>
            <el-button type="primary" @click="submit">确定</el-button>
          </div>
        </div>
      </template>
      <el-form label-position="top" :model="form">
        <el-form-item label="标题">
          <el-input v-model="form.title" />
        </el-form-item>
        <el-form-item label="内容">
          <RichEdit v-model="form.content" :height="400" />
        </el-form-item>
        <el-form-item label="状态">
          <el-switch 
            v-model="form.status" 
            :active-value="2" 
            :inactive-value="3" 
            active-text="已发布" 
            inactive-text="下线"
          />
        </el-form-item>
        <el-form-item label="排序">
          <el-input-number v-model="form.sort" />
        </el-form-item>
      </el-form>
    </el-drawer>

    <!-- 回答编辑抽屉 -->
    <el-drawer v-model="drawerAnswerForm" size="700" :show-close="false">
      <template #header>
        <div class="flex justify-between items-center">
          <span class="text-lg">{{ answerForm.ID ? '编辑' : '新增' }}回答</span>
          <div>
            <el-button @click="drawerAnswerForm=false">取消</el-button>
            <el-button type="primary" @click="submitAnswer">确定</el-button>
          </div>
        </div>
      </template>
      <el-form label-position="top" :model="answerForm">
        <el-form-item label="昵称">
          <el-input v-model="answerForm.nickname" />
        </el-form-item>
        <el-form-item label="头像">
          <div class="flex items-center space-x-4">
            <UploadImage v-model="answerForm.avatarUrl" @on-success="(url) => answerForm.avatarUrl = url"/>
            <img v-if="answerForm.avatarUrl" :src="answerForm.avatarUrl" class="h-16 w-16 object-contain border rounded" />
          </div>
        </el-form-item>
        <el-form-item label="称号">
          <el-select v-model="answerForm.title" clearable filterable placeholder="选填称号" style="width: 100%">
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
        </el-form-item>
        <el-form-item label="个性签名">
          <el-select v-model="answerForm.signature" clearable filterable  placeholder="选填" style="width: 100%">
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
        </el-form-item>
        <el-form-item label="等级">
          <el-input-number v-model="answerForm.level" placeholder="必填" />
        </el-form-item>
        <el-form-item label="赞">
          <el-input-number v-model="answerForm.likeCount" placeholder="必填" />
        </el-form-item>
        <el-form-item label="关注">
          <el-input-number v-model="answerForm.followCount" placeholder="必填" />
        </el-form-item>
        <el-form-item label="收藏">
          <el-input-number v-model="answerForm.favoriteCount" placeholder="必填" />
        </el-form-item>
        <el-form-item label="时间">
          <el-input v-model="answerForm.timeText" placeholder="例如：2天前,10分钟前,刚刚" />
        </el-form-item>
        <el-form-item label="擅长">
          <el-input v-model="answerForm.skill" placeholder="例如：行程规划，私人定制" />
        </el-form-item>
        <el-form-item label="审核状态">
          <el-radio-group v-model="answerForm.auditStatus">
            <el-radio :label="1">已审核</el-radio>
            <el-radio :label="0">未审核</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="内容">
          <RichEdit v-model="answerForm.content" :height="300" />
        </el-form-item>
      </el-form>
    </el-drawer>

    <!-- 回复编辑抽屉 -->
    <el-drawer v-model="drawerReplyForm" size="700" :show-close="false">
      <template #header>
        <div class="flex justify-between items-center">
          <span class="text-lg">{{ replyForm.ID ? '编辑' : '新增' }}回复</span>
          <div>
            <el-button @click="drawerReplyForm=false">取消</el-button>
            <el-button type="primary" @click="submitReply">确定</el-button>
          </div>
        </div>
      </template>
      <el-form label-position="top" :model="replyForm">
        <el-form-item label="昵称">
          <el-input v-model="replyForm.nickname" />
        </el-form-item>
        <el-form-item label="头像">
          <div class="flex items-center space-x-4">
            <UploadImage v-model="replyForm.avatarUrl" @on-success="(url) => replyForm.avatarUrl = url"/>
            <img v-if="replyForm.avatarUrl" :src="replyForm.avatarUrl" class="h-16 w-16 object-contain border rounded" />
          </div>
        </el-form-item>
        <el-form-item label="称号">
          <el-select v-model="answerForm.title" placeholder="选填" style="width: 100%">
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
        </el-form-item>
        <el-form-item label="个性签名">
          <el-input v-model="replyForm.signature" placeholder="选填" />
        </el-form-item>
        <el-form-item label="等级">
          <el-input-number v-model="replyForm.level" placeholder="必填" />
        </el-form-item>
        <el-form-item label="赞">
          <el-input-number v-model="replyForm.likeCount" placeholder="必填" />
        </el-form-item>
        <el-form-item label="关注">
          <el-input-number v-model="replyForm.followCount" placeholder="必填" />
        </el-form-item>
        <el-form-item label="收藏">
          <el-input-number v-model="replyForm.favoriteCount" placeholder="必填" />
        </el-form-item>
        <el-form-item label="时间">
          <el-input v-model="replyForm.timeText" placeholder="例如：2天前,10分钟前,刚刚" />
        </el-form-item>
        <el-form-item label="擅长">
          <el-input v-model="replyForm.skill" placeholder="例如：行程规划，私人定制" />
        </el-form-item>
        <el-form-item label="审核状态">
          <el-radio-group v-model="replyForm.auditStatus">
            <el-radio :label="1">已审核</el-radio>
            <el-radio :label="0">未审核</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="内容">
          <RichEdit v-model="replyForm.content" :height="200" />
        </el-form-item>
        <el-form-item label="父级回复ID">
          <el-input-number v-model="replyForm.parentId" :min="0" />
        </el-form-item>
        <el-form-item label="状态">
          <el-switch 
            v-model="replyForm.status" 
            :active-value="1" 
            :inactive-value="3" 
            active-text="正常" 
            inactive-text="下线"
          />
        </el-form-item>
      </el-form>
    </el-drawer>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import RichEdit from '@/components/richtext/rich-edit.vue'
import UploadImage from "@/components/upload/image.vue";
import { 
  getQAQuestionList, createQAQuestion, updateQAQuestion, deleteQAQuestion,
  getQAAnswerList, createQAAnswer, updateQAAnswer, deleteQAAnswer,
  getQAReplyList, createQAReply, updateQAReply, deleteQAReply
} from '@/api/promotion'
import { useAppStore } from '@/pinia/modules/app'
const appStore = useAppStore()

const tableData = ref([])
const page = ref(1)
const pageSize = ref(10)
const total = ref(0)

// 问题相关
const getTableData = async () => {
  const res = await getQAQuestionList({ page: page.value, pageSize: pageSize.value })
  if (res.code === 0) { 
    tableData.value = res.data.list; 
    total.value = res.data.total; 
    page.value = res.data.page; 
    pageSize.value = res.data.pageSize 
  }
}
getTableData()

const updateQuestionStatus = async (row) => {
  const res = await updateQAQuestion({ ID: row.ID, status: row.status })
  if (res.code === 0) {
    ElMessage.success('状态更新成功')
    getTableData()
  }
}

const handleSizeChange = (v) => { pageSize.value = v; getTableData() }
const handleCurrentChange = (v) => { page.value = v; getTableData() }

const drawer = ref(false)
const form = ref({ ID: 0, title: '', content: '', status: 2, sort: 0 })
const openForm = (row) => { 
  form.value = row ? { ...row } : { ID: 0, title: '', content: '', status: 2, sort: 0 }; 
  drawer.value = true 
}
const submit = async () => {
  if (!form.value.title || !form.value.content) { ElMessage.error('请填写标题与内容'); return }
  let res = form.value.ID ? await updateQAQuestion(form.value) : await createQAQuestion(form.value)
  if (res.code === 0) { ElMessage.success('保存成功'); drawer.value = false; getTableData() }
}
const remove = async (row) => {
  await ElMessageBox.confirm('确认删除该记录？', '提示')
  const res = await deleteQAQuestion({ ID: row.ID })
  if (res.code === 0) { ElMessage.success('删除成功'); getTableData() }
}

// 回答相关
const drawerAnswer = ref(false)
const currentQuestion = ref(null)
const answerList = ref([])
const openAnswerPanel = async (row) => {
  currentQuestion.value = row
  drawerAnswer.value = true
  loadAnswerList()
}
const loadAnswerList = async () => {
  const res = await getQAAnswerList({ questionId: currentQuestion.value.ID, page: 1, pageSize: 100 })
  if (res.code === 0) {
    answerList.value = res.data.list
  }
}
const updateAnswerStatus = async (row) => {
  const res = await updateQAAnswer({ ID: row.ID, status: row.status })
  if (res.code === 0) {
    ElMessage.success('状态更新成功')
    loadAnswerList()
  }
}
const removeAnswer = async (row) => {
  await ElMessageBox.confirm('确认删除该回答？', '提示')
  const res = await deleteQAAnswer({ ID: row.ID })
  if (res.code === 0) { ElMessage.success('删除成功'); loadAnswerList(); getTableData() }
}

const drawerAnswerForm = ref(false)
const answerForm = ref({ ID: 0, questionId: 0, nickname: '', avatarUrl: '', title: '', signature: '', level: null, content: '', followCount: 0, favoriteCount: 0, timeText: '', skill: '', auditStatus: 0, likeCount: 0 })
const openAnswerForm = (row) => {
  answerForm.value = row ? { ...row } : { ID: 0, questionId: currentQuestion.value.ID, nickname: '', avatarUrl: '', title: '', signature: '', level: null, content: '', followCount: 0, favoriteCount: 0, timeText: '', skill: '', auditStatus: 0, likeCount: 0 }
  drawerAnswerForm.value = true
}
const submitAnswer = async () => {
  if (!answerForm.value.content) { ElMessage.error('请填写回答内容'); return }
  let res = answerForm.value.ID ? await updateQAAnswer(answerForm.value) : await createQAAnswer(answerForm.value)
  if (res.code === 0) { ElMessage.success('保存成功'); drawerAnswerForm.value = false; loadAnswerList(); getTableData() }
}

// 回复相关
const drawerReply = ref(false)
const currentAnswer = ref(null)
const replyList = ref([])
const openReplyPanel = async (row) => {
  currentAnswer.value = row
  drawerReply.value = true
  loadReplyList()
}
const loadReplyList = async () => {
  const res = await getQAReplyList({ answerId: currentAnswer.value.ID, page: 1, pageSize: 100 })
  if (res.code === 0) {
    replyList.value = res.data.list
  }
}
const updateReplyStatus = async (row) => {
  const res = await updateQAReply({ ID: row.ID, status: row.status })
  if (res.code === 0) {
    ElMessage.success('状态更新成功')
    loadReplyList()
  }
}
const removeReply = async (row) => {
  await ElMessageBox.confirm('确认删除该回复？', '提示')
  const res = await deleteQAReply({ ID: row.ID })
  if (res.code === 0) { ElMessage.success('删除成功'); loadReplyList(); loadAnswerList() }
}

const drawerReplyForm = ref(false)
const replyForm = ref({ ID: 0, answerId: 0, parentId: null, nickname: '', avatarUrl: '', title: '', signature: '', level: null, content: '', followCount: 0, favoriteCount: 0, timeText: '', skill: '', auditStatus: 0, status: 1, likeCount: 0 })
const openReplyForm = (row) => {
  replyForm.value = row ? { ...row } : { ID: 0, answerId: currentAnswer.value.ID, parentId: null, nickname: '', avatarUrl: '', title: '', signature: '', level: null, content: '', followCount: 0, favoriteCount: 0, timeText: '', skill: '', auditStatus: 0, status: 1, likeCount: 0 }
  drawerReplyForm.value = true
}
const submitReply = async () => {
  if (!replyForm.value.content) { ElMessage.error('请填写回复内容'); return }
  let res = replyForm.value.ID ? await updateQAReply(replyForm.value) : await createQAReply(replyForm.value)
  if (res.code === 0) { ElMessage.success('保存成功'); drawerReplyForm.value = false; loadReplyList(); loadAnswerList() }
}
</script>

<style scoped></style>

