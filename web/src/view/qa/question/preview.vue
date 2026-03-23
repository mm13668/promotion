<template>
  <div class="min-h-screen bg-gray-50 pb-10">
    <!-- 问题头部 -->
    <div class="bg-white p-6 shadow-sm mb-4">
      <div class="max-w-4xl mx-auto">
        <h1 class="text-2xl font-bold text-gray-800 mb-4">{{ question.title }}</h1>
        <div class="flex flex-wrap gap-2 mb-6">
          <span v-for="tag in question.label" :key="tag" class="px-3 py-1 bg-green-50 text-green-600 rounded-md text-sm">
            {{ tag }}
          </span>
        </div>
        <div class="flex items-center">
          <img v-if="question.avatarUrl" :src="`${getBaseUrl()}/${question.avatarUrl}`"  class="w-12 h-12 rounded-full mr-3" alt="avatar">
          <div class="flex-1">
            <div class="flex items-center gap-2">
              <span class="text-lg font-medium text-orange-500">{{ question.nickname }}</span>
              <span v-if="question.titleName" class="px-2 py-0.5 bg-red-500 text-white text-xs rounded">
                {{ question.titleName }}
              </span>
            </div>
            <div class="text-sm text-gray-500 mt-1">{{ question.timeAt }}</div>
          </div>
        </div>
      </div>
    </div>

    <!-- 问题内容 -->
    <div class="bg-white max-w-4xl mx-auto p-6 shadow-sm mb-4">
      <div :class="['ql-editor-content', !showAllContent ? 'line-clamp-5' : '']" v-html="question.content"></div>
      <div class="text-center mt-6" v-if="contentOverflow">
        <span 
          class="text-blue-500 cursor-pointer hover:underline text-sm" 
          @click="showAllContent = !showAllContent"
        >
          {{ showAllContent ? '收起' : '显示全部' }}
        </span>
      </div>
    </div>

    <!-- 回答列表 -->
    <div class="max-w-4xl mx-auto space-y-4">
      <div v-for="answer in answers" :key="answer.ID" class="bg-white p-6 shadow-sm rounded">
        <div class="flex items-center mb-4">
          <img v-if="answer.avatarUrl" :src="`${getBaseUrl()}/${answer.avatarUrl}`"  class="w-10 h-10 rounded-full mr-3" alt="avatar">
          <div class="flex-1">
            <div class="flex items-center gap-2">
              <span class="text-base font-medium text-blue-500">昵称：{{ answer.nickname }}</span>
            </div>
            <div class="text-sm text-gray-500 mt-1">时间：{{ answer.timeText }}</div>
          </div>
          <div class="flex gap-2">
            <el-button type="text" size="small" class="text-blue-500" @click="toggleReplyInput(answer.ID)">回复</el-button>
            <el-button type="text" size="small" icon="ArrowDown" />
          </div>
        </div>
        <div class="ql-editor-content mb-4 text-gray-700 leading-relaxed" v-html="answer.content"></div>

        <!-- 回复输入框 -->
        <div v-if="showReplyInput === answer.ID" class="mb-4">
          <el-input
            v-model="replyContent"
            type="textarea"
            :rows="3"
            placeholder="请输入回复内容"
            class="w-full mb-2"
          />
          <div class="flex justify-end">
            <el-button type="primary" size="small" @click="submitReply">发布回复</el-button>
          </div>
        </div>

        <!-- 回复列表 -->
        <div v-for="reply in answer.replies" :key="reply.ID" class="bg-yellow-50 p-4 rounded mb-2">
          <div class="flex justify-between items-start mb-2">
            <div class="flex items-center gap-2">
              <img v-if="reply.avatarUrl" :src="`${getBaseUrl()}/${reply.avatarUrl}`"  class="w-8 h-8 rounded-full mr-2" alt="avatar">
              <span class="text-green-600 font-medium">{{ reply.nickname }}</span>
            </div>
          </div>
          <div class="ql-editor-content text-gray-700 ml-10 leading-relaxed" v-html="reply.content"></div>
        </div>
      </div>
    </div>

    <!-- 登录模态框 -->
    <el-dialog v-model="showLoginDialog" title="请先登录" width="400px" center>
      <el-form :model="loginForm" label-width="80px">
        <el-form-item label="手机号" prop="phone">
          <el-input v-model="loginForm.phone" placeholder="请输入手机号" />
        </el-form-item>
        <el-form-item label="密码" prop="password">
          <el-input v-model="loginForm.password" type="password" placeholder="请输入密码" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="showLoginDialog = false">取消</el-button>
        <el-button type="primary" @click="handleLogin">登录/注册</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import { ElMessage } from 'element-plus'
import { getQAQuestionDetail } from '@/api/promotion'
import {getBaseUrl} from "@/utils/format.js";

const route = useRoute()
const question = ref({
  title: '',
  label: [],
  nickname: '',
  avatarUrl: '',
  titleName: '',
  timeAt: '',
  content: ''
})
const answers = ref([])
const showAllContent = ref(false)
const contentOverflow = ref(false)
// 回复相关
const showReplyInput = ref(null) // 存储当前显示回复框的回答ID
const replyContent = ref('')
const currentReplyAnswerId = ref(null)
// 登录相关
const showLoginDialog = ref(false)
const loginForm = ref({
  phone: '',
  password: ''
})

const loadData = async () => {
  const questionId = route.params.id
  if (!questionId) return
  const res = await getQAQuestionDetail(questionId)
  if (res.code === 0 && res.data) {
    question.value = res.data
    answers.value = res.data.answers || []
    // 下一个宏任务检查内容是否溢出
    setTimeout(checkContentOverflow, 0)
  }
}

const checkContentOverflow = () => {
  const el = document.querySelector('.ql-editor-content')
  if (el) {
    // 行高约1.5，5行高度大概7.5em
    const lineHeight = parseFloat(getComputedStyle(el).lineHeight) || 24
    const maxHeight = lineHeight * 5
    contentOverflow.value = el.scrollHeight > maxHeight
  }
}

// 切换回复输入框显示
const toggleReplyInput = (answerId) => {
  if (showReplyInput.value === answerId) {
    showReplyInput.value = null
    replyContent.value = ''
  } else {
    showReplyInput.value = answerId
    currentReplyAnswerId.value = answerId
    replyContent.value = ''
  }
}

// 提交回复
const submitReply = () => {
  if (!replyContent.value.trim()) {
    ElMessage.warning('请输入回复内容')
    return
  }
  // 弹出登录模态框
  showLoginDialog.value = true
}

// 登录/注册
const handleLogin = () => {
  if (!loginForm.value.phone || !loginForm.value.password) {
    ElMessage.warning('请填写手机号和密码')
    return
  }
  // 这里后续可以对接实际登录接口
  ElMessage.success('登录成功')
  showLoginDialog.value = false
  // 登录成功后可以继续处理回复提交逻辑
  // 清空回复框
  showReplyInput.value = null
  replyContent.value = ''
}

onMounted(() => {
  loadData()
})
</script>

<style>
/* 覆盖全局#app样式，让预览页面可以正常滚动 */
#app {
  height: auto !important;
  overflow: auto !important;
}
</style>

<style scoped>
.min-h-screen {
  min-height: 100vh;
}
.ql-editor-content {
  overflow: hidden;
  line-height: 1.6;
}
.ql-editor-content img {
  max-width: 100%;
  height: auto;
}
.line-clamp-5 {
  display: -webkit-box;
  -webkit-line-clamp: 5;
  -webkit-box-orient: vertical;
  overflow: hidden;
}
</style>
