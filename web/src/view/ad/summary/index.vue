<template>
  <div>
    <div class="gva-table-box">
      <el-table :data="tableData" row-key="ID" style="width:100%">
        <el-table-column prop="ID" label="ID" width="80" />
        <el-table-column prop="summaryDate" label="日期" width="140" />
        <el-table-column prop="platformId" label="平台ID" width="100" />
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
import { getAdDailySummaryList } from '@/api/promotion'
const tableData = ref([])
const page = ref(1)
const pageSize = ref(10)
const total = ref(0)
const load = async () => {
  const res = await getAdDailySummaryList({ page: page.value, pageSize: pageSize.value })
  if (res.code === 0) { tableData.value = res.data.list; total.value = res.data.total; page.value = res.data.page; pageSize.value = res.data.pageSize }
}
load()
const handleSizeChange = (v) => { pageSize.value = v; load() }
const handleCurrentChange = (v) => { page.value = v; load() }
</script>

<style scoped></style>

