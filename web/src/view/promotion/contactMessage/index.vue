<template>
  <div>
    <div class="gva-search-box">
      <el-form :inline="true" :model="search">
        <el-form-item label="手机号">
          <el-input v-model="search.phone" placeholder="请输入手机号" clearable style="width: 180px" />
        </el-form-item>
        <el-form-item label="是否处理">
          <el-select v-model="search.isProcessed" clearable placeholder="是否处理" style="width: 120px">
            <el-option label="全部" :value="null" />
            <el-option label="已处理" :value="true" />
            <el-option label="未处理" :value="false" />
          </el-select>
        </el-form-item>
        <el-form-item label="留言时间">
          <el-date-picker
            v-model="search.dates"
            type="daterange"
            range-separator="至"
            start-placeholder="开始日期"
            end-placeholder="结束日期"
            style="width: 280px"
          />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" icon="search" @click="onSubmit">查询</el-button>
          <el-button icon="refresh" @click="onReset">重置</el-button>
        </el-form-item>
      </el-form>
    </div>
    <div class="gva-table-box">
      <div class="gva-btn-list">
        <el-button type="primary" icon="check" :disabled="selectedIDs.length === 0" @click="batchMarkProcessed">标记已处理</el-button>
      </div>
      <el-table
        :data="tableData"
        style="width: 100%"
        @selection-change="handleSelectionChange"
      >
        <el-table-column type="selection" width="55" />
        <el-table-column prop="ID" label="ID" width="80" />
        <el-table-column prop="phone" label="手机号" width="140" />
        <el-table-column prop="message" label="留言信息" min-width="300" show-overflow-tooltip />
        <el-table-column prop="isProcessed" label="是否处理" width="100">
          <template #default="{ row }">
            <el-switch
              :model-value="row.isProcessed"
              active-text="已处理"
              inactive-text="未处理"
              @change="(val) => handleProcessedChange(row, val)"
            />
          </template>
        </el-table-column>
        <el-table-column prop="messageTime" label="留言时间" width="180">
          <template #default="{ row }">
            {{ formatDateTime(row.messageTime) }}
          </template>
        </el-table-column>
        <el-table-column prop="CreatedAt" label="创建时间" width="180">
          <template #default="{ row }">
            {{ formatDateTime(row.CreatedAt) }}
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
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { getContactMessageList, updateContactMessageProcessed } from '@/api/promotion'
import { ElMessage, ElMessageBox } from 'element-plus'

const tableData = ref([])
const page = ref(1)
const pageSize = ref(10)
const total = ref(0)
const selectedIDs = ref([])

const search = reactive({
  phone: '',
  isProcessed: null,
  dates: []
})

const getTableData = async () => {
  const params = {
    page: page.value,
    pageSize: pageSize.value
  }
  if (search.phone) {
    params.phone = search.phone
  }
  if (search.isProcessed !== null) {
    params.isProcessed = search.isProcessed
  }
  if (search.dates && search.dates.length === 2) {
    const [s, e] = search.dates
    params.startTime = s ? formatDate(s) : undefined
    params.endTime = e ? formatDate(e) : undefined
  }
  try {
    const res = await getContactMessageList(params)
    if (res.code === 0) {
      tableData.value = res.data.list || []
      total.value = res.data.total
      page.value = res.data.page
    }
  } catch (error) {
    console.error('获取数据失败:', error)
  }
}

const onSubmit = () => {
  page.value = 1
  getTableData()
}

const onReset = () => {
  search.phone = ''
  search.isProcessed = null
  search.dates = []
  page.value = 1
  getTableData()
}

const handleSizeChange = (val) => {
  pageSize.value = val
  getTableData()
}

const handleCurrentChange = (val) => {
  page.value = val
  getTableData()
}

const handleSelectionChange = (val) => {
  selectedIDs.value = val.map(item => item.ID)
}

const handleProcessedChange = async (row, val) => {
  try {
    const res = await updateContactMessageProcessed({ id: row.ID, isProcessed: val })
    if (res.code === 0) {
      ElMessage.success(val ? '已标记为已处理' : '已标记为未处理')
      row.isProcessed = val
    }
  } catch (error) {
    console.error('更新失败:', error)
  }
}

const batchMarkProcessed = async () => {
  if (selectedIDs.value.length === 0) {
    ElMessage.warning('请选择留言')
    return
  }
  try {
    await ElMessageBox.confirm(`确认将选中的 ${selectedIDs.value.length} 条留言标记为已处理？`, '确认', {
      confirmButtonText: '确认',
      cancelButtonText: '取消',
      type: 'warning'
    })
    const promises = selectedIDs.value.map(id =>
      updateContactMessageProcessed({ id, isProcessed: true })
    )
    await Promise.all(promises)
    ElMessage.success('批量处理成功')
    getTableData()
  } catch (e) {
    if (e !== 'cancel') {
      console.error('批量处理失败:', e)
    }
  }
}

const formatDateTime = (dateTime) => {
  if (!dateTime) return '-'
  const date = new Date(dateTime)
  const year = date.getFullYear()
  const month = String(date.getMonth() + 1).padStart(2, '0')
  const day = String(date.getDate()).padStart(2, '0')
  const hours = String(date.getHours()).padStart(2, '0')
  const minutes = String(date.getMinutes()).padStart(2, '0')
  const seconds = String(date.getSeconds()).padStart(2, '0')
  return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`
}

const formatDate = (date) => {
  if (!date) return ''
  const d = new Date(date)
  const year = d.getFullYear()
  const month = String(d.getMonth() + 1).padStart(2, '0')
  const day = String(d.getDate()).padStart(2, '0')
  return `${year}-${month}-${day}`
}

onMounted(() => {
  getTableData()
})
</script>

<style scoped>
.gva-search-box {
  margin-bottom: 20px;
}
.gva-table-box {
  margin-top: 20px;
}
.gva-btn-list {
  margin-bottom: 10px;
}
</style>
