<template>
  <div>
    <div class="gva-search-box">
      <el-form :inline="true" :model="search">
        <el-form-item label="标签名称">
          <el-input v-model="search.name" clearable placeholder="标签名称模糊搜索" style="width: 200px" />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" icon="plus" @click="openForm()">新增</el-button>
          <el-button type="primary" icon="search" @click="getTableData()">查询</el-button>
        </el-form-item>
      </el-form>
    </div>
    <div class="gva-table-box">
      <el-table :data="tableData" row-key="ID" style="width:100%">
        <el-table-column prop="ID" label="ID" width="80" />
        <el-table-column prop="name" label="标签名称" min-width="200" />
        <el-table-column prop="sort" label="排序" width="100" />
        <el-table-column prop="status" label="状态" width="100">
          <template #default="{ row }">
            <el-tag :type="row.status === 1 ? 'success' : 'warning'">
              {{ row.status === 1 ? '启用' : '禁用' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column fixed="right" label="操作" width="200">
          <template #default="{ row }">
            <el-button type="primary" link :disabled="isSuperAdmin(row)" @click="openForm(row)">编辑</el-button>
            <el-button type="primary" link :disabled="isSuperAdmin(row)" @click="remove(row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
      <el-pagination class="mt-4" background layout="total, sizes, prev, pager, next, jumper"
        :current-page="page" :page-size="pageSize" :total="total"
        @size-change="handleSizeChange" @current-change="handleCurrentChange" />
    </div>

    <!-- 编辑抽屉 -->
    <el-drawer v-model="drawer" size="500" :show-close="false">
      <template #header>
        <div class="flex justify-between items-center">
          <span class="text-lg">{{ form.ID ? '编辑' : '新增' }}标签</span>
          <div>
            <el-button @click="drawer=false">取消</el-button>
            <el-button type="primary" @click="submit">确定</el-button>
          </div>
        </div>
      </template>
      <el-form label-position="top" :model="form">
        <el-form-item label="标签名称">
          <el-input v-model="form.name" placeholder="请输入标签名称" />
        </el-form-item>
        <el-form-item label="排序">
          <el-input-number v-model="form.sort" />
        </el-form-item>
        <el-form-item label="状态">
          <el-radio-group v-model="form.status">
            <el-radio :label="1">启用</el-radio>
            <el-radio :label="0">禁用</el-radio>
          </el-radio-group>
        </el-form-item>
      </el-form>
    </el-drawer>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import {
  createQATag,
  updateQATag,
  deleteQATag,
  getQATagList
} from '@/api/promotion'

const SUPER_ADMIN_UUID = '4f53b2a2-e6cd-40df-b3f9-50f0ef9a297b'
const isSuperAdmin = (row) => row.uuid === SUPER_ADMIN_UUID

const tableData = ref([])
const page = ref(1)
const pageSize = ref(10)
const total = ref(0)
const search = ref({ name: '' })

const getTableData = async () => {
  let params = { page: page.value, pageSize: pageSize.value }
  if (search.value.name) params.name = search.value.name
  const res = await getQATagList(params)
  if (res.code === 0) { 
    tableData.value = res.data.list; 
    total.value = res.data.total; 
    page.value = res.data.page; 
    pageSize.value = res.data.pageSize 
  }
}
getTableData()

const handleSizeChange = (v) => { pageSize.value = v; getTableData() }
const handleCurrentChange = (v) => { page.value = v; getTableData() }

const drawer = ref(false)
const form = ref({ ID: 0, name: '', sort: 0, status: 1 })
const openForm = (row) => { 
  form.value = row ? { ...row } : { ID: 0, name: '', sort: 0, status: 1 }; 
  drawer.value = true 
}
const submit = async () => {
  if (!form.value.name) { ElMessage.error('请输入标签名称'); return }
  let res = form.value.ID ? await updateQATag(form.value) : await createQATag(form.value)
  if (res.code === 0) { ElMessage.success('保存成功'); drawer.value = false; getTableData() }
}
const remove = async (row) => {
  await ElMessageBox.confirm('确认删除该记录？', '提示')
  const res = await deleteQATag({ ID: row.ID })
  if (res.code === 0) { ElMessage.success('删除成功'); getTableData() }
}
</script>
