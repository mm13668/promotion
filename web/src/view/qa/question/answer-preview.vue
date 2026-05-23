<template>
  <div class="min-h-screen bg-gray-50 pb-10">
    <!-- 回答头部 -->
    <div class="bg-white p-6 shadow-sm mb-4">
      <div class="max-w-4xl mx-auto">
        <div class="flex items-center">
          <img v-if="answer.avatarUrl" :src="`${getBaseUrl()}/${answer.avatarUrl}`" class="w-12 h-12 rounded-full mr-3" alt="avatar">
          <div class="flex-1">
            <div class="flex items-center gap-2">
              <span class="text-lg font-medium text-blue-500">{{ answer.nickname }}</span>
              <span v-if="answer.titleName" class="px-2 py-0.5 bg-red-500 text-white text-xs rounded">
                {{ answer.titleName }}
              </span>
              <span v-if="answer.level" class="px-2 py-0.5 bg-orange-100 text-orange-600 text-xs rounded">Lv.{{ answer.level }}</span>
            </div>
            <div class="text-sm text-gray-500 mt-1">
              <span>{{ answer.timeText }}</span>
              <span v-if="answer.skill" class="ml-4">擅长：{{ answer.skill }}</span>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- 回答内容 -->
    <div class="bg-white max-w-4xl mx-auto p-6 shadow-sm mb-4">
      <div :class="['ql-editor-content', !showAllContent ? 'line-clamp-5' : '']" v-html="answer.content"></div>
      <div class="text-center mt-6" v-if="contentOverflow">
        <span
          class="text-blue-500 cursor-pointer hover:underline text-sm"
          @click="showAllContent = !showAllContent"
        >
          {{ showAllContent ? '收起' : '显示全部' }}
        </span>
      </div>
    </div>

    <!-- 回复列表 -->
    <div class="max-w-4xl mx-auto">
      <div class="bg-white p-4 shadow-sm rounded mb-4">
        <h3 class="text-base font-medium text-gray-700 mb-4">回复（{{ answer.replies?.length || 0 }}）</h3>
        <div v-if="!answer.replies || answer.replies.length === 0" class="text-center text-gray-400 py-8">
          暂无回复
        </div>
        <div v-for="reply in answer.replies" :key="reply.ID" class="bg-yellow-50 p-4 rounded mb-3">
          <div class="flex items-start">
            <img v-if="reply.avatarUrl" :src="`${getBaseUrl()}/${reply.avatarUrl}`" class="w-8 h-8 rounded-full mr-3 mt-1" alt="avatar">
            <div class="flex-1">
              <div class="flex items-center gap-2 mb-1">
                <span class="text-green-600 font-medium text-sm">{{ reply.nickname }}</span>
                <span v-if="reply.titleName" class="px-1.5 py-0.5 bg-red-500 text-white text-xs rounded">{{ reply.titleName }}</span>
              </div>
              <div class="ql-editor-content text-gray-700 text-sm leading-relaxed" v-html="reply.content"></div>
              <div class="text-xs text-gray-400 mt-1">{{ reply.timeText }}</div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import { getQAAnswerDetail } from '@/api/promotion'
import { getBaseUrl } from '@/utils/format.js'

const route = useRoute()
const answer = ref({
  nickname: '',
  avatarUrl: '',
  titleName: '',
  level: null,
  timeText: '',
  skill: '',
  content: '',
  replies: []
})
const showAllContent = ref(false)
const contentOverflow = ref(false)

const loadData = async () => {
  const answerId = route.params.id
  if (!answerId) return
  const res = await getQAAnswerDetail(answerId)
  if (res.code === 0 && res.data) {
    answer.value = res.data
    setTimeout(checkContentOverflow, 0)
  }
}

const checkContentOverflow = () => {
  const el = document.querySelector('.ql-editor-content')
  if (el) {
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
