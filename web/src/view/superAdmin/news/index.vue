<template>
  <div>
    <div class="gva-search-box">
      <el-form :inline="true" :model="search">
        <el-form-item label="标题关键词">
          <el-input v-model="search.title" placeholder="搜索标题" clearable style="width: 200px" />
        </el-form-item>
        <el-form-item label="分类">
            <el-select v-model="search.categoryId" clearable placeholder="全部" style="width: 150px">
            <el-option v-for="item in categoryOptions" :key="item.ID" :label="item.name" :value="item.ID" />
          </el-select>
        </el-form-item>
        <el-form-item label="状态">
          <el-select v-model="search.status" clearable placeholder="全部" style="width: 120px">
            <el-option :value="0" label="草稿" />
            <el-option :value="1" label="已发布" />
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
        <el-button type="primary" icon="plus" @click="openForm()">新增新闻</el-button>
        <el-button type="success" icon="collection-tag" @click="openCategoryDialog">分类管理</el-button>
      </div>
      <el-table :data="tableData" row-key="ID" style="width:100%" v-loading="loading">
        <el-table-column prop="ID" label="ID" width="70" />
        <el-table-column label="标题" min-width="200" show-overflow-tooltip>
          <template #default="{ row }">
            <div class="flex items-center gap-1">
              <el-tag v-if="row.isTop" size="small" type="danger" effect="plain">置顶</el-tag>
              <span>{{ row.title }}</span>
            </div>
          </template>
        </el-table-column>
        <el-table-column label="分类" width="120">
          <template #default="{ row }">
            <el-tag v-if="row.categoryName" size="small" effect="plain">{{ row.categoryName }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="author" label="作者" width="100" />
        <el-table-column label="状态" width="80">
          <template #default="{ row }">
            <el-tag :type="row.status === 1 ? 'success' : 'info'" size="small">
              {{ row.status === 1 ? '已发布' : '草稿' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="sort" label="排序" width="70" />
        <el-table-column prop="viewCount" label="浏览" width="70" />
        <el-table-column label="发布时间" width="170">
          <template #default="{ row }">
            {{ row.publishTime ? row.publishTime : '-' }}
          </template>
        </el-table-column>
        <el-table-column fixed="right" label="操作" width="260">
          <template #default="{ row }">
            <el-button type="primary" link @click="openForm(row)">编辑</el-button>
            <el-button type="success" link @click="handlePublish(row)">发布更新</el-button>
            <el-button v-if="row.publishedPath" type="primary" link @click="previewNews(row)">预览</el-button>
            <el-button type="danger" link @click="handleDelete(row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
      <div class="gva-pagination-box">
        <el-pagination
          v-model:current-page="page"
          v-model:page-size="pageSize"
          :page-sizes="[10, 20, 50, 100]"
          :total="total"
          layout="total, sizes, prev, pager, next, jumper"
          @current-change="getTableData"
          @size-change="getTableData"
        />
      </div>
    </div>

    <!-- 新闻编辑抽屉 -->
    <el-drawer v-model="drawerVisible" :title="drawerTitle" size="80%" destroy-on-close>
      <el-form ref="formRef" :model="form" label-width="100px" class="pr-6">
        <el-form-item label="标题" prop="title" :rules="[{ required: true, message: '请输入新闻标题' }]">
          <el-input v-model="form.title" placeholder="请输入新闻标题" maxlength="200" show-word-limit />
        </el-form-item>

        <el-row :gutter="20">
          <el-col :span="8">
            <el-form-item label="分类" prop="categoryId">
              <el-select v-model="form.categoryId" placeholder="选择分类" clearable style="width:100%">
                <el-option v-for="item in categoryOptions" :key="item.ID" :label="item.name" :value="item.ID" />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="8">
            <el-form-item label="作者" prop="author">
              <el-input v-model="form.author" placeholder="作者" />
            </el-form-item>
          </el-col>
          <el-col :span="8">
            <el-form-item label="排序" prop="sort">
              <el-input-number v-model="form.sort" :min="0" :max="9999" style="width:100%" />
            </el-form-item>
          </el-col>
        </el-row>

        <el-row :gutter="20">
          <el-col :span="8">
            <el-form-item label="来源" prop="source">
              <el-input v-model="form.source" placeholder="来源名称" />
            </el-form-item>
          </el-col>
          <el-col :span="16">
            <el-form-item label="来源链接" prop="sourceUrl">
              <el-input v-model="form.sourceUrl" placeholder="来源URL" />
            </el-form-item>
          </el-col>
        </el-row>

        <el-row :gutter="20">
          <el-col :span="8">
            <el-form-item label="封面图片" prop="coverImage">
              <el-input v-model="form.coverImage" placeholder="图片URL">
                <template #append>
                  <el-upload
                    :action="`${basePath}/fileUploadAndDownload/upload?noSave=1`"
                    :headers="{ 'x-token': token }"
                    :show-file-list="false"
                    :on-success="handleCoverSuccess"
                    accept="image/*"
                  >
                    <el-button type="primary" icon="upload">上传</el-button>
                  </el-upload>
                </template>
              </el-input>
            </el-form-item>
          </el-col>
          <el-col :span="8">
            <el-form-item label="状态" prop="status">
              <el-radio-group v-model="form.status">
                <el-radio :value="0">草稿</el-radio>
                <el-radio :value="1">已发布</el-radio>
              </el-radio-group>
            </el-form-item>
          </el-col>
          <el-col :span="8">
            <el-form-item label="置顶" prop="isTop">
              <el-switch v-model="form.isTop" />
            </el-form-item>
          </el-col>
        </el-row>

        <el-form-item label="摘要" prop="summary">
          <el-input v-model="form.summary" type="textarea" :rows="3" placeholder="新闻摘要" maxlength="500" show-word-limit />
        </el-form-item>

        <el-form-item label="内容" prop="content">
          <div class="w-full border border-solid border-gray-200 rounded">
            <RichEdit v-model="form.content" :height="500" />
          </div>
        </el-form-item>

        <el-divider>SEO 设置</el-divider>

        <el-form-item label="SEO关键词" prop="seoKeywords">
          <el-input v-model="form.seoKeywords" type="textarea" :rows="2" placeholder="多个关键词用逗号分隔" />
        </el-form-item>
        <el-form-item label="SEO描述" prop="seoDescription">
          <el-input v-model="form.seoDescription" type="textarea" :rows="2" placeholder="SEO描述" maxlength="300" show-word-limit />
        </el-form-item>
      </el-form>

      <template #footer>
        <el-button @click="closeDrawer">取消</el-button>
        <el-button type="primary" :loading="saving" @click="enterDrawer">保存</el-button>
      </template>
    </el-drawer>

    <!-- 分类管理对话框 -->
    <el-dialog v-model="categoryDialogVisible" title="分类管理" width="600px" destroy-on-close>
      <div class="mb-4">
        <el-button type="primary" icon="plus" size="small" @click="openCategoryForm()">新增分类</el-button>
      </div>
      <el-table :data="categoryTableData" v-loading="categoryLoading" style="width:100%">
        <el-table-column type="index" label="#" width="50" />
        <el-table-column prop="name" label="分类名称" min-width="150" />
        <el-table-column prop="sort" label="排序" width="80" />
        <el-table-column label="状态" width="80">
          <template #default="{ row }">
            <el-tag :type="row.status === 1 ? 'success' : 'danger'" size="small">
              {{ row.status === 1 ? '启用' : '禁用' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="remark" label="备注" min-width="150" show-overflow-tooltip />
        <el-table-column label="操作" width="160" fixed="right">
          <template #default="{ row }">
            <el-button type="primary" link @click="openCategoryForm(row)">编辑</el-button>
            <el-button type="danger" link @click="handleDeleteCategory(row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
      <el-pagination
        v-model:current-page="categoryPage"
        v-model:page-size="categoryPageSize"
        :page-sizes="[10, 20, 50]"
        :total="categoryTotal"
        layout="total, sizes, prev, pager, next, jumper"
        small
        @current-change="loadCategoryTable"
        @size-change="loadCategoryTable"
      />

      <!-- 分类编辑对话框 -->
      <el-dialog v-model="categoryFormVisible" :title="categoryFormTitle" width="450px" append-to-body destroy-on-close>
        <el-form ref="categoryFormRef" :model="categoryForm" label-width="80px">
          <el-form-item label="名称" prop="name" :rules="[{ required: true, message: '请输入分类名称' }]">
            <el-input v-model="categoryForm.name" placeholder="分类名称" maxlength="100" />
          </el-form-item>
          <el-form-item label="排序" prop="sort">
            <el-input-number v-model="categoryForm.sort" :min="0" :max="9999" />
          </el-form-item>
          <el-form-item label="状态" prop="status">
            <el-radio-group v-model="categoryForm.status">
              <el-radio :value="1">启用</el-radio>
              <el-radio :value="0">禁用</el-radio>
            </el-radio-group>
          </el-form-item>
          <el-form-item label="备注" prop="remark">
            <el-input v-model="categoryForm.remark" type="textarea" :rows="2" placeholder="备注" />
          </el-form-item>
        </el-form>
        <template #footer>
          <el-button @click="categoryFormVisible = false">取消</el-button>
          <el-button type="primary" :loading="categorySaving" @click="enterCategoryForm">保存</el-button>
        </template>
      </el-dialog>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, onMounted, computed } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import {
  createNews, updateNews, deleteNews, getNewsList, publishNews,
  createNewsCategory, updateNewsCategory, deleteNewsCategory,
  getNewsCategoryList, getAllEnabledNewsCategories
} from '@/api/news'
import RichEdit from '@/components/richtext/rich-edit.vue'
import { useUserStore } from '@/pinia/modules/user'

const userStore = useUserStore()
const basePath = import.meta.env.VITE_BASE_API
const token = computed(() => userStore.token)

// ===== 新闻列表 =====
const loading = ref(false)
const saving = ref(false)
const drawerVisible = ref(false)
const drawerTitle = ref('新增新闻')
const page = ref(1)
const pageSize = ref(10)
const total = ref(0)
const tableData = ref([])
const categoryOptions = ref([])

const search = ref({
  title: '',
  categoryId: null,
  status: null
})

const defaultForm = () => ({
  title: '',
  summary: '',
  content: '',
  coverImage: '',
  author: '',
  categoryId: null,
  source: '',
  sourceUrl: '',
  status: 0,
  isTop: false,
  sort: 0,
  seoKeywords: '',
  seoDescription: ''
})

const form = ref(defaultForm())
const formRef = ref(null)

const getTableData = async () => {
  loading.value = true
  try {
    const params = { page: page.value, pageSize: pageSize.value }
    if (search.value.title) params.title = search.value.title
    if (search.value.categoryId) params.categoryId = search.value.categoryId
    if (search.value.status !== null && search.value.status !== '') params.status = search.value.status
    const res = await getNewsList(params)
    if (res.code === 0) {
      tableData.value = res.data.list
      total.value = res.data.total
    }
  } finally {
    loading.value = false
  }
}

const loadCategories = async () => {
  try {
    const res = await getAllEnabledNewsCategories()
    if (res.code === 0) {
      categoryOptions.value = res.data.categories || []
    }
  } catch { /* ignore */ }
}

const onSubmit = () => { page.value = 1; getTableData() }
const onReset = () => { search.value = { title: '', categoryId: null, status: null }; onSubmit() }

const openForm = (row) => {
  if (row) {
    drawerTitle.value = '编辑新闻'
    form.value = {
      ID: row.ID,
      title: row.title,
      summary: row.summary || '',
      content: row.content || '',
      coverImage: row.coverImage || '',
      author: row.author || '',
      categoryId: row.categoryId || null,
      source: row.source || '',
      sourceUrl: row.sourceUrl || '',
      status: row.status,
      isTop: row.isTop || false,
      sort: row.sort || 0,
      seoKeywords: row.seoKeywords || '',
      seoDescription: row.seoDescription || ''
    }
  } else {
    drawerTitle.value = '新增新闻'
    form.value = defaultForm()
  }
  drawerVisible.value = true
}

const closeDrawer = () => { drawerVisible.value = false }

const enterDrawer = async () => {
  const valid = await formRef.value.validate().catch(() => false)
  if (!valid) return
  saving.value = true
  try {
    const payload = { ...form.value }
    if (!payload.categoryId) payload.categoryId = 0
    if (form.value.ID) {
      const res = await updateNews(payload)
      if (res.code === 0) {
        ElMessage.success('更新成功')
        drawerVisible.value = false
        getTableData()
      }
    } else {
      const res = await createNews(payload)
      if (res.code === 0) {
        ElMessage.success('创建成功')
        drawerVisible.value = false
        getTableData()
      }
    }
  } finally {
    saving.value = false
  }
}

const handleDelete = (row) => {
  ElMessageBox.confirm('确定要删除该新闻吗？', '提示', {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'warning'
  }).then(async () => {
    const res = await deleteNews({ ID: row.ID })
    if (res.code === 0) {
      ElMessage.success('删除成功')
      getTableData()
    }
  }).catch(() => {})
}

const handlePublish = async (row) => {
  ElMessageBox.confirm(
    '发布更新将生成静态HTML页面，确定要发布吗？',
    '提示',
    { confirmButtonText: '确定', cancelButtonText: '取消', type: 'info' }
  ).then(async () => {
    const res = await publishNews({ id: row.ID })
    if (res.code === 0) {
      ElMessage.success('发布成功')
      getTableData()
    }
  }).catch(() => {})
}

const previewNews = (row) => {
  if (row.publishedPath) {
    window.open(`${location.origin}${row.publishedPath}`, '_blank')
  }
}

const handleCoverSuccess = (res) => {
  if (res.code === 0 && res.data && res.data.file) {
    const fileUrl = res.data.file.url || res.data.file.Url
    if (fileUrl) {
      form.value.coverImage = basePath + '/' + fileUrl
    }
  }
}

// ===== 分类管理 =====
const categoryDialogVisible = ref(false)
const categoryLoading = ref(false)
const categoryTableData = ref([])
const categoryPage = ref(1)
const categoryPageSize = ref(10)
const categoryTotal = ref(0)

const categoryFormVisible = ref(false)
const categoryFormTitle = ref('新增分类')
const categorySaving = ref(false)
const categoryFormRef = ref(null)
const categoryForm = ref({ name: '', sort: 0, status: 1, remark: '' })

const openCategoryDialog = () => {
  categoryDialogVisible.value = true
  loadCategoryTable()
}

const loadCategoryTable = async () => {
  categoryLoading.value = true
  try {
    const res = await getNewsCategoryList({
      page: categoryPage.value,
      pageSize: categoryPageSize.value
    })
    if (res.code === 0) {
      categoryTableData.value = res.data.list
      categoryTotal.value = res.data.total
    }
  } finally {
    categoryLoading.value = false
  }
}

const openCategoryForm = (row) => {
  if (row) {
    categoryFormTitle.value = '编辑分类'
    categoryForm.value = { ...row }
  } else {
    categoryFormTitle.value = '新增分类'
    categoryForm.value = { name: '', sort: 0, status: 1, remark: '' }
  }
  categoryFormVisible.value = true
}

const enterCategoryForm = async () => {
  const valid = await categoryFormRef.value.validate().catch(() => false)
  if (!valid) return
  categorySaving.value = true
  try {
    if (categoryForm.value.ID) {
      const res = await updateNewsCategory(categoryForm.value)
      if (res.code === 0) {
        ElMessage.success('更新成功')
        categoryFormVisible.value = false
        loadCategoryTable()
        loadCategories()
      }
    } else {
      const res = await createNewsCategory(categoryForm.value)
      if (res.code === 0) {
        ElMessage.success('创建成功')
        categoryFormVisible.value = false
        loadCategoryTable()
        loadCategories()
      }
    }
  } finally {
    categorySaving.value = false
  }
}

const handleDeleteCategory = (row) => {
  ElMessageBox.confirm('确定要删除该分类吗？', '提示', {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'warning'
  }).then(async () => {
    const res = await deleteNewsCategory({ ID: row.ID })
    if (res.code === 0) {
      ElMessage.success('删除成功')
      loadCategoryTable()
      loadCategories()
    }
  }).catch(() => {})
}

onMounted(() => {
  getTableData()
  loadCategories()
})
</script>

<style scoped>
.pr-6 { padding-right: 24px; }
.mb-4 { margin-bottom: 16px; }
</style>
