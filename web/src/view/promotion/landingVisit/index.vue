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
        <el-form-item label="地区">
          <el-input v-model="search.region" placeholder="请输入地区关键字" clearable style="width: 180px" />
        </el-form-item>
        <el-form-item label="是否复制">
          <el-select v-model="search.isCopied" clearable placeholder="是否复制" style="width: 120px">
            <el-option label="全部" :value="null" />
            <el-option label="已复制" :value="true" />
            <el-option label="未复制" :value="false" />
          </el-select>
        </el-form-item>
        <el-form-item label="复制时间">
          <el-date-picker
            v-model="search.copiedAtDates"
            type="daterange"
            range-separator="至"
            start-placeholder="开始日期"
            end-placeholder="结束日期"
            style="width: 280px"
          />
        </el-form-item>
        <el-form-item label="是否点击获客助手">
          <el-select v-model="search.isClickedAssist" clearable placeholder="是否点击" style="width: 120px">
            <el-option label="全部" :value="null" />
            <el-option label="已点击" :value="true" />
            <el-option label="未点击" :value="false" />
          </el-select>
        </el-form-item>
        <el-form-item label="点击获客助手时间">
          <el-date-picker
            v-model="search.clickedAssistAtDates"
            type="daterange"
            range-separator="至"
            start-placeholder="开始日期"
            end-placeholder="结束日期"
            style="width: 280px"
          />
        </el-form-item>
        <el-form-item label="是否回传">
          <el-select v-model="search.isOcpcCallback" clearable placeholder="是否回传" style="width: 120px">
            <el-option label="全部" :value="null" />
            <el-option label="已回传" :value="true" />
            <el-option label="未回传" :value="false" />
          </el-select>
        </el-form-item>
        <el-form-item label="回传时间">
          <el-date-picker
            v-model="search.ocpcCallbackAtDates"
            type="daterange"
            range-separator="至"
            start-placeholder="开始日期"
            end-placeholder="结束日期"
            style="width: 280px"
          />
        </el-form-item>
        <el-form-item label="域名">
          <el-select v-model="search.domainId" clearable filterable placeholder="选择域名" style="width: 200px">
            <el-option
              v-for="item in domainOptions"
              :key="item.ID"
              :label="item.domain"
              :value="item.ID"
            />
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
        <el-popover placement="bottom" :width="220" trigger="click">
          <template #reference>
            <el-button icon="setting">展示字段</el-button>
          </template>
          <el-checkbox-group v-model="visibleColumns" class="flex flex-col gap-1">
            <el-checkbox v-for="col in allColumns" :key="col.key" :label="col.key" class="ml-1">
              {{ col.label }}
            </el-checkbox>
          </el-checkbox-group>
        </el-popover>
        <span class="ml-4 text-gray-400 text-xs">数据仅保留最近3天</span>
      </div>
      <el-table
        :data="tableData"
        style="width: 100%"
        @selection-change="handleSelectionChange"
      >
        <el-table-column type="selection" width="55" v-if="visibleColumns.length" />
        <el-table-column prop="ID" label="ID" width="80" v-if="visibleColumns.includes('ID')" />
        <el-table-column prop="linkId" label="推广链接ID" width="100" v-if="visibleColumns.includes('linkId')" />
        <el-table-column prop="categoryName" label="所属分类" width="120" v-if="visibleColumns.includes('categoryName')" />
        <el-table-column prop="domainName" label="域名" width="180" v-if="visibleColumns.includes('domainName')" />
        <el-table-column prop="ip" label="IP地址" width="140" v-if="visibleColumns.includes('ip')" />
        <el-table-column prop="region" label="地区" width="120" v-if="visibleColumns.includes('region')" />
        <el-table-column label="关键词" width="180" show-overflow-tooltip v-if="visibleColumns.includes('keyword')">
          <template #default="{ row }">
            {{ extractKeyword(row.requestReferer, row.referer) }}
          </template>
        </el-table-column>
        <el-table-column prop="referer" label="来源链接" width="200" show-overflow-tooltip v-if="visibleColumns.includes('referer')" />
        <el-table-column prop="requestReferer" label="访问链接" width="200" show-overflow-tooltip v-if="visibleColumns.includes('requestReferer')" />
        <el-table-column prop="duration" label="浏览时长(秒)" width="120" v-if="visibleColumns.includes('duration')" />
        <el-table-column prop="isCopied" label="是否复制" width="100" v-if="visibleColumns.includes('isCopied')">
          <template #default="{ row }">
            <el-tag :type="row.isCopied ? 'success' : 'info'">
              {{ row.isCopied ? '已复制' : '未复制' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="copiedAt" label="复制时间" width="170" v-if="visibleColumns.includes('copiedAt')">
          <template #default="{ row }">
            {{ formatDateTime(row.copiedAt) }}
          </template>
        </el-table-column>
        <el-table-column prop="isClickedAssist" label="是否点击获客助手" width="140" v-if="visibleColumns.includes('isClickedAssist')">
          <template #default="{ row }">
            <el-tag :type="row.isClickedAssist ? 'success' : 'info'">
              {{ row.isClickedAssist ? '已点击' : '未点击' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="clickedAssistAt" label="点击获客助手时间" width="170" v-if="visibleColumns.includes('clickedAssistAt')">
          <template #default="{ row }">
            {{ formatDateTime(row.clickedAssistAt) }}
          </template>
        </el-table-column>
        <el-table-column prop="isOcpcCallback" label="是否回传" width="100" v-if="visibleColumns.includes('isOcpcCallback')">
          <template #default="{ row }">
            <el-tag :type="row.isOcpcCallback ? 'success' : 'warning'" style="cursor: pointer" @click="handleManualCallback(row)">
              {{ row.isOcpcCallback ? '已回传' : '未回传' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="ocpcCallbackAt" label="回传时间" width="170" v-if="visibleColumns.includes('ocpcCallbackAt')">
          <template #default="{ row }">
            {{ formatDateTime(row.ocpcCallbackAt) }}
          </template>
        </el-table-column>
        <el-table-column prop="copiedServicePhone" label="复制客服号码" width="120" v-if="visibleColumns.includes('copiedServicePhone')" />
        <el-table-column prop="copiedServiceNickname" label="复制客服昵称" width="120" v-if="visibleColumns.includes('copiedServiceNickname')" />
        <el-table-column prop="CreatedAt" label="创建时间" width="180" v-if="visibleColumns.includes('CreatedAt')">
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
import { ref, reactive, watch, onMounted } from 'vue'
import { getLandingVisitList, reportManualOcpcCallback, getPromotionDomainList } from '@/api/promotion'
import { getPromotionLinkList } from '@/api/promotion'
import { ElMessage, ElMessageBox } from 'element-plus'

const tableData = ref([])
const page = ref(1)
const pageSize = ref(10)
const total = ref(0)
const linkOptions = ref([])
const domainOptions = ref([])

const STORAGE_KEY = 'landing_visit_visible_columns'

const allColumns = [
  { key: 'ID', label: 'ID' },
  { key: 'linkId', label: '推广链接ID' },
  { key: 'categoryName', label: '所属分类' },
  { key: 'domainName', label: '域名' },
  { key: 'ip', label: 'IP地址' },
  { key: 'region', label: '地区' },
  { key: 'keyword', label: '关键词' },
  { key: 'referer', label: '来源链接' },
  { key: 'requestReferer', label: '访问链接' },
  { key: 'duration', label: '浏览时长(秒)' },
  { key: 'isCopied', label: '是否复制' },
  { key: 'copiedAt', label: '复制时间' },
  { key: 'isClickedAssist', label: '是否点击获客助手' },
  { key: 'clickedAssistAt', label: '点击获客助手时间' },
  { key: 'isOcpcCallback', label: '是否回传' },
  { key: 'ocpcCallbackAt', label: '回传时间' },
  { key: 'copiedServicePhone', label: '复制客服号码' },
  { key: 'copiedServiceNickname', label: '复制客服昵称' },
  { key: 'CreatedAt', label: '创建时间' }
]
const saved = localStorage.getItem(STORAGE_KEY)
const visibleColumns = ref(saved ? JSON.parse(saved) : allColumns.map(c => c.key))

watch(visibleColumns, (val) => {
  localStorage.setItem(STORAGE_KEY, JSON.stringify(val))
}, { deep: true })

const search = reactive({
  linkId: null,
  domainId: null,
  region: '',
  isCopied: null,
  copiedAtDates: [],
  isOcpcCallback: null,
  ocpcCallbackAtDates: [],
  isClickedAssist: null,
  clickedAssistAtDates: [],
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

// 获取域名列表
const loadDomainOptions = async () => {
  try {
    const res = await getPromotionDomainList({ page: 1, pageSize: 999 })
    if (res.code === 0) {
      domainOptions.value = res.data.list || []
    }
  } catch (error) {
    console.error('获取域名列表失败:', error)
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
  if (search.domainId) {
    params.domainId = search.domainId
  }
  if (search.region) {
    params.region = search.region
  }
  if (search.isCopied !== null) {
    params.isCopied = search.isCopied
  }
  if (search.copiedAtDates && search.copiedAtDates.length === 2) {
    const [s, e] = search.copiedAtDates
    params.copiedAtStart = s ? formatDate(s) : undefined
    params.copiedAtEnd = e ? formatDate(e) : undefined
  }
  if (search.isOcpcCallback !== null) {
    params.isOcpcCallback = search.isOcpcCallback
  }
  if (search.ocpcCallbackAtDates && search.ocpcCallbackAtDates.length === 2) {
    const [s, e] = search.ocpcCallbackAtDates
    params.ocpcCallbackAtStart = s ? formatDate(s) : undefined
    params.ocpcCallbackAtEnd = e ? formatDate(e) : undefined
  }
  if (search.isClickedAssist !== null) {
    params.isClickedAssist = search.isClickedAssist
  }
  if (search.clickedAssistAtDates && search.clickedAssistAtDates.length === 2) {
    const [s, e] = search.clickedAssistAtDates
    params.clickedAssistAtStart = s ? formatDate(s) : undefined
    params.clickedAssistAtEnd = e ? formatDate(e) : undefined
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
  search.domainId = null
  search.region = ''
  search.isCopied = null
  search.copiedAtDates = []
  search.isOcpcCallback = null
  search.ocpcCallbackAtDates = []
  search.isClickedAssist = null
  search.clickedAssistAtDates = []
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

// 手动OCPC回传
const handleManualCallback = async (row) => {
  if (row.isOcpcCallback) return
  try {
    await ElMessageBox.confirm(
      `确认对该访问记录（ID: ${row.ID}）进行OCPC回传？`,
      'OCPC回传确认',
      { confirmButtonText: '确认回传', cancelButtonText: '取消', type: 'warning' }
    )
    const res = await reportManualOcpcCallback({ id: row.ID })
    if (res.code === 0) {
      ElMessage.success('OCPC回传成功')
      getTableData()
    } 
  } catch (e) {
    if (e !== 'cancel') {
      console.error('OCPC回传失败', e)
    }
  }
}

// 导出
const exportExcel = async () => {
  try {
    const params = {
      page: 1,
      pageSize: 100000
    }
    if (search.linkId) params.linkId = search.linkId
    if (search.domainId) params.domainId = search.domainId
    if (search.region) params.region = search.region
    if (search.isCopied !== null) params.isCopied = search.isCopied
    if (search.copiedAtDates && search.copiedAtDates.length === 2) {
      params.copiedAtStart = search.copiedAtDates[0] ? formatDate(search.copiedAtDates[0]) : undefined
      params.copiedAtEnd = search.copiedAtDates[1] ? formatDate(search.copiedAtDates[1]) : undefined
    }
    if (search.isOcpcCallback !== null) params.isOcpcCallback = search.isOcpcCallback
    if (search.ocpcCallbackAtDates && search.ocpcCallbackAtDates.length === 2) {
      params.ocpcCallbackAtStart = search.ocpcCallbackAtDates[0] ? formatDate(search.ocpcCallbackAtDates[0]) : undefined
      params.ocpcCallbackAtEnd = search.ocpcCallbackAtDates[1] ? formatDate(search.ocpcCallbackAtDates[1]) : undefined
    }
    if (search.isClickedAssist !== null) params.isClickedAssist = search.isClickedAssist
    if (search.clickedAssistAtDates && search.clickedAssistAtDates.length === 2) {
      params.clickedAssistAtStart = search.clickedAssistAtDates[0] ? formatDate(search.clickedAssistAtDates[0]) : undefined
      params.clickedAssistAtEnd = search.clickedAssistAtDates[1] ? formatDate(search.clickedAssistAtDates[1]) : undefined
    }
    if (search.dates && search.dates.length === 2) {
      const [s, e] = search.dates
      params.startTime = s ? formatDate(s) : undefined
      params.endTime = e ? formatDate(e) : undefined
    }

    const res = await getLandingVisitList(params)
    if (res.code !== 0) {
      ElMessage.error('导出失败')
      return
    }
    const data = res.data.list || []
    if (!data.length) {
      ElMessage.warning('没有可导出的数据')
      return
    }

    const headers = ['ID', '推广链接ID', '所属分类', '域名', 'IP地址', '地区', '关键词', '来源链接', '访问链接', '浏览时长(秒)', '是否复制', '复制时间', '是否点击获客助手', '点击获客助手时间', '是否回传', '回传时间', '复制客服号码', '复制客服昵称', '创建时间']
    const csvRows = [headers.join(',')]
    for (const row of data) {
      csvRows.push([
        row.ID,
        row.linkId,
        `"${(row.categoryName || '').replace(/"/g, '""')}"`,
        `"${(row.domainName || '').replace(/"/g, '""')}"`,
        row.ip,
        `"${(row.region || '').replace(/"/g, '""')}"`,
        `"${extractKeyword(row.requestReferer, row.referer)}"`,
        `"${(row.referer || '').replace(/"/g, '""')}"`,
        `"${(row.requestReferer || '').replace(/"/g, '""')}"`,
        row.duration ?? 0,
        row.isCopied ? '已复制' : '未复制',
        formatDateTime(row.copiedAt),
        row.isClickedAssist ? '已点击' : '未点击',
        formatDateTime(row.clickedAssistAt),
        row.isOcpcCallback ? '已回传' : '未回传',
        formatDateTime(row.ocpcCallbackAt),
        `"${(row.copiedServicePhone || '').replace(/"/g, '""')}"`,
        `"${(row.copiedServiceNickname || '').replace(/"/g, '""')}"`,
        formatDateTime(row.CreatedAt)
      ].join(','))
    }

    const bom = '\uFEFF'
    const blob = new Blob([bom + csvRows.join('\n')], { type: 'text/csv;charset=utf-8;' })
    const url = URL.createObjectURL(blob)
    const a = document.createElement('a')
    a.href = url
    a.download = `访问记录_${formatDate(new Date())}.csv`
    document.body.appendChild(a)
    a.click()
    document.body.removeChild(a)
    URL.revokeObjectURL(url)
    ElMessage.success(`导出成功，共 ${data.length} 条记录`)
  } catch (e) {
    console.error('导出失败:', e)
    ElMessage.error('导出失败')
  }
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

// 从URL中提取keyword参数（优先从访问链接keyword=提取，再从来源链接q=提取）
const extractKeyword = (requestReferer, referer) => {
  try {
    if (requestReferer) {
      const match = requestReferer.match(/[?&]keyword=([^&]+)/)
      if (match) return decodeURIComponent(match[1])
    }
    if (referer) {
      const match = referer.match(/[?&]q=([^&]+)/)
      if (match) return decodeURIComponent(match[1])
    }
    return '-'
  } catch {
    return '-'
  }
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
  loadDomainOptions()
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
