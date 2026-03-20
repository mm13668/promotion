<template>
  <div>
    <div class="gva-search-box">
      <el-form :inline="true" :model="q">
        <el-form-item label="Link ID">
          <el-input-number v-model="q.linkId" :min="1" />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" icon="search" @click="load">加载</el-button>
        </el-form-item>
      </el-form>
    </div>
    <el-card>
      <template #header>颜色调整</template>
      <el-form label-position="top" :model="form" class="max-w-3xl">
        <el-form-item label="微信/电话颜色">
          <el-input v-model="form.colorWechatPhone" />
        </el-form-item>
        <el-form-item label="客服名称颜色">
          <el-input v-model="form.colorServiceName" />
        </el-form-item>
        <el-form-item label="版权颜色">
          <el-input v-model="form.colorCopyright" />
        </el-form-item>
        <el-form-item label="一键加粗">
          <el-switch v-model="form.boldAll" />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="save">保存</el-button>
        </el-form-item>
      </el-form>
    </el-card>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { ElMessage } from 'element-plus'
import { getLinkTheme, upsertLinkTheme } from '@/api/promotion'

const q = ref({ linkId: null })
const form = ref({ linkId: 0, colorWechatPhone: '', colorServiceName: '', colorCopyright: '', boldAll: false })

const load = async () => {
  if (!q.value.linkId) { ElMessage.error('请输入 Link ID'); return }
  const res = await getLinkTheme({ linkId: q.value.linkId })
  form.value = { linkId: q.value.linkId, colorWechatPhone: '', colorServiceName: '', colorCopyright: '', boldAll: false }
  if (res.code === 0 && res.data && res.data.data) Object.assign(form.value, res.data.data)
}
const save = async () => {
  if (!q.value.linkId) { ElMessage.error('请先加载 Link'); return }
  form.value.linkId = q.value.linkId
  const res = await upsertLinkTheme(form.value)
  if (res.code === 0) ElMessage.success('保存成功')
}
</script>

<style scoped></style>

