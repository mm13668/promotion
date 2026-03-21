<template>
  <div>
    <div class="gva-search-box">
      <el-form :inline="true" :model="search">
        <el-form-item label="推广平台">
          <el-select v-model="search.platformId" clearable filterable placeholder="选择平台" style="width: 180px">
            <el-option v-for="p in platformOptions" :key="p.ID" :label="p.name" :value="p.ID" />
          </el-select>
        </el-form-item>
        <el-form-item label="地区">
          <el-select v-model="search.regionId" clearable filterable placeholder="选择地区" style="width: 180px">
            <el-option v-for="r in regionOptions" :key="r.ID" :label="r.name" :value="r.ID" />
          </el-select>
        </el-form-item>
        <el-form-item label="分组">
          <el-select v-model="search.groupId" clearable filterable placeholder="选择分组" style="width: 180px">
            <el-option v-for="g in groupOptions" :key="g.ID" :label="g.name" :value="g.ID" />
          </el-select>
        </el-form-item>
        <el-form-item label="域名">
          <el-select v-model="search.domainId" clearable filterable placeholder="选择域名" style="width: 220px">
            <el-option v-for="d in domainOptions" :key="d.ID" :label="d.domain" :value="d.ID" />
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" icon="search" @click="onSubmit">查询</el-button>
          <el-button icon="refresh" @click="onReset">重置</el-button>
        </el-form-item>
      </el-form>
    </div>
    <div class="gva-table-box">
      <div class="gva-btn-list">
        <el-button type="primary" icon="plus" @click="openForm()">新增</el-button>
      </div>
      <el-table :data="tableData" row-key="ID" style="width:100%">
        <el-table-column prop="ID" label="ID" width="80" />
        <el-table-column label="推广平台" width="140">
          <template #default="{ row }">
            {{ (platformOptions.find(p => p.ID === row.platformId) || {}).name || row.platformId }}
          </template>
        </el-table-column>
        <el-table-column label="地区" min-width="160">
          <template #default="{ row }">
            {{ (regionOptions.find(r => r.ID === row.regionId) || {}).name || row.regionId }}
          </template>
        </el-table-column>
        <el-table-column label="分组" min-width="160">
          <template #default="{ row }">
            {{ (groupOptions.find(g => g.ID === row.groupId) || {}).name || row.groupId }}
          </template>
        </el-table-column>
        <el-table-column label="域名" min-width="220" show-overflow-tooltip>
          <template #default="{ row }">
            {{ (domainOptions.find(d => d.ID === row.domainId) || {}).domain || row.domainId }}
          </template>
        </el-table-column>
        <el-table-column prop="status" label="状态" width="100" />
        <el-table-column prop="sort" label="排序" width="100" />
        <el-table-column fixed="right" label="操作" width="560">
          <template #default="{ row }">
            <el-button type="primary" link @click="openForm(row)">编辑</el-button>
            <el-button type="primary" link @click="openBasic(row)">基本设置</el-button>
            <el-button type="primary" link @click="openCompany(row)">资质公司</el-button>
            <el-button type="primary" link @click="openCode(row)">代码设置</el-button>
            <el-button type="primary" link @click="openTheme(row)">颜色调整</el-button>
            <el-button type="primary" link @click="openComment(row)">评论设置</el-button>
            <el-button type="primary" link @click="remove(row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
      <el-pagination
        class="mt-4"
        background
        layout="total, sizes, prev, pager, next, jumper"
        :current-page="page"
        :page-size="pageSize"
        :total="total"
        @size-change="handleSizeChange"
        @current-change="handleCurrentChange"
      />
    </div>
    <el-drawer v-model="drawer" :size="appStore.drawerSize" :show-close="false">
      <template #header>
        <div class="flex justify-between items-center">
          <span class="text-lg">{{ form.ID ? '编辑' : '新增' }}</span>
          <div>
            <el-button @click="drawer=false">取消</el-button>
            <el-button type="primary" @click="submit">确定</el-button>
          </div>
        </div>
      </template>
      <el-form label-position="top" :model="form">
        <el-form-item label="推广平台">
          <el-select v-model="form.platformId" filterable clearable placeholder="请选择平台">
            <el-option v-for="p in platformOptions" :key="p.ID" :label="p.name" :value="p.ID" />
          </el-select>
        </el-form-item>
        <el-form-item label="地区">
          <el-select v-model="form.regionId" filterable clearable placeholder="请选择地区">
            <el-option v-for="r in regionOptions" :key="r.ID" :label="r.name" :value="r.ID" />
          </el-select>
        </el-form-item>
        <el-form-item label="分组">
          <el-select v-model="form.groupId" filterable clearable placeholder="请选择分组">
            <el-option v-for="g in groupOptions" :key="g.ID" :label="g.name" :value="g.ID" />
          </el-select>
        </el-form-item>
        <el-form-item label="域名">
          <el-select v-model="form.domainId" filterable clearable placeholder="请选择域名">
            <el-option v-for="d in domainOptions" :key="d.ID" :label="d.domain" :value="d.ID" />
          </el-select>
        </el-form-item>
        <el-form-item label="选择提问">
          <el-select v-model="form.questionId" filterable clearable placeholder="请选择提问">
            <el-option v-for="q in qaQuestionOptions" :key="q.ID" :label="q.title" :value="q.ID" />
          </el-select>
        </el-form-item>
        <el-form-item label="状态">
          <el-input-number v-model="form.status" :min="0" />
        </el-form-item>
        <el-form-item label="排序">
          <el-input-number v-model="form.sort" />
        </el-form-item>
        <el-form-item label="备注">
          <el-input type="textarea" v-model="form.remark" />
        </el-form-item>
      </el-form>
    </el-drawer>
    <el-drawer v-model="drawerBasic" :show-close="false" size="600">
      <template #header>
        <div class="flex justify-between items-center">
          <span class="text-lg">基本设置</span>
          <div>
            <el-button @click="drawerBasic=false">取消</el-button>
            <el-button type="primary" @click="submitBasic">保存</el-button>
          </div>
        </div>
      </template>
      <el-form label-position="left" label-width="160px" :model="basic">
        <el-form-item label="手机端模板">
          <el-select v-model="basic.templateMobileKey" clearable filterable placeholder="请选择手机端模板" style="width: 300px">
            <el-option label="移动端--模板--01" value="mobile_template_01" />
            <el-option label="移动端--模板--02" value="mobile_template_02" />
            <el-option label="移动端--模板--03" value="mobile_template_03" />
            <el-option label="移动端--模板--04" value="mobile_template_04" />
            <el-option label="移动端--模板--05" value="mobile_template_05" />
            <el-option label="移动端--模板--06" value="mobile_template_06" />
            <el-option label="移动端--模板--07" value="mobile_template_07" />
            <el-option label="移动端--模板--08" value="mobile_template_08" />
          </el-select>
          <el-button type="primary" link class="ml-2">选择模板</el-button>
        </el-form-item>
        <el-form-item label="电脑端模板">
          <el-select v-model="basic.templatePcKey" clearable filterable placeholder="请选择电脑端模板" style="width: 300px">
            <el-option label="电脑端--模板--01" value="pc_template_01" />
            <el-option label="电脑端--模板--02" value="pc_template_02" />
            <el-option label="电脑端--模板--03" value="pc_template_03" />
            <el-option label="电脑端--模板--04" value="pc_template_04" />
            <el-option label="电脑端--模板--05" value="pc_template_05" />
          </el-select>
          <el-button type="primary" link class="ml-2">选择模板</el-button>
        </el-form-item>
        <el-form-item label="手机复制插件">
          <el-select v-model="basic.mobileCopyWidgetKey" clearable filterable placeholder="请选择手机复制插件" style="width: 300px">
            <el-option label="微信复制弹窗1" value="copy_widget_01" />
            <el-option label="微信复制弹窗2" value="copy_widget_02" />
            <el-option label="微信复制弹窗3" value="copy_widget_03" />
          </el-select>
          <el-button type="primary" link class="ml-2">选择插件</el-button>
        </el-form-item>
        <el-form-item label="手机底部插件">
          <el-select v-model="basic.mobileBottomWidgetKey" clearable filterable placeholder="请选择手机底部插件" style="width: 300px">
            <el-option label="手机底部插件1" value="bottom_widget_01" />
            <el-option label="手机底部插件2" value="bottom_widget_02" />
            <el-option label="手机底部插件3" value="bottom_widget_03" />
          </el-select>
          <el-button type="primary" link class="ml-2">选择插件</el-button>
        </el-form-item>
        <el-form-item label="电脑端二维码插件">
          <el-select v-model="basic.pcQrcodeWidgetKey" clearable filterable placeholder="请选择电脑端二维码插件" style="width: 300px">
            <el-option label="右侧固定二维码" value="qrcode_widget_01" />
            <el-option label="弹窗二维码" value="qrcode_widget_02" />
            <el-option label="底部二维码" value="qrcode_widget_03" />
          </el-select>
          <el-button type="primary" link class="ml-2">选择插件</el-button>
        </el-form-item>
        <el-form-item label="显示12301投诉电话">
          <el-switch v-model="basic.show12301Phone" active-text="是" inactive-text="否" />
          <span class="ml-4 text-gray-500">开启后落地页上显示投诉电话</span>
        </el-form-item>
        <el-form-item label="移动端显示二维码">
          <el-switch v-model="basic.mobileShowQrcode" active-text="是" inactive-text="否" />
          <span class="ml-4 text-gray-500">开启后移动端显示微信二维码</span>
        </el-form-item>
        <el-form-item label="电脑端右侧二维码">
          <el-switch v-model="basic.pcShowRightQrcode" active-text="是" inactive-text="否" />
          <span class="ml-4 text-gray-500">开启后电脑端右侧显示二维码</span>
        </el-form-item>
        <el-form-item label="自动判断移动电脑端">
          <el-switch v-model="basic.autoDetectDevice" active-text="是" inactive-text="否" />
          <span class="ml-4 text-gray-500">开启自动跳转</span>
        </el-form-item>
      </el-form>
    </el-drawer>
    <el-drawer v-model="drawerCompany" :show-close="false">
      <template #header>
        <div class="flex justify-between items-center">
          <span class="text-lg">资质公司</span>
          <div>
            <el-button @click="drawerCompany=false">取消</el-button>
            <el-button type="primary" @click="submitCompany">保存</el-button>
          </div>
        </div>
      </template>
      <el-form label-position="top" :model="company">
        <el-form-item label="公司名称">
          <el-input v-model="company.companyName" />
        </el-form-item>
        <el-form-item label="ICP备案号">
          <el-input v-model="company.icpRecordNo" />
        </el-form-item>
        <el-form-item label="许可证号">
          <el-input v-model="company.licenseNo" />
        </el-form-item>
        <el-form-item label="首页链接">
          <el-input v-model="company.homepageUrl" />
        </el-form-item>
        <el-form-item label="关于我们链接">
          <el-input v-model="company.aboutUrl" />
        </el-form-item>
        <el-form-item label="PC LOGO">
          <el-input v-model="company.logoPcUrl" />
        </el-form-item>
        <el-form-item label="移动 LOGO">
          <el-input v-model="company.logoMobileUrl" />
        </el-form-item>
      </el-form>
    </el-drawer>
    <el-drawer v-model="drawerCode" :show-close="false" size="60%">
      <template #header>
        <div class="flex justify-between items-center">
          <span class="text-lg">代码设置</span>
          <div>
            <el-button @click="drawerCode=false">取消</el-button>
            <el-button type="primary" @click="submitCode">保存</el-button>
          </div>
        </div>
      </template>
      <el-form label-position="top" :model="codeCfg">
        <el-form-item label="统计-顶部代码">
          <el-input v-model="codeCfg.statHeaderHtml" type="textarea" rows="6" />
        </el-form-item>
        <el-form-item label="统计-底部代码">
          <el-input v-model="codeCfg.statFooterHtml" type="textarea" rows="6" />
        </el-form-item>
        <el-form-item label="转化代码">
          <el-input v-model="codeCfg.conversionScript" type="textarea" rows="6" />
        </el-form-item>
        <el-form-item label="CSS 样式">
          <el-input v-model="codeCfg.cssStyleText" type="textarea" rows="6" />
        </el-form-item>
      </el-form>
    </el-drawer>
    <el-drawer v-model="drawerTheme" :show-close="false">
      <template #header>
        <div class="flex justify-between items-center">
          <span class="text-lg">颜色调整</span>
          <div>
            <el-button @click="drawerTheme=false">取消</el-button>
            <el-button type="primary" @click="submitTheme">保存</el-button>
          </div>
        </div>
      </template>
      <el-form label-position="top" :model="theme">
        <el-form-item label="微信/电话颜色">
          <el-input v-model="theme.colorWechatPhone" />
        </el-form-item>
        <el-form-item label="客服名称颜色">
          <el-input v-model="theme.colorServiceName" />
        </el-form-item>
        <el-form-item label="版权颜色">
          <el-input v-model="theme.colorCopyright" />
        </el-form-item>
        <el-form-item label="一键加粗">
          <el-switch v-model="theme.boldAll" />
        </el-form-item>
      </el-form>
    </el-drawer>
    <el-drawer v-model="drawerComment" :show-close="false">
      <template #header>
        <div class="flex justify-between items-center">
          <span class="text-lg">评论设置</span>
          <div>
            <el-button @click="drawerComment=false">取消</el-button>
            <el-button type="primary" @click="submitComment">保存</el-button>
          </div>
        </div>
      </template>
      <el-form label-position="top" :model="comment">
        <el-form-item label="开启评论">
          <el-switch v-model="comment.enableComment" />
        </el-form-item>
        <el-form-item label="权限">
          <el-select v-model="comment.permission">
            <el-option label="手机登录可评" value="mobile_login" />
            <el-option label="游客可评" value="guest" />
          </el-select>
        </el-form-item>
      </el-form>
    </el-drawer>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage, ElMessageBox } from 'element-plus'
