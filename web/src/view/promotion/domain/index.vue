<template>
  <div>
    <div class="gva-search-box">
      <el-form :inline="true">
        <el-form-item>
          <el-button type="primary" icon="plus" @click="openForm()">新增</el-button>
          <el-button type="primary" icon="plus" @click="getTableData()">查询</el-button>
        </el-form-item>
      </el-form>
    </div>
    <div class="gva-table-box">
      <el-table :data="tableData" row-key="ID" style="width:100%">
        <el-table-column prop="ID" label="ID" width="80" />
        <el-table-column prop="domain" label="域名" min-width="220" />
        <el-table-column prop="cnameTarget" label="CNAME" min-width="260" show-overflow-tooltip />
        <el-table-column label="状态" width="120">
          <template #default="{ row }">
            {{ (statusOptions.find(o => o.value === row.status) || {}).label || row.status }}
          </template>
        </el-table-column>
        <el-table-column label="HTTPS" width="120">
          <template #default="{ row }">
            {{ (httpsOptions.find(o => o.value === row.httpsStatus) || {}).label || row.httpsStatus }}
          </template>
        </el-table-column>
        <el-table-column label="证书模式" width="120">
          <template #default="{ row }">
            {{ (certModeOptions.find(o => o.value === row.certMode) || {}).label || row.certMode }}
          </template>
        </el-table-column>
        <el-table-column prop="remark" label="备注" min-width="200" show-overflow-tooltip />
        <el-table-column fixed="right" label="操作" width="180">
          <template #default="{ row }">
            <el-button type="primary" link icon="edit" @click="openForm(row)">编辑</el-button>
            <el-button type="primary" link icon="delete" @click="remove(row)">删除</el-button>
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
        <el-form-item label="域名">
          <el-input v-model="form.domain" />
        </el-form-item>
        <el-form-item label="CNAME">
          <el-input v-model="form.cnameTarget" />
        </el-form-item>
        <el-form-item label="状态">
          <el-select v-model="form.status">
            <el-option v-for="o in statusOptions" :key="o.value" :label="o.label" :value="o.value" />
          </el-select>
        </el-form-item>
        <el-form-item label="HTTPS状态">
          <el-select v-model="form.httpsStatus">
            <el-option v-for="o in httpsOptions" :key="o.value" :label="o.label" :value="o.value" />
          </el-select>
        </el-form-item>
        <el-form-item label="证书模式">
          <el-select v-model="form.certMode">
            <el-option v-for="o in certModeOptions" :key="o.value" :label="o.label" :value="o.value" />
          </el-select>
        </el-form-item>
        <el-form-item label="备注">
          <el-input v-model="form.remark" type="textarea" />
        </el-form-item>
      </el-form>
    </el-drawer>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { getPromotionDomainList, createPromotionDomain, updatePromotionDomain, deletePromotionDomain } from '@/api/promotion'
import { useAppStore } from '@/pinia/modules/app'
const appStore = useAppStore()

const tableData = ref([])
const page = ref(1)
const pageSize = ref(10)
const total = ref(0)
const statusOptions = ref([
  { label: '启用', value: 1 },
  { label: '停用', value: 2 }
])
const httpsOptions = ref([
  { label: '未开启', value: 0 },
  { label: '已开启', value: 1 },
  { label: '申请中', value: 2 },
  { label: '失败', value: 3 }
])
const certModeOptions = ref([
  { label: '平台申请', value: 0 },
  { label: '自有证书', value: 1 },
  { label: '复用证书', value: 2 }
])

const getTableData = async () => {
  const res = await getPromotionDomainList({ page: page.value, pageSize: pageSize.value })
  if (res.code === 0) {
    tableData.value = res.data.list
    total.value = res.data.total
    page.value = res.data.page
    pageSize.value = res.data.pageSize
  }
}
getTableData()

const handleSizeChange = (val) => {
  pageSize.value = val
  getTableData()
}
const handleCurrentChange = (val) => {
  page.value = val
  getTableData()
}

const drawer = ref(false)
const form = ref({ ID: 0, domain: '', cnameTarget: '', status: 1, httpsStatus: 0, certMode: 0, remark: '' })
const openForm = (row) => {
  if (row) {
    form.value = { ...row }
  } else {
    form.value = { ID: 0, domain: '', cnameTarget: '', status: 1, httpsStatus: 0, certMode: 0, remark: '' }
  }
  drawer.value = true
}

const submit = async () => {
  if (!form.value.domain) {
    ElMessage.error('请输入域名')
    return
  }
  let res
  if (form.value.ID) {
    res = await updatePromotionDomain(form.value)
  } else {
    res = await createPromotionDomain(form.value)
  }
  if (res.code === 0) {
    ElMessage.success('保存成功')
    drawer.value = false
    getTableData()
  }
}

const remove = async (row) => {
  await ElMessageBox.confirm('确认删除该记录？', '提示')
  const res = await deletePromotionDomain({ ID: row.ID })
  if (res.code === 0) {
    ElMessage.success('删除成功')
    getTableData()
  }
}
</script>

<style scoped></style>
