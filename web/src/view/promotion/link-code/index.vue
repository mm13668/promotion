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
      <template #header>代码设置</template>
      <el-form label-position="top" :model="form" class="max-w-5xl">
        <el-form-item label="统计-顶部代码">
          <el-input v-model="form.statHeaderHtml" type="textarea" rows="8" />
        </el-form-item>
        <el-form-item label="统计-底部代码">
          <el-input v-model="form.statFooterHtml" type="textarea" rows="8" />
        </el-form-item>
        <el-form-item label="转化代码">
          <el-input v-model="form.conversionScript" type="textarea" rows="8" />
        </el-form-item>
        <el-form-item label="CSS 样式">
          <el-input v-model="form.cssStyleText" type="textarea" rows="8" />
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
import { getLinkCode, upsertLinkCode } from '@/api/promotion'

const q = ref({ linkId: null })
const form = ref({ linkId: 0, statHeaderHtml: '', statFooterHtml: '', conversionScript: '', cssStyleText: '' })

const load = async () => {
  if (!q.value.linkId) { ElMessage.error('请输入 Link ID'); return }
  const res = await getLinkCode({ linkId: q.value.linkId })
  form.value = { linkId: q.value.linkId, statHeaderHtml: '', statFooterHtml: '', conversionScript: '', cssStyleText: '' }
  if (res.code === 0 && res.data && res.data.data) Object.assign(form.value, res.data.data)
}
const save = async () => {
  if (!q.value.linkId) { ElMessage.error('请先加载 Link'); return }
  form.value.linkId = q.value.linkId
  const res = await upsertLinkCode(form.value)
  if (res.code === 0) ElMessage.success('保存成功')
}
</script>

<style scoped></style>

