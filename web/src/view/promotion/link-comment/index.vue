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
      <template #header>评论设置</template>
      <el-form label-position="top" :model="form" class="max-w-3xl">
        <el-form-item label="开启评论">
          <el-switch v-model="form.enableComment" />
        </el-form-item>
        <el-form-item label="权限">
          <el-select v-model="form.permission">
            <el-option label="手机登录可评" value="mobile_login" />
            <el-option label="游客可评" value="guest" />
          </el-select>
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
import { getLinkComment, upsertLinkComment } from '@/api/promotion'

const q = ref({ linkId: null })
const form = ref({ linkId: 0, enableComment: false, permission: 'mobile_login' })

const load = async () => {
  if (!q.value.linkId) { ElMessage.error('请输入 Link ID'); return }
  const res = await getLinkComment({ linkId: q.value.linkId })
  form.value = { linkId: q.value.linkId, enableComment: false, permission: 'mobile_login' }
  if (res.code === 0 && res.data && res.data.data) Object.assign(form.value, res.data.data)
}
const save = async () => {
  if (!q.value.linkId) { ElMessage.error('请先加载 Link'); return }
  form.value.linkId = q.value.linkId
  const res = await upsertLinkComment(form.value)
  if (res.code === 0) ElMessage.success('保存成功')
}
</script>

<style scoped></style>

