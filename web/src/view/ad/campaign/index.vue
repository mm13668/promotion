<template>
  <div>
    <div class="gva-search-box">
      <el-form :inline="true" :model="search">
        <el-form-item label="平台">
          <el-select v-model="search.platformId" clearable filterable placeholder="选择平台" style="width: 180px">
            <el-option v-for="p in platformOptions" :key="p.ID" :label="p.name" :value="p.ID" />
          </el-select>
        </el-form-item>
        <el-form-item label="链接">
          <el-select v-model="search.linkId" clearable filterable placeholder="选择链接" style="width: 200px">
            <el-option v-for="l in linkOptions" :key="l.ID" :label="l.title" :value="l.ID" />
          </el-select>
        </el-form-item>
        <el-form-item label="地区">
          <el-select v-model="search.regionId" clearable filterable placeholder="选择地区" style="width: 180px">
            <el-option v-for="r in regionOptions" :key="r.ID" :label="r.name" :value="r.ID" />
          </el-select>
        </el-form-item>
        <el-form-item label="分组">
          <el-select v-model="search.groupId" clearable filterable placeholder="选择分组" style="width: 180px">
            <el-option v-for="g in groupOptions" :key="g.ID" :label="g.name" :value="g.ID" />
          </el-select>
        </el-form-item>
        <el-form-item label="关键字">
          <el-input v-model="search.keyword" placeholder="编号/名称" clearable style="width: 200px" />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" icon="search" @click="onSubmit">查询</el-button>
          <el-button icon="refresh" @click="onReset">重置</el-button>
          <el-button type="primary" icon="plus" @click="openForm()">新增</el-button>
        </el-form-item>
      </el-form>
    </div>
    <div class="gva-table-box">
      <el-table :data="tableData" row-key="ID" style="width:100%">
        <el-table-column prop="ID" label="ID" width="80" />
        <el-table-column label="平台" width="160">
          <template #default="{ row }">
            {{ (platformOptions.find(p => p.ID === row.platformId) || {}).name || row.platformId }}
          </template>
        </el-table-column>
        <el-table-column prop="campaignCode" label="编号" width="160" />
        <el-table-column prop="campaignName" label="名称" min-width="200" />
        <el-table-column label="链接" min-width="180" show-overflow-tooltip>
          <template #default="{ row }">
            {{ (linkOptions.find(l => l.ID === row.linkId) || {}).title || row.linkId }}
          </template>
        </el-table-column>
        <el-table-column label="地区" min-width="160">
          <template #default="{ row }">
            {{ (regionOptions.find(r => r.ID === row.regionId) || {}).name || row.regionId }}
          </template>
        </el-table-column>
        <el-table-column label="分组" min-width="160">
          <template #default="{ row }">
            {{ (groupOptions.find(g => g.ID === row.groupId) || {}).name || row.groupId }}
          </template>
        </el-table-column>
        <el-table-column prop="status" label="状态" width="100" />
        <el-table-column fixed="right" label="操作" width="180">
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
        <el-form-item label="平台">
          <el-select v-model="form.platformId" filterable placeholder="请选择平台">
            <el-option v-for="p in platformOptions" :key="p.ID" :label="p.name" :value="p.ID" />
          </el-select>
        </el-form-item>
        <el-form-item label="编号">
          <el-input v-model="form.campaignCode" />
        </el-form-item>
        <el-form-item label="名称">
          <el-input v-model="form.campaignName" />
        </el-form-item>
        <el-form-item label="链接">
          <el-select v-model="form.linkId" filterable clearable placeholder="选择推广链接">
            <el-option v-for="l in linkOptions" :key="l.ID" :label="l.title" :value="l.ID" />
          </el-select>
        </el-form-item>
        <el-form-item label="地区">
          <el-select v-model="form.regionId" filterable clearable placeholder="选择地区">
            <el-option v-for="r in regionOptions" :key="r.ID" :label="r.name" :value="r.ID" />
          </el-select>
        </el-form-item>
        <el-form-item label="分组">
          <el-select v-model="form.groupId" filterable clearable placeholder="选择分组">
            <el-option v-for="g in groupOptions" :key="g.ID" :label="g.name" :value="g.ID" />
          </el-select>
        </el-form-item>
        <el-form-item label="状态">
          <el-input-number v-model="form.status" />
        </el-form-item>
      </el-form>
    </el-drawer>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { getAdCampaignList, createAdCampaign, updateAdCampaign, deleteAdCampaign, getAdPlatformList, getPromotionLinkList, getRegionCategoryList, getPromotionGroupList } from '@/api/promotion'
import { useAppStore } from '@/pinia/modules/app'
const appStore = useAppStore()

const tableData = ref([])
const page = ref(1)
const pageSize = ref(10)
const total = ref(0)
const search = ref({ platformId: null, linkId: null, regionId: null, groupId: null, keyword: '' })
const platformOptions = ref([])
const linkOptions = ref([])
const regionOptions = ref([])
const groupOptions = ref([])
const getTableData = async (params = {}) => {
  const res = await getAdCampaignList({ page: page.value, pageSize: pageSize.value, ...params })
  if (res.code === 0) { tableData.value = res.data.list; total.value = res.data.total; page.value = res.data.page; pageSize.value = res.data.pageSize }
}
getTableData()
const onSubmit = async () => {
  const params = {}
  if (search.value.platformId) params.platformId = search.value.platformId
  if (search.value.linkId) params.linkId = search.value.linkId
  if (search.value.regionId) params.regionId = search.value.regionId
  if (search.value.groupId) params.groupId = search.value.groupId
  if (search.value.keyword) params.keyword = search.value.keyword
  await getTableData(params)
}
const onReset = async () => {
  search.value = { platformId: null, linkId: null, regionId: null, groupId: null, keyword: '' }
  await onSubmit()
}
const loadOptions = async () => {
  const [pRes, lRes, rRes, gRes] = await Promise.all([
    getAdPlatformList({ page: 1, pageSize: 10000 }),
    getPromotionLinkList({ page: 1, pageSize: 10000 }),
    getRegionCategoryList({ page: 1, pageSize: 10000 }),
    getPromotionGroupList({ page: 1, pageSize: 10000 })
  ])
  if (pRes.code === 0) platformOptions.value = pRes.data.list || []
  if (lRes.code === 0) linkOptions.value = lRes.data.list || []
  if (rRes.code === 0) regionOptions.value = rRes.data.list || []
  if (gRes.code === 0) groupOptions.value = gRes.data.list || []
}
loadOptions()
const handleSizeChange = async (v) => { pageSize.value = v; await onSubmit() }
const handleCurrentChange = async (v) => { page.value = v; await onSubmit() }

const drawer = ref(false)
const form = ref({ ID: 0, platformId: 0, campaignCode: '', campaignName: '', linkId: null, regionId: null, groupId: null, status: 1 })
const openForm = (row) => { form.value = row ? { ...row } : { ID: 0, platformId: 0, campaignCode: '', campaignName: '', status: 1 }; drawer.value = true }
const submit = async () => {
  if (!form.value.platformId || !form.value.campaignCode || !form.value.campaignName) { ElMessage.error('请填写必填项'); return }
  let res = form.value.ID ? await updateAdCampaign(form.value) : await createAdCampaign(form.value)
  if (res.code === 0) { ElMessage.success('保存成功'); drawer.value = false; getTableData() }
}
const remove = async (row) => {
  await ElMessageBox.confirm('确认删除该记录？', '提示')
  const res = await deleteAdCampaign({ ID: row.ID })
  if (res.code === 0) { ElMessage.success('删除成功'); getTableData() }
}
</script>

<style scoped></style>
