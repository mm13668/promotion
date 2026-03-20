<template>
  <div>
    <div class="gva-search-box">
      <el-form :inline="true" :model="search">
        <el-form-item label="标题">
          <el-input v-model="search.title" placeholder="搜索标题" clearable />
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
        <el-table-column prop="code" label="编号" width="140" />
        <el-table-column prop="title" label="标题" min-width="200" show-overflow-tooltip />
        <el-table-column prop="platformKey" label="平台" width="140" />
        <el-table-column prop="status" label="状态" width="100" />
        <el-table-column prop="sort" label="排序" width="100" />
        <el-table-column fixed="right" label="操作" width="480">
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
        <el-form-item label="编号">
          <el-input v-model="form.code" />
        </el-form-item>
        <el-form-item label="标题">
          <el-input v-model="form.title" />
        </el-form-item>
        <el-form-item label="平台">
          <el-input v-model="form.platformKey" />
        </el-form-item>
        <el-form-item label="域名ID">
          <el-input-number v-model="form.domainId" :min="0" />
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
    <el-drawer v-model="drawerBasic" :show-close="false">
      <template #header>
        <div class="flex justify-between items-center">
          <span class="text-lg">基本设置</span>
          <div>
            <el-button @click="drawerBasic=false">取消</el-button>
            <el-button type="primary" @click="submitBasic">保存</el-button>
          </div>
        </div>
      </template>
      <el-form label-position="top" :model="basic">
        <el-form-item label="手机模板">
          <el-input v-model="basic.templateMobileKey" />
        </el-form-item>
        <el-form-item label="电脑模板">
          <el-input v-model="basic.templatePcKey" />
        </el-form-item>
        <el-form-item label="显示最近120秒访客">
          <el-switch v-model="basic.showRecent120s" />
        </el-form-item>
        <el-form-item label="移动端第二屏">
          <el-switch v-model="basic.mobileSecondScreen" />
        </el-form-item>
        <el-form-item label="PC第二屏">
          <el-switch v-model="basic.pcSecondScreen" />
        </el-form-item>
        <el-form-item label="移动端底部条">
          <el-switch v-model="basic.mobileBottomBar" />
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
import { ElMessage, ElMessageBox } from 'element-plus'
import {
  getPromotionLinkList, createPromotionLink, updatePromotionLink, deletePromotionLink,
  getLinkBasic, upsertLinkBasic,
  getLinkCompany, upsertLinkCompany,
  getLinkCode, upsertLinkCode,
  getLinkTheme, upsertLinkTheme,
  getLinkComment, upsertLinkComment
} from '@/api/promotion'
import { useAppStore } from '@/pinia/modules/app'
const appStore = useAppStore()

const search = ref({ title: '' })
const tableData = ref([])
const page = ref(1)
const pageSize = ref(10)
const total = ref(0)
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
const onSubmit = () => getTableData()
const onReset = () => { search.value = { title: '' }; getTableData() }
const handleSizeChange = (val) => { pageSize.value = val; getTableData() }
const handleCurrentChange = (val) => { page.value = val; getTableData() }

const drawer = ref(false)
const form = ref({ ID: 0, code: '', title: '', platformKey: '', domainId: null, status: 1, sort: 0, remark: '' })
const openForm = (row) => {
  form.value = row ? { ...row } : { ID: 0, code: '', title: '', platformKey: '', domainId: null, status: 1, sort: 0, remark: '' }
  drawer.value = true
}
const submit = async () => {
  if (!form.value.code || !form.value.title) { ElMessage.error('编号与标题必填'); return }
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
const basic = ref({ linkId: 0, templateMobileKey: '', templatePcKey: '', showRecent120s: false, mobileSecondScreen: false, pcSecondScreen: false, mobileBottomBar: false })
const openBasic = async (row) => {
  basic.value = { linkId: row.ID, templateMobileKey: '', templatePcKey: '', showRecent120s: false, mobileSecondScreen: false, pcSecondScreen: false, mobileBottomBar: false }
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
