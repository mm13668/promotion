<template>
  <div>
    <div class="gva-search-box">
      <el-form :inline="true" :model="search">
        <el-form-item>
          <el-button type="primary" icon="plus" @click="openForm()">新增</el-button>
        </el-form-item>
      </el-form>
    </div>
    <div class="gva-table-box">
      <el-table :data="tableData" row-key="ID" style="width:100%">
        <el-table-column prop="ID" label="ID" width="80" />
        <el-table-column prop="content" label="个性签名内容" min-width="300" show-overflow-tooltip />
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
            <el-button type="primary" link @click="openForm(row)">编辑</el-button>
            <el-button type="primary" link @click="remove(row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
      <el-pagination class="mt-4" background layout="total, sizes, prev, pager, next, jumper"
        :current-page="page" :page-size="pageSize" :total="total"
        @size-change="handleSizeChange" @current-change="handleCurrentChange" />
    </div>

    <!-- 编辑抽屉 -->
    <el-drawer v-model="drawer" size="600" :show-close="false">
      <template #header>
        <div class="flex justify-between items-center">
          <span class="text-lg">{{ form.ID ? '编辑' : '新增' }}个性签名</span>
          <div>
            <el-button @click="drawer=false">取消</el-button>
            <el-button type="primary" @click="submit">确定</el-button>
          </div>
        </div>
      </template>
      <el-form label-position="top" :model="form">
        <el-form-item label="个性签名内容">
          <el-input v-model="form.content" type="textarea" :rows="3" placeholder="请输入个性签名内容" />
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
  createQASignature,
  updateQASignature,
  deleteQASignature,
  getQASignatureList
} from '@/api/promotion'

const tableData = ref([])
const page = ref(1)
const pageSize = ref(10)
const total = ref(0)
const search = ref({})

const getTableData = async () => {
  let params = { page: page.value, pageSize: pageSize.value }
  const res = await getQASignatureList(params)
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
const form = ref({ ID: 0, content: '', sort: 0, status: 1 })
const openForm = (row) => { 
  form.value = row ? { ...row } : { ID: 0, content: '', sort: 0, status: 1 }; 
  drawer.value = true 
}
const submit = async () => {
  if (!form.value.content) { ElMessage.error('请输入个性签名内容'); return }
  let res = form.value.ID ? await updateQASignature(form.value) : await createQASignature(form.value)
  if (res.code === 0) { ElMessage.success('保存成功'); drawer.value = false; getTableData() }
}
const remove = async (row) => {
  await ElMessageBox.confirm('确认删除该记录？', '提示')
  const res = await deleteQASignature({ ID: row.ID })
  if (res.code === 0) { ElMessage.success('删除成功'); getTableData() }
}
</script>
