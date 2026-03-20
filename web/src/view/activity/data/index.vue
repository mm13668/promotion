<template>
  <div>
    <div class="gva-search-box">
      <div class="gva-btn-list">
        <el-button type="primary" icon="plus" @click="openForm()">新增</el-button>
        <el-button type="primary" icon="plus" @click="getTableData()">查询</el-button>
      </div>
    </div>
    <div class="gva-table-box">
      <el-table :data="tableData" row-key="ID" style="width:100%">
        <el-table-column prop="ID" label="ID" width="80" />
        <el-table-column prop="nameCn" label="中文名称" min-width="200" />
        <el-table-column prop="totalAmount" label="总金额" width="120" />
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
        <el-form-item label="市场ID">
          <el-input-number v-model="form.marketId" :min="0" />
        </el-form-item>
        <el-form-item label="套餐ID">
          <el-input-number v-model="form.packageId" :min="0" />
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
import { getActivityDataList, createActivityData, updateActivityData, deleteActivityData } from '@/api/promotion'
import { useAppStore } from '@/pinia/modules/app'
const appStore = useAppStore()

const tableData = ref([])
const page = ref(1)
const pageSize = ref(10)
const total = ref(0)
const getTableData = async () => {
  const res = await getActivityDataList({ page: page.value, pageSize: pageSize.value })
  if (res.code === 0) { tableData.value = res.data.list; total.value = res.data.total; page.value = res.data.page; pageSize.value = res.data.pageSize }
}
getTableData()
const handleSizeChange = (v) => { pageSize.value = v; getTableData() }
const handleCurrentChange = (v) => { page.value = v; getTableData() }

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