const router = useRouter()
import {
  getPromotionLinkList, createPromotionLink, updatePromotionLink, deletePromotionLink,
  getLinkBasic, upsertLinkBasic,
  getLinkCompany, upsertLinkCompany,
  getLinkCode, upsertLinkCode,
  getLinkTheme, upsertLinkTheme,
  getLinkComment, upsertLinkComment,
  getRegionCategoryList, getPromotionGroupList, getPromotionDomainList,
  getAdPlatformList, getQAQuestionList
} from '@/api/promotion'
import { useAppStore } from '@/pinia/modules/app'
const appStore = useAppStore()

const search = ref({ platformId: null, regionId: null, groupId: null, domainId: null })
const tableData = ref([])
const page = ref(1)
const pageSize = ref(10)
const total = ref(0)
const platformOptions = ref([])
const regionOptions = ref([])
const groupOptions = ref([])
const domainOptions = ref([])
const qaQuestionOptions = ref([])
// 服务端筛选，按需传递查询参数
const getTableData = async () => {
  const res = await getPromotionLinkList({ page: page.value, pageSize: pageSize.value })
  if (res.code === 0) {
    tableData.value = res.data.list
    total.value = res.data.total
    page.value = res.data.page
    pageSize.value = res.data.pageSize
  }
}
getTableData()
const loadBasicOptions = async () => {
  const [p, r, g, d, q] = await Promise.all([
    getAdPlatformList({ page: 1, pageSize: 10000 }),
    getRegionCategoryList({ page: 1, pageSize: 10000 }),
    getPromotionGroupList({ page: 1, pageSize: 10000 }),
    getPromotionDomainList({ page: 1, pageSize: 10000 }),
    getQAQuestionList({ page: 1, pageSize: 10000 })
  ])
  if (p.code === 0) platformOptions.value = p.data.list || []
  if (r.code === 0) regionOptions.value = r.data.list || []
  if (g.code === 0) groupOptions.value = g.data.list || []
  if (d.code === 0) domainOptions.value = d.data.list || []
  if (q.code === 0) qaQuestionOptions.value = q.data.list || []
}
loadBasicOptions()
const onSubmit = async () => {
  const params = {
    page: page.value,
    pageSize: pageSize.value
  }
  if (search.value.platformId) params.platformId = search.value.platformId
  if (search.value.regionId) params.regionId = search.value.regionId
  if (search.value.groupId) params.groupId = search.value.groupId
  if (search.value.domainId) params.domainId = search.value.domainId
  const res = await getPromotionLinkList(params)
  if (res.code === 0) {
    tableData.value = res.data.list
    total.value = res.data.total
    page.value = res.data.page
    pageSize.value = res.data.pageSize
  }
}
const onReset = () => { search.value = { platformId: null, regionId: null, groupId: null, domainId: null }; onSubmit() }
const handleSizeChange = (val) => { pageSize.value = val; getTableData() }
const handleCurrentChange = (val) => { page.value = val; getTableData() }

