<template>
  <div>
    <div class="gva-search-box">
      <el-form :inline="true" :model="search">
        <el-form-item label="地区">
          <el-select v-model="search.regionId" clearable filterable placeholder="选择地区" style="width: 180px">
            <el-option v-for="r in regionOptions" :key="r.ID" :label="r.name" :value="r.ID" />
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" icon="plus" @click="openForm()">新增</el-button>
          <el-button type="primary" icon="search" @click="getTableData()">查询</el-button>
        </el-form-item>
      </el-form>
    </div>
    <div class="gva-table-box">
      <el-table :data="tableData" row-key="ID" style="width:100%">
        <el-table-column prop="ID" label="ID" width="80" />
        <el-table-column label="地区" min-width="160">
          <template #default="{ row }">
            {{ (regionOptions.find(r => r.ID === row.regionId) || {}).name || row.regionId }}
          </template>
        </el-table-column>
        <el-table-column prop="title" label="标题" min-width="200" />
        <el-table-column prop="sort" label="排序" width="100" />
        <el-table-column prop="answer_count" label="回答数" width="100" />
        <el-table-column prop="remark" label="备注" width="100" />
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
        <el-form-item label="所属分类（地区）">
          <el-select v-model="form.regionId" filterable clearable placeholder="请选择地区">
            <el-option v-for="r in regionOptions" :key="r.ID" :label="r.name" :value="r.ID" />
          </el-select>
        </el-form-item>
        <el-form-item label="提问标题" placeholder="必填" >
          <el-input v-model="form.title" />
        </el-form-item>
        <el-form-item label="提问时间">
          <el-input v-model="form.timeAt" placeholder="例如：2天前,10分钟前,刚刚" />
        </el-form-item>
        <el-form-item label="备注">
          <el-input v-model="form.remark" placeholder="仅在后台显示" />
        </el-form-item>
        <el-form-item label="选择头像昵称（可选）">
          <el-select clearable filterable placeholder="选择已有头像昵称" style="width: 100%" @change="onSelectQuestionAvatarNickname">
            <el-option v-for="item in avatarNicknameOptions" :key="item.ID" :label="item.nickname" :value="item" />
          </el-select>
        </el-form-item>
        <el-form-item label="提问昵称">
          <el-input v-model="form.nickname" placeholder="可手动输入" />
        </el-form-item>
        <el-form-item label="头像">
          <div class="flex items-center space-x-4">
            <UploadImage v-model="form.avatarUrl" @on-success="handleAvatarUrlSuccess"/>
            <img v-if="form.avatarUrl" :src="`${getBaseUrl()}/${form.avatarUrl}`" class="h-16 w-16 object-contain border rounded" />
          </div>
        </el-form-item>

        <el-form-item label="称号">
          <el-select v-model="form.title" clearable filterable allow-create placeholder="选填称号" style="width: 100%">
            <el-option v-for="item in titleOptions" :key="item.ID" :label="item.name" :value="item.name" />
          </el-select>
        </el-form-item>
        <el-form-item label="个性签名">
          <el-select v-model="form.signature" clearable filterable allow-create placeholder="选填" style="width: 100%">
            <el-option v-for="item in signatureOptions" :key="item.ID" :label="item.content" :value="item.content" />
          </el-select>
        </el-form-item>
        <el-form-item label="关注人数">
          <el-input-number v-model="form.followCount" placeholder="必填" />
        </el-form-item>
        <el-form-item label="浏览人数">
          <el-input-number v-model="form.lookCount" placeholder="必填" />
        </el-form-item>
        <el-form-item label="收藏人数">
          <el-input-number v-model="form.favoriteCount" placeholder="必填" />
        </el-form-item>
        <el-form-item label="点赞人数">
          <el-input-number v-model="form.likeCount" placeholder="必填" />
        </el-form-item>

        <el-form-item label="标签">
          <el-select v-model="form.label" clearable filterable multiple allow-create placeholder="选填标签" style="width: 100%">
            <el-option v-for="item in tagOptions" :key="item.ID" :label="item.name" :value="item.name" />
          </el-select>
        </el-form-item>
        <el-form-item label="排序">
          <el-input-number v-model="form.sort" />
        </el-form-item>
        <el-form-item label="内容">
          <RichEdit v-model="form.content" :height="400" />
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
        <el-form-item label="选择头像昵称（可选）">
          <el-select clearable filterable placeholder="选择已有头像昵称" style="width: 100%" @change="onSelectAnswerAvatarNickname">
            <el-option v-for="item in avatarNicknameOptions" :key="item.ID" :label="item.nickname" :value="item" />
          </el-select>
        </el-form-item>
        <el-form-item label="昵称">
          <el-input v-model="answerForm.nickname" placeholder="可手动输入" />
        </el-form-item>
        <el-form-item label="头像">
          <div class="flex items-center space-x-4">
            <UploadImage v-model="answerForm.avatarUrl" @on-success="(url) => answerForm.avatarUrl = url"/>
            <img v-if="answerForm.avatarUrl" :src="answerForm.avatarUrl" class="h-16 w-16 object-contain border rounded" />
          </div>
        </el-form-item>
        <el-form-item label="称号">
          <el-select v-model="answerForm.title" clearable filterable allow-create placeholder="选填称号" style="width: 100%">
            <el-option v-for="item in titleOptions" :key="item.ID" :label="item.name" :value="item.name" />
          </el-select>
        </el-form-item>
        <el-form-item label="个性签名">
          <el-select v-model="answerForm.signature" clearable filterable allow-create placeholder="选填" style="width: 100%">
            <el-option v-for="item in signatureOptions" :key="item.ID" :label="item.content" :value="item.content" />
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
        <el-form-item label="选择头像昵称（可选）">
          <el-select clearable filterable placeholder="选择已有头像昵称" style="width: 100%" @change="onSelectReplyAvatarNickname">
            <el-option v-for="item in avatarNicknameOptions" :key="item.ID" :label="item.nickname" :value="item" />
          </el-select>
        </el-form-item>
        <el-form-item label="昵称">
          <el-input v-model="replyForm.nickname" placeholder="可手动输入" />
        </el-form-item>
        <el-form-item label="头像">
          <div class="flex items-center space-x-4">
            <UploadImage v-model="replyForm.avatarUrl" @on-success="(url) => replyForm.avatarUrl = url"/>
            <img v-if="replyForm.avatarUrl" :src="replyForm.avatarUrl" class="h-16 w-16 object-contain border rounded" />
          </div>
        </el-form-item>
        <el-form-item label="称号">
          <el-select v-model="replyForm.title" clearable filterable allow-create placeholder="选填称号" style="width: 100%">
            <el-option v-for="item in titleOptions" :key="item.ID" :label="item.name" :value="item.name" />
          </el-select>
        </el-form-item>
        <el-form-item label="个性签名">
          <el-select v-model="replyForm.signature" clearable filterable allow-create placeholder="选填" style="width: 100%">
            <el-option v-for="item in signatureOptions" :key="item.ID" :label="item.content" :value="item.content" />
          </el-select>
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
  getQAQuestionList,
  createQAQuestion,
  updateQAQuestion,
  deleteQAQuestion,
  getQAAnswerList,
  createQAAnswer,
  updateQAAnswer,
  deleteQAAnswer,
  getQAReplyList,
  createQAReply,
  updateQAReply,
  deleteQAReply,
  getAdPlatformList,
  getRegionCategoryList,
  getPromotionGroupList, getPromotionDomainList, getTemplateWidgetList,
  getAllEnabledQAAvatarNickname,
  getAllEnabledQATitle,
  getAllEnabledQASignature,
  getAllEnabledQATag
} from '@/api/promotion'
import { useAppStore } from '@/pinia/modules/app'
import {getBaseUrl} from "@/utils/format.js";
const appStore = useAppStore()

