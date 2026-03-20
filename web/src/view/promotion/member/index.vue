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
        <el-table-column prop="nickname" label="昵称" min-width="160" />
        <el-table-column prop="realName" label="姓名" min-width="120" />
        <el-table-column prop="regionId" label="地区ID" width="100" />
        <el-table-column prop="groupId" label="分组ID" width="100" />
        <el-table-column prop="mobile" label="手机号" width="140" />
        <el-table-column prop="wechat" label="微信" width="160" />
        <el-table-column prop="gender" label="性别" width="100" />
        <el-table-column prop="sort" label="排序" width="100" />
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
        <el-form-item label="昵称">
          <el-input v-model="form.nickname" />
        </el-form-item>
        <el-form-item label="姓名">
          <el-input v-model="form.realName" />
        </el-form-item>
        <el-form-item label="地区ID">
          <el-input-number v-model="form.regionId" :min="1" />
        </el-form-item>
        <el-form-item label="分组ID">
          <el-input-number v-model="form.groupId" :min="1" />
        </el-form-item>
        <el-form-item label="手机号">
          <el-input v-model="form.mobile" />
        </el-form-item>
        <el-form-item label="微信">
          <el-input v-model="form.wechat" />
        </el-form-item>
        <el-form-item label="性别">
          <el-select v-model="form.gender">
            <el-option label="未知" value="未知" />
            <el-option label="男" value="男" />
            <el-option label="女" value="女" />
          </el-select>
        </el-form-item>
        <el-form-item label="排序">
          <el-input-number v-model="form.sort" />
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
import { getGroupMemberList, createGroupMember, updateGroupMember, deleteGroupMember } from '@/api/promotion'
import { useAppStore } from '@/pinia/modules/app'
const appStore = useAppStore()

const tableData = ref([])
const page = ref(1)
const pageSize = ref(10)
const total = ref(0)

const getTableData = async () => {
  const res = await getGroupMemberList({ page: page.value, pageSize: pageSize.value })
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
const form = ref({ ID: 0, nickname: '', realName: '', regionId: 0, groupId: 0, mobile: '', wechat: '', gender: '未知', sort: 0, remark: '' })
const openForm = (row) => {
  if (row) {
    form.value = { ...row }
  } else {
    form.value = { ID: 0, nickname: '', realName: '', regionId: 0, groupId: 0, mobile: '', wechat: '', gender: '未知', sort: 0, remark: '' }
  }
  drawer.value = true
}

const submit = async () => {
  if (!form.value.nickname || !form.value.regionId || !form.value.groupId) {
    ElMessage.error('请填写必填项')
    return
  }
  let res
  if (form.value.ID) {
    res = await updateGroupMember(form.value)
  } else {
    res = await createGroupMember(form.value)
  }
  if (res.code === 0) {
    ElMessage.success('保存成功')
    drawer.value = false
    getTableData()
  }
}

const remove = async (row) => {
  await ElMessageBox.confirm('确认删除该记录？', '提示')
  const res = await deleteGroupMember({ ID: row.ID })
  if (res.code === 0) {
    ElMessage.success('删除成功')
    getTableData()
  }
}
</script>

<style scoped></style>

