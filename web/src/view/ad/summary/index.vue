<template>
  <div>
    <div class="gva-search-box">
      <el-form :inline="true" :model="search">
        <el-form-item label="平台">
          <el-select v-model="search.platformId" clearable filterable placeholder="选择平台">
            <el-option v-for="p in platformOptions" :key="p.ID" :label="p.name" :value="p.ID" />
          </el-select>
        </el-form-item>
        <el-form-item label="日期">
          <el-date-picker v-model="search.dates" type="daterange" range-separator="至" start-placeholder="开始日期" end-placeholder="结束日期" />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" icon="search" @click="onSubmit">查询</el-button>
          <el-button icon="refresh" @click="onReset">重置</el-button>
        </el-form-item>
      </el-form>
    </div>
    <div class="gva-table-box">
      <el-table :data="tableData" row-key="ID" style="width:100%">
        <el-table-column prop="ID" label="ID" width="80" />
        <el-table-column prop="summaryDate" label="日期" width="140" />
        <el-table-column label="平台" width="160">
          <template #default="{ row }">
            {{ (platformOptions.find(p => p.ID === row.platformId) || {}).name || row.platformId }}
          </template>
        </el-table-column>
        <el-table-column prop="deviceType" label="设备" width="100" />
        <el-table-column prop="impressions" label="展现" width="100" />
        <el-table-column prop="clicks" label="点击" width="100" />
        <el-table-column prop="cost" label="消耗" width="120" />
      </el-table>
      <el-pagination class="mt-4" background layout="total, sizes, prev, pager, next, jumper"
        :current-page="page" :page-size="pageSize" :total="total"
        @size-change="handleSizeChange" @current-change="handleCurrentChange" />
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { getAdDailySummaryList, getAdPlatformList } from '@/api/promotion'

const search = ref({ platformId: null, dates: null })
const platformOptions = ref([])
const tableData = ref([])
const page = ref(1)
const pageSize = ref(10)
const total = ref(0)

const load = async () => {
  const [sumRes, platRes] = await Promise.all([
    getAdDailySummaryList({ page: page.value, pageSize: pageSize.value }),
    getAdPlatformList({ page: 1, pageSize: 10000 })
  ])
  if (sumRes.code === 0) { tableData.value = sumRes.data.list; total.value = sumRes.data.total; page.value = sumRes.data.page; pageSize.value = sumRes.data.pageSize }
  if (platRes.code === 0) { platformOptions.value = platRes.data.list || [] }
}
load()

const onSubmit = async () => {
  const params = { page: page.value, pageSize: pageSize.value }
  if (search.value.platformId) params.platformId = search.value.platformId
  if (search.value.dates && search.value.dates.length === 2) {
    const [s, e] = search.value.dates
    params.startDate = s ? new Date(s).toISOString().slice(0, 10) : undefined
    params.endDate = e ? new Date(e).toISOString().slice(0, 10) : undefined
  }
  const res = await getAdDailySummaryList(params)
  if (res.code === 0) { tableData.value = res.data.list; total.value = res.data.total; page.value = res.data.page; pageSize.value = res.data.pageSize }
}
const onReset = () => { search.value = { platformId: null, dates: null }; onSubmit() }
const handleSizeChange = async (v) => { pageSize.value = v; await onSubmit() }
const handleCurrentChange = async (v) => { page.value = v; await onSubmit() }
</script>

<style scoped></style>