const tableData = ref([])
const page = ref(1)
const pageSize = ref(10)
const total = ref(0)

const search = ref({  regionId: null})
const regionOptions = ref([])
const avatarNicknameOptions = ref([])
const titleOptions = ref([])
const signatureOptions = ref([])
const tagOptions = ref([])

// 问题相关
const getTableData = async () => {
  let params = { page: page.value, pageSize: pageSize.value }
  if (search.value.regionId) params.regionId = search.value.regionId
  const res = await getQAQuestionList(params)
  if (res.code === 0) { 
    tableData.value = res.data.list; 
    total.value = res.data.total; 
    page.value = res.data.page; 
    pageSize.value = res.data.pageSize 
  }
}
getTableData()
const loadBasicOptions = async () => {
  const [r, r1, r2, r3, r4] = await Promise.all([
    getRegionCategoryList({ page: 1, pageSize: 10000 }),
    getAllEnabledQAAvatarNickname(),
    getAllEnabledQATitle(),
    getAllEnabledQASignature(),
    getAllEnabledQATag(),
  ])
  if (r.code === 0) regionOptions.value = r.data.list || []
  if (r1.code === 0) avatarNicknameOptions.value = r1.data || []
  if (r2.code === 0) titleOptions.value = r2.data || []
  if (r3.code === 0) signatureOptions.value = r3.data || []
  if (r4.code === 0) tagOptions.value = r4.data || []
}
loadBasicOptions()

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
const form = ref({ ID: 0,regionId: null, title: '', content: '', status: 2, sort: 0 })
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

const handleAvatarUrlSuccess = (url, raw) => {
  form.value.avatarUrl = url
}

const onSelectQuestionAvatarNickname = (item) => {
  if (item) {
    form.value.nickname = item.nickname
    form.value.avatarUrl = item.avatarUrl
  }
}

const onSelectAnswerAvatarNickname = (item) => {
  if (item) {
    answerForm.value.nickname = item.nickname
    answerForm.value.avatarUrl = item.avatarUrl
  }
}

const onSelectReplyAvatarNickname = (item) => {
  if (item) {
    replyForm.value.nickname = item.nickname
    replyForm.value.avatarUrl = item.avatarUrl
  }
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