const drawer = ref(false)
const form = ref({ ID: 0, platformId: null, regionId: null, groupId: null, domainId: null, questionId: null, status: 1, sort: 0, remark: '' })
const openForm = (row) => {
  form.value = row ? { ...row } : { ID: 0, platformId: null, regionId: null, groupId: null, domainId: null, questionId: null, status: 1, sort: 0, remark: '' }
  drawer.value = true
}
const submit = async () => {
  let res
  if (form.value.ID) res = await updatePromotionLink(form.value)
  else res = await createPromotionLink(form.value)
  if (res.code === 0) { ElMessage.success('保存成功'); drawer.value = false; getTableData() }
}
const remove = async (row) => {
  await ElMessageBox.confirm('确认删除该记录？', '提示')
  const res = await deletePromotionLink({ ID: row.ID })
  if (res.code === 0) { ElMessage.success('删除成功'); getTableData() }
}

const drawerBasic = ref(false)
const basic = ref({
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
const openBasic = async (row) => {
  basic.value = {
    linkId: row.ID,
    templateMobileKey: '',
    templatePcKey: '',
    mobileCopyWidgetKey: '',
    mobileBottomWidgetKey: '',
    pcQrcodeWidgetKey: '',
    show12301Phone: false,
    mobileShowQrcode: false,
    pcShowRightQrcode: false,
    autoDetectDevice: false
  }
  const res = await getLinkBasic({ linkId: row.ID })
  if (res.code === 0 && res.data && res.data.data) Object.assign(basic.value, res.data.data)
  drawerBasic.value = true
}
const submitBasic = async () => {
  const res = await upsertLinkBasic(basic.value)
  if (res.code === 0) { ElMessage.success('保存成功'); drawerBasic.value = false }
}

const drawerCompany = ref(false)
const company = ref({ linkId: 0, companyName: '', icpRecordNo: '', licenseNo: '', homepageUrl: '', aboutUrl: '', logoPcUrl: '', logoMobileUrl: '' })
const openCompany = async (row) => {
  company.value = { linkId: row.ID, companyName: '', icpRecordNo: '', licenseNo: '', homepageUrl: '', aboutUrl: '', logoPcUrl: '', logoMobileUrl: '' }
  const res = await getLinkCompany({ linkId: row.ID })
  if (res.code === 0 && res.data && res.data.data) Object.assign(company.value, res.data.data)
  drawerCompany.value = true
}
const submitCompany = async () => {
  const res = await upsertLinkCompany(company.value)
  if (res.code === 0) { ElMessage.success('保存成功'); drawerCompany.value = false }
}

const drawerCode = ref(false)
const codeCfg = ref({ linkId: 0, statHeaderHtml: '', statFooterHtml: '', conversionScript: '', cssStyleText: '' })
const openCode = async (row) => {
  codeCfg.value = { linkId: row.ID, statHeaderHtml: '', statFooterHtml: '', conversionScript: '', cssStyleText: '' }
  const res = await getLinkCode({ linkId: row.ID })
  if (res.code === 0 && res.data && res.data.data) Object.assign(codeCfg.value, res.data.data)
  drawerCode.value = true
}
const submitCode = async () => {
  const res = await upsertLinkCode(codeCfg.value)
  if (res.code === 0) { ElMessage.success('保存成功'); drawerCode.value = false }
}

const drawerTheme = ref(false)
const theme = ref({ linkId: 0, colorWechatPhone: '', colorServiceName: '', colorCopyright: '', boldAll: false })
const openTheme = async (row) => {
  theme.value = { linkId: row.ID, colorWechatPhone: '', colorServiceName: '', colorCopyright: '', boldAll: false }
  const res = await getLinkTheme({ linkId: row.ID })
  if (res.code === 0 && res.data && res.data.data) Object.assign(theme.value, res.data.data)
  drawerTheme.value = true
}
const submitTheme = async () => {
  const res = await upsertLinkTheme(theme.value)
  if (res.code === 0) { ElMessage.success('保存成功'); drawerTheme.value = false }
}

const drawerComment = ref(false)
const comment = ref({ linkId: 0, enableComment: false, permission: 'mobile_login' })
const openComment = async (row) => {
  comment.value = { linkId: row.ID, enableComment: false, permission: 'mobile_login' }
  const res = await getLinkComment({ linkId: row.ID })
  if (res.code === 0 && res.data && res.data.data) Object.assign(comment.value, res.data.data)
  drawerComment.value = true
}
const submitComment = async () => {
  const res = await upsertLinkComment(comment.value)
  if (res.code === 0) { ElMessage.success('保存成功'); drawerComment.value = false }
}
</script>

<style scoped></style>
