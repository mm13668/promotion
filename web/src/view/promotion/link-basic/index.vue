<template>
  <div class="app-container">
    <el-form ref="formRef" :model="form" label-width="180px">
      <el-form-item label="推广链接ID">
        <el-input v-model="form.linkId" disabled />
      </el-form-item>
      <el-form-item label="手机端模板">
        <el-select v-model="form.templateMobileKey" clearable filterable placeholder="请选择手机端模板" style="width: 400px">
          <el-option label="移动端--模板--01" value="mobile_template_01" />
          <el-option label="移动端--模板--02" value="mobile_template_02" />
          <el-option label="移动端--模板--03" value="mobile_template_03" />
          <el-option label="移动端--模板--04" value="mobile_template_04" />
          <el-option label="移动端--模板--05" value="mobile_template_05" />
          <el-option label="移动端--模板--06" value="mobile_template_06" />
          <el-option label="移动端--模板--07" value="mobile_template_07" />
          <el-option label="移动端--模板--08" value="mobile_template_08" />
        </el-select>
        <el-button type="primary" link @click="openTemplateSelector('mobile')">选择模板</el-button>
      </el-form-item>
      <el-form-item label="电脑端模板">
        <el-select v-model="form.templatePcKey" clearable filterable placeholder="请选择电脑端模板" style="width: 400px">
          <el-option label="电脑端--模板--01" value="pc_template_01" />
          <el-option label="电脑端--模板--02" value="pc_template_02" />
          <el-option label="电脑端--模板--03" value="pc_template_03" />
          <el-option label="电脑端--模板--04" value="pc_template_04" />
          <el-option label="电脑端--模板--05" value="pc_template_05" />
        </el-select>
        <el-button type="primary" link @click="openTemplateSelector('pc')">选择模板</el-button>
      </el-form-item>
      <el-form-item label="手机复制插件">
        <el-select v-model="form.mobileCopyWidgetKey" clearable filterable placeholder="请选择手机复制插件" style="width: 400px">
          <el-option label="微信复制弹窗1" value="copy_widget_01" />
          <el-option label="微信复制弹窗2" value="copy_widget_02" />
          <el-option label="一键复制插件" value="copy_widget_03" />
        </el-select>
        <el-button type="primary" link @click="openWidgetSelector('copy')">选择插件</el-button>
      </el-form-item>
      <el-form-item label="手机底部插件">
        <el-select v-model="form.mobileBottomWidgetKey" clearable filterable placeholder="请选择手机底部插件" style="width: 400px">
          <el-option label="底部联系栏" value="bottom_widget_01" />
          <el-option label="底部悬浮按钮" value="bottom_widget_02" />
          <el-option label="底部咨询栏" value="bottom_widget_03" />
        </el-select>
        <el-button type="primary" link @click="openWidgetSelector('bottom')">选择插件</el-button>
      </el-form-item>
      <el-form-item label="电脑端二维码插件">
        <el-select v-model="form.pcQrcodeWidgetKey" clearable filterable placeholder="请选择电脑端二维码插件" style="width: 400px">
          <el-option label="右侧固定二维码" value="qrcode_widget_01" />
          <el-option label="弹窗二维码" value="qrcode_widget_02" />
          <el-option label="底部二维码" value="qrcode_widget_03" />
        </el-select>
        <el-button type="primary" link @click="openWidgetSelector('qrcode')">选择插件</el-button>
      </el-form-item>
      <el-form-item label="显示12301投诉电话">
        <el-switch v-model="form.show12301Phone" active-text="是" inactive-text="否" />
        <span class="ml-4 text-gray-500">开启后落地页上显示投诉电话</span>
      </el-form-item>
      <el-form-item label="移动端显示二维码">
        <el-switch v-model="form.mobileShowQrcode" active-text="是" inactive-text="否" />
        <span class="ml-4 text-gray-500">开启后移动端显示微信二维码</span>
      </el-form-item>
      <el-form-item label="电脑端右侧二维码">
        <el-switch v-model="form.pcShowRightQrcode" active-text="是" inactive-text="否" />
        <span class="ml-4 text-gray-500">开启后电脑端右侧显示二维码</span>
      </el-form-item>
      <el-form-item label="自动判断移动电脑端">
        <el-switch v-model="form.autoDetectDevice" active-text="是" inactive-text="否" />
        <span class="ml-4 text-gray-500">开启自动跳转</span>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="submit">保存</el-button>
        <el-button @click="goBack">返回</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { getLinkBasic, upsertLinkBasic } from '@/api/promotion'

const route = useRoute()
const router = useRouter()
const formRef = ref()
const form = ref({
  linkId: 0,
  templateMobileKey: '',
  templatePcKey: '',
  mobileCopyWidgetKey: '',
  mobileBottomWidgetKey: '',
  pcQrcodeWidgetKey: '',
  show12301Phone: false,
  mobileShowQrcode: false,
  pcShowRightQrcode: false,
  autoDetectDevice: false
})

const loadData = async () => {
  const linkId = route.query.linkId
  if (!linkId) {
    ElMessage.error('缺少推广链接ID')
    return
  }
  form.value.linkId = parseInt(linkId)
  const res = await getLinkBasic({ linkId: form.value.linkId })
  if (res.code === 0 && res.data && res.data.data) {
    Object.assign(form.value, res.data.data)
  }
}

const submit = async () => {
  const res = await upsertLinkBasic(form.value)
  if (res.code === 0) {
    ElMessage.success('保存成功')
  }
}

const goBack = () => {
  router.back()
}

const openTemplateSelector = (type) => {
  // 模板选择器逻辑可后续扩展
  ElMessage.info(`打开${type === 'mobile' ? '手机' : '电脑'}端模板选择器`)
}

const openWidgetSelector = (type) => {
  // 插件选择器逻辑可后续扩展
  ElMessage.info(`打开${type}插件选择器`)
}

onMounted(() => {
  loadData()
})
</script>

<style scoped>
.app-container {
  padding: 20px;
}
</style>
