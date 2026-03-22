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
            <el-button type="text" size="small" class="text-blue-500">回复</el-button>
            <el-button type="text" size="small" icon="ArrowDown" />
          </div>
        </div>
        <div class="ql-editor-content mb-4 text-gray-700 leading-relaxed" v-html="answer.content"></div>

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
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRoute } from 'vue-router'
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
