<template>
  <div class="app-container">
    <div class="gva-search-box">
      <el-form :inline="true" :model="search">
        <el-form-item label="类型">
          <el-select v-model="search.type" clearable placeholder="选择类型" style="width: 180px">
            <el-option label="手机端模板" :value="1" />
            <el-option label="电脑端模板" :value="2" />
            <el-option label="手机复制插件" :value="3" />
            <el-option label="手机底部插件" :value="4" />
            <el-option label="电脑端二维码插件" :value="5" />
          </el-select>
        </el-form-item>
        <el-form-item label="状态">
          <el-select v-model="search.status" clearable placeholder="选择状态" style="width: 120px">
            <el-option label="启用" :value="1" />
            <el-option label="禁用" :value="0" />
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
        <el-table-column prop="name" label="名称" min-width="200" />
        <el-table-column label="类型" width="160">
          <template #default="{ row }">
            {{ typeMap[row.type] }}
          </template>
        </el-table-column>
        <el-table-column label="状态" width="100">
          <template #default="{ row }">
            <el-tag :type="row.status === 1 ? 'success' : 'danger'">
              {{ row.status === 1 ? '启用' : '禁用' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="createdAt" label="创建时间" width="180" />
        <el-table-column fixed="right" label="操作" width="200">
          <template #default="{ row }">
            <el-button type="primary" link @click="openForm(row)">编辑</el-button>
            <el-button type="danger" link @click="remove(row)">删除</el-button>
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
    <el-dialog v-model="drawer" title="模板插件编辑" width="800px" :close-on-click-modal="false">
      <el-form ref="formRef" :model="form" label-width="100px">
        <el-form-item label="名称" prop="name" :rules="[{ required: true, message: '请输入名称', trigger: 'blur' }]">
          <el-input v-model="form.name" placeholder="请输入名称" />
        </el-form-item>
        <el-form-item label="类型" prop="type" :rules="[{ required: true, message: '请选择类型', trigger: 'change' }]">
          <el-select v-model="form.type" placeholder="请选择类型">
            <el-option label="手机端模板" :value="1" />
            <el-option label="电脑端模板" :value="2" />
            <el-option label="手机复制插件" :value="3" />
            <el-option label="手机底部插件" :value="4" />
            <el-option label="电脑端二维码插件" :value="5" />
          </el-select>
        </el-form-item>
        <el-form-item label="状态" prop="status">
          <el-switch v-model="form.status" active-text="启用" inactive-text="禁用" />
        </el-form-item>
        <el-form-item label="内容" prop="content" :rules="[{ required: true, message: '请输入内容', trigger: 'blur' }]">
          <RichEdit v-model="form.content" :height="400" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="drawer = false">取消</el-button>
        <el-button type="primary" @click="submit">确定</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import RichEdit from '@/components/richtext/rich-edit.vue'
import {
  getTemplateWidgetList, createTemplateWidget, updateTemplateWidget, deleteTemplateWidget
} from '@/api/promotion'

const typeMap = {
  1: '手机端模板',
  2: '电脑端模板',
  3: '手机复制插件',
  4: '手机底部插件',
  5: '电脑端二维码插件'
}

const search = ref({ type: null, status: null })
const tableData = ref([])
const page = ref(1)
const pageSize = ref(10)
const total = ref(0)
const drawer = ref(false)
const formRef = ref()
const form = ref({
  ID: 0,
  name: '',
  type: null,
  content: '',
  status: 1
})

const getTableData = async () => {
  const params = {
    page: page.value,
    pageSize: pageSize.value
  }
  if (search.value.type) params.type = search.value.type
  const res = await getTemplateWidgetList(params)
  if (res.code === 0) {
    tableData.value = res.data.list
    total.value = res.data.total
    page.value = res.data.page
    pageSize.value = res.data.pageSize
  }
}

const onSubmit = () => {
  page.value = 1
  getTableData()
}

const onReset = () => {
  search.value = { type: null, status: null }
  onSubmit()
}

const handleSizeChange = (val) => {
  pageSize.value = val
  getTableData()
}

const handleCurrentChange = (val) => {
  page.value = val
  getTableData()
}

const openForm = (row) => {
  form.value = row ? { ...row } : {
    ID: 0,
    name: '',
    type: null,
    content: '',
    status: 1
  }
  drawer.value = true
}

const submit = async () => {
  await formRef.value.validate()
  let res
  if (form.value.ID) {
    res = await updateTemplateWidget(form.value)
  } else {
    res = await createTemplateWidget(form.value)
  }
  if (res.code === 0) {
    ElMessage.success('保存成功')
    drawer.value = false
    getTableData()
  }
}

const remove = async (row) => {
  await ElMessageBox.confirm('确认删除该记录？', '提示')
  const res = await deleteTemplateWidget({ ID: row.ID })
  if (res.code === 0) {
    ElMessage.success('删除成功')
    getTableData()
  }
}

onMounted(() => {
  getTableData()
})
</script>

<style scoped>
.app-container {
  padding: 20px;
}
</style>
