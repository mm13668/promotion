<template>
  <div>
    <div class="gva-search-box">
      <el-form :inline="true" :model="search">
        <el-form-item label="市场">
          <el-select v-model="search.marketId" clearable filterable placeholder="选择市场" style="width: 180px">
            <el-option v-for="m in marketOptions" :key="m.ID" :label="m.nameCn" :value="m.ID" />
          </el-select>
        </el-form-item>
        <el-form-item label="套餐">
          <el-select v-model="search.packageId" clearable filterable placeholder="选择套餐" style="width: 180px">
            <el-option v-for="p in packageOptions" :key="p.ID" :label="p.name" :value="p.ID" />
          </el-select>
        </el-form-item>
        <el-form-item label="关键字">
          <el-input v-model="search.keyword" placeholder="中文/英文名" clearable style="width: 200px" />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" icon="search" @click="onSubmit">查询</el-button>
          <el-button icon="refresh" @click="onReset">重置</el-button>
          <el-button type="primary" icon="plus" @click="openForm()">新增</el-button>
        </el-form-item>
      </el-form>
    </div>
    <div class="gva-table-box">
      <el-table :data="tableData" row-key="ID" style="width:100%">
        <el-table-column prop="ID" label="ID" width="80" />
        <el-table-column prop="nameCn" label="中文名称" min-width="200" />
        <el-table-column prop="totalAmount" label="总金额" width="120" />
        <el-table-column label="市场" min-width="160">
          <template #default="{ row }">
            {{ (marketOptions.find(m => m.ID === row.marketId) || {}).nameCn || row.marketId }}
          </template>
        </el-table-column>
        <el-table-column label="套餐" min-width="160">
          <template #default="{ row }">
            {{ (packageOptions.find(p => p.ID === row.packageId) || {}).name || row.packageId }}
          </template>
        </el-table-column>
        <el-table-column prop="status" label="状态" width="100" />
        <el-table-column fixed="right" label="操作" width="180">
          <template #default="{ row }">
            <el-button type="primary" link @click="openForm(row)">编辑</el-button>
            <el-button type="primary" link @click="remove(row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
      <el-pagination class="mt-4" background layout="total, sizes, prev, pager, next, jumper"
        :current-page="page" :page-size="pageSize" :total="total"
        @size-change="handleSizeChange" @current-change="handleCurrentChange" />
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
        <el-form-item label="中文名称">
          <el-input v-model="form.nameCn" />
        </el-form-item>
        <el-form-item label="英文名称">
          <el-input v-model="form.nameEn" />
        </el-form-item>
        <el-form-item label="市场">
          <el-select v-model="form.marketId" filterable clearable placeholder="选择市场">
            <el-option v-for="m in marketOptions" :key="m.ID" :label="m.nameCn" :value="m.ID" />
          </el-select>
        </el-form-item>
        <el-form-item label="套餐">
          <el-select v-model="form.packageId" filterable clearable placeholder="选择套餐">
            <el-option v-for="p in packageOptions" :key="p.ID" :label="p.name" :value="p.ID" />
          </el-select>
        </el-form-item>
        <el-form-item label="总金额">
          <el-input-number v-model="form.totalAmount" :min="0" />
        </el-form-item>
        <el-form-item label="图片链接">
          <el-input v-model="form.imageUrl" />
        </el-form-item>
        <el-form-item label="状态">
          <el-input-number v-model="form.status" />
        </el-form-item>
      </el-form>
    </el-drawer>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { getActivityDataList, createActivityData, updateActivityData, deleteActivityData, getActivityMarketList, getActivityPackageList } from '@/api/promotion'
import { useAppStore } from '@/pinia/modules/app'
const appStore = useAppStore()

const tableData = ref([])
const page = ref(1)
const pageSize = ref(10)
const total = ref(0)
const marketOptions = ref([])
const packageOptions = ref([])
const search = ref({ marketId: null, packageId: null, keyword: '' })
const getTableData = async (params = {}) => {
  const res = await getActivityDataList({ page: page.value, pageSize: pageSize.value, ...params })
  if (res.code === 0) { tableData.value = res.data.list; total.value = res.data.total; page.value = res.data.page; pageSize.value = res.data.pageSize }
}
getTableData()
const onSubmit = async () => {
  const params = {}
  if (search.value.marketId) params.marketId = search.value.marketId
  if (search.value.packageId) params.packageId = search.value.packageId
  if (search.value.keyword) params.keyword = search.value.keyword
  await getTableData(params)
}
const onReset = async () => {
  search.value = { marketId: null, packageId: null, keyword: '' }
  await onSubmit()
}
const loadOptions = async () => {
  const [mRes, pRes] = await Promise.all([
    getActivityMarketList({ page: 1, pageSize: 10000 }),
    getActivityPackageList({ page: 1, pageSize: 10000 })
  ])
  if (mRes.code === 0) marketOptions.value = mRes.data.list || []
  if (pRes.code === 0) packageOptions.value = pRes.data.list || []
}
loadOptions()
const handleSizeChange = async (v) => { pageSize.value = v; await onSubmit() }
const handleCurrentChange = async (v) => { page.value = v; await onSubmit() }

const drawer = ref(false)
const form = ref({ ID: 0, nameCn: '', nameEn: '', marketId: null, packageId: null, totalAmount: 0, imageUrl: '', status: 1 })
const openForm = (row) => { form.value = row ? { ...row } : { ID: 0, nameCn: '', nameEn: '', marketId: null, packageId: null, totalAmount: 0, imageUrl: '', status: 1 }; drawer.value = true }
const submit = async () => {
  if (!form.value.nameCn) { ElMessage.error('请输入中文名称'); return }
  let res = form.value.ID ? await updateActivityData(form.value) : await createActivityData(form.value)
  if (res.code === 0) { ElMessage.success('保存成功'); drawer.value = false; getTableData() }
}
const remove = async (row) => {
  await ElMessageBox.confirm('确认删除该记录？', '提示')
  const res = await deleteActivityData({ ID: row.ID })
  if (res.code === 0) { ElMessage.success('删除成功'); getTableData() }
}
</script>

<style scoped></style>
