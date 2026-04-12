<template>
  <div>
    <div class="gva-search-box">
      <el-form :inline="true" :model="search">
        <el-form-item label="推广链接">
          <el-select v-model="search.linkId" clearable filterable placeholder="选择推广链接" style="width: 200px">
            <el-option
              v-for="item in linkOptions"
              :key="item.ID"
              :label="`推广链接 #${item.ID} ： ${item.question?.title}`"
              :value="item.ID"
            />
          </el-select>
        </el-form-item>
        <el-form-item label="IP地址">
          <el-input v-model="search.ip" placeholder="请输入IP地址" clearable style="width: 180px" />
        </el-form-item>
        <el-form-item label="来源链接">
          <el-input v-model="search.referer" placeholder="请输入来源链接关键字" clearable style="width: 200px" />
        </el-form-item>
        <el-form-item label="请求来源">
          <el-input v-model="search.requestReferer" placeholder="请输入请求来源关键字" clearable style="width: 200px" />
        </el-form-item>
        <el-form-item label="是否复制">
          <el-select v-model="search.isCopied" clearable placeholder="是否复制" style="width: 120px">
            <el-option label="全部" :value="null" />
            <el-option label="已复制" :value="true" />
            <el-option label="未复制" :value="false" />
          </el-select>
        </el-form-item>
        <el-form-item label="创建时间">
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
        <el-button type="primary" icon="download" @click="exportExcel">导出</el-button>
      </div>
      <el-table
        :data="tableData"
        style="width: 100%"
        @selection-change="handleSelectionChange"
      >
        <el-table-column type="selection" width="55" />
        <el-table-column prop="ID" label="ID" width="80" />
        <el-table-column prop="linkId" label="推广链接ID" width="100" />
        <el-table-column prop="ip" label="IP地址" width="140" />
        <el-table-column prop="referer" label="来源链接" width="200" show-overflow-tooltip />
        <el-table-column prop="requestReferer" label="请求来源" width="200" show-overflow-tooltip />
        <el-table-column prop="userAgent" label="浏览器UA" width="200" show-overflow-tooltip />
        <el-table-column prop="requestUserAgent" label="请求UA" width="200" show-overflow-tooltip />
        <el-table-column prop="duration" label="浏览时长(秒)" width="120" />
        <el-table-column prop="isCopied" label="是否复制" width="100">
          <template #default="{ row }">
            <el-tag :type="row.isCopied ? 'success' : 'info'">
              {{ row.isCopied ? '已复制' : '未复制' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="copiedServicePhone" label="复制客服号码" width="120" />
        <el-table-column prop="copiedServiceNickname" label="复制客服昵称" width="120" />
        <el-table-column prop="deviceType" label="设备类型" width="100" />
        <el-table-column prop="os" label="操作系统" width="100" />
        <el-table-column prop="browser" label="浏览器" width="100" />
        <el-table-column prop="region" label="地区" width="120" />
        <el-table-column prop="lastReportAt" label="最后上报时间" width="160">
          <template #default="{ row }">
            {{ formatDateTime(row.lastReportAt) }}
          </template>
        </el-table-column>
        <el-table-column prop="CreatedAt" label="创建时间" width="160">
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
import { getLandingVisitList } from '@/api/promotion'
import { getPromotionLinkList } from '@/api/promotion'
import { ElMessage } from 'element-plus'

const tableData = ref([])
const page = ref(1)
const pageSize = ref(10)
const total = ref(0)
const linkOptions = ref([])

const search = reactive({
  linkId: null,
  ip: '',
  referer: '',
  requestReferer: '',
  isCopied: null,
  dates: []
})

// 获取推广链接列表
const loadLinkOptions = async () => {
  try {
    const res = await getPromotionLinkList({ page: 1, pageSize: 999 })
    if (res.code === 0) {
      linkOptions.value = res.data.list || []
    }
  } catch (error) {
    console.error('获取推广链接列表失败:', error)
  }
}

// 获取表格数据
const getTableData = async () => {
  const params = {
    page: page.value,
    pageSize: pageSize.value
  }

  // 添加筛选条件
  if (search.linkId) {
    params.linkId = search.linkId
  }
  if (search.ip) {
    params.ip = search.ip
  }
  if (search.referer) {
    params.referer = search.referer
  }
  if (search.requestReferer) {
    params.requestReferer = search.requestReferer
  }
  if (search.isCopied !== null) {
    params.isCopied = search.isCopied
  }
  if (search.dates && search.dates.length === 2) {
    const [s, e] = search.dates
    params.startTime = s ? formatDate(s) : undefined
    params.endTime = e ? formatDate(e) : undefined
  }

  try {
    const res = await getLandingVisitList(params)
    if (res.code === 0) {
      tableData.value = res.data.list || []
      total.value = res.data.total
      page.value = res.data.page
    }
  } catch (error) {
    console.error('获取数据失败:', error)
  }
}

// 查询
const onSubmit = () => {
  page.value = 1
  getTableData()
}

// 重置
const onReset = () => {
  search.linkId = null
  search.ip = ''
  search.referer = ''
  search.requestReferer = ''
  search.isCopied = null
  search.dates = []
  page.value = 1
  getTableData()
}

// 分页
const handleSizeChange = (val) => {
  pageSize.value = val
  getTableData()
}

const handleCurrentChange = (val) => {
  page.value = val
  getTableData()
}

// 导出
const exportExcel = () => {
  ElMessage.success('导出功能开发中...')
}

// 选择变化
const handleSelectionChange = (val) => {
  console.log('选择变化:', val)
}

// 格式化时间
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

// 格式化日期（本地时间）
const formatDate = (date) => {
  if (!date) return ''
  const d = new Date(date)
  const year = d.getFullYear()
  const month = String(d.getMonth() + 1).padStart(2, '0')
  const day = String(d.getDate()).padStart(2, '0')
  return `${year}-${month}-${day}`
}

// 页面加载时获取数据
onMounted(() => {
  loadLinkOptions()
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
