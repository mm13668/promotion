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
      <template #header>资质公司</template>
      <el-form label-position="top" :model="form" class="max-w-3xl">
        <el-form-item label="公司名称">
          <el-input v-model="form.companyName" />
        </el-form-item>
        <el-form-item label="ICP备案号">
          <el-input v-model="form.icpRecordNo" />
        </el-form-item>
        <el-form-item label="许可证号">
          <el-input v-model="form.licenseNo" />
        </el-form-item>
        <el-form-item label="首页链接">
          <el-input v-model="form.homepageUrl" />
        </el-form-item>
        <el-form-item label="关于我们链接">
          <el-input v-model="form.aboutUrl" />
        </el-form-item>
        <el-form-item label="PC LOGO">
          <UploadImage v-model="form.logoPcUrl" />
        </el-form-item>
        <el-form-item label="移动 LOGO">
          <UploadImage v-model="form.logoMobileUrl" />
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
import UploadImage from '@/components/upload/image.vue'
import { getLinkCompany, upsertLinkCompany } from '@/api/promotion'

const q = ref({ linkId: null })
const form = ref({ linkId: 0, companyName: '', icpRecordNo: '', licenseNo: '', homepageUrl: '', aboutUrl: '', logoPcUrl: '', logoMobileUrl: '' })

const load = async () => {
  if (!q.value.linkId) { ElMessage.error('请输入 Link ID'); return }
  const res = await getLinkCompany({ linkId: q.value.linkId })
  form.value = { linkId: q.value.linkId, companyName: '', icpRecordNo: '', licenseNo: '', homepageUrl: '', aboutUrl: '', logoPcUrl: '', logoMobileUrl: '' }
  if (res.code === 0 && res.data && res.data.data) Object.assign(form.value, res.data.data)
}
const save = async () => {
  if (!q.value.linkId) { ElMessage.error('请先加载 Link'); return }
  form.value.linkId = q.value.linkId
  const res = await upsertLinkCompany(form.value)
  if (res.code === 0) ElMessage.success('保存成功')
}
</script>

<style scoped></style>

