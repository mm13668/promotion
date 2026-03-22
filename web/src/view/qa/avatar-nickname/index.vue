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
        <el-table-column label="头像" width="100">
          <template #default="{ row }">
            <img v-if="row.avatarUrl" :src="`${getBaseUrl()}/${row.avatarUrl}`" class="h-10 w-10 object-contain border rounded" />
          </template>
        </el-table-column>
        <el-table-column prop="nickname" label="昵称" min-width="150" />
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
    <el-drawer v-model="drawer" size="500" :show-close="false">
      <template #header>
        <div class="flex justify-between items-center">
          <span class="text-lg">{{ form.ID ? '编辑' : '新增' }}头像昵称</span>
          <div>
            <el-button @click="drawer=false">取消</el-button>
            <el-button type="primary" @click="submit">确定</el-button>
          </div>
        </div>
      </template>
      <el-form label-position="top" :model="form">
        <el-form-item label="头像">
          <div class="flex items-center space-x-4">
            <UploadImage v-model="form.avatarUrl" @on-success="handleAvatarSuccess"/>
            <img v-if="form.avatarUrl" :src="`${getBaseUrl()}/${form.avatarUrl}`" class="h-16 w-16 object-contain border rounded" />
          </div>
        </el-form-item>
        <el-form-item label="昵称">
          <el-input v-model="form.nickname" placeholder="请输入昵称" />
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
import UploadImage from "@/components/upload/image.vue";
import {
  createQAAvatarNickname,
  updateQAAvatarNickname,
  deleteQAAvatarNickname,
  getQAAvatarNicknameList
} from '@/api/promotion'
import { getBaseUrl } from "@/utils/format.js";

const tableData = ref([])
const page = ref(1)
const pageSize = ref(10)
const total = ref(0)
const search = ref({})

const getTableData = async () => {
  let params = { page: page.value, pageSize: pageSize.value }
  const res = await getQAAvatarNicknameList(params)
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
const form = ref({ ID: 0, avatarUrl: '', nickname: '', sort: 0, status: 1 })
const openForm = (row) => { 
  form.value = row ? { ...row } : { ID: 0, avatarUrl: '', nickname: '', sort: 0, status: 1 }; 
  drawer.value = true 
}
const submit = async () => {
  if (!form.value.nickname) { ElMessage.error('请输入昵称'); return }
  if (!form.value.avatarUrl) { ElMessage.error('请上传头像'); return }
  let res = form.value.ID ? await updateQAAvatarNickname(form.value) : await createQAAvatarNickname(form.value)
  if (res.code === 0) { ElMessage.success('保存成功'); drawer.value = false; getTableData() }
}
const remove = async (row) => {
  await ElMessageBox.confirm('确认删除该记录？', '提示')
  const res = await deleteQAAvatarNickname({ ID: row.ID })
  if (res.code === 0) { ElMessage.success('删除成功'); getTableData() }
}

const handleAvatarSuccess = (url) => {
  form.value.avatarUrl = url
}
</script>
