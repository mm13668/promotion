<template>
  <div class="page-visual-container">
    <!-- 顶部：问题选择器 -->
    <div class="top-bar">
      <div class="top-bar-inner">
        <div class="flex items-center gap-4">
          <span class="text-sm font-medium text-gray-600 whitespace-nowrap">选择页面：</span>
          <el-select v-model="selectedQuestionId" filterable clearable placeholder="请选择要编辑的页面" style="width: 400px" @change="onQuestionSelect">
            <el-option v-for="item in questionOptions" :key="item.ID" :label="item.title" :value="item.ID" />
          </el-select>
          <el-button type="primary" @click="showQuestionSelector = true" icon="search">浏览页面列表</el-button>
          <el-button type="success" @click="openCreateQuestion" icon="plus">新增页面</el-button>
        </div>
        <div class="flex items-center gap-2" v-if="questionDetail.ID">
          <el-tag type="info">{{ (questionDetail.answers || []).length }} 回答</el-tag>
          <el-tag type="warning">{{ totalReplies }} 回复</el-tag>
        </div>
      </div>
    </div>

    <!-- 主内容区：左预览 + 右编辑 -->
    <div class="main-content" v-loading="loading">
      <!-- 左侧预览面板 -->
      <div class="preview-panel">
        <div class="panel-header">
          <span class="panel-title">预览</span>
          <el-button size="small" type="primary" plain @click="refreshPreview">刷新预览</el-button>
        </div>
        <div class="preview-body" v-if="questionDetail.ID">
          <div class="bg-white p-6 shadow-sm mb-4 rounded">
            <h1 class="text-xl font-bold text-gray-800 mb-3">{{ questionDetail.title }}</h1>
            <div class="flex flex-wrap gap-2 mb-4">
              <span v-for="tag in questionDetail.label" :key="tag" class="px-3 py-1 bg-green-50 text-green-600 rounded-md text-sm">{{ tag }}</span>
            </div>
            <div class="flex items-center mb-4">
              <img v-if="questionDetail.avatarUrl" :src="`${getBaseUrl()}/${questionDetail.avatarUrl}`" class="w-10 h-10 rounded-full mr-3 object-cover">
              <div>
                <div class="flex items-center gap-2">
                  <span class="font-medium text-orange-500">{{ questionDetail.nickname }}</span>
                  <span v-if="questionDetail.titleName" class="px-2 py-0.5 bg-red-500 text-white text-xs rounded">{{ questionDetail.titleName }}</span>
                </div>
                <div class="text-xs text-gray-500 mt-0.5">{{ questionDetail.timeAt }}</div>
              </div>
            </div>
          </div>
          <div class="bg-white p-6 shadow-sm mb-4 rounded">
            <div class="ql-editor-content text-gray-700 leading-relaxed" v-html="questionDetail.content"></div>
          </div>
          <div class="space-y-3">
            <div v-for="answer in questionDetail.answers" :key="answer.ID" :data-answer-id="answer.ID" class="bg-white p-5 shadow-sm rounded">
              <div class="flex items-center mb-3">
                <img v-if="answer.avatarUrl" :src="`${getBaseUrl()}/${answer.avatarUrl}`" class="w-9 h-9 rounded-full mr-3 object-cover">
                <div class="flex-1">
                  <div class="flex items-center gap-2">
                    <span class="font-medium text-blue-500 text-sm">{{ answer.nickname }}</span>
                    <span v-if="answer.titleName" class="px-1.5 py-0.5 bg-red-500 text-white text-xs rounded">{{ answer.titleName }}</span>
                    <span v-if="answer.level" class="px-1.5 py-0.5 bg-orange-100 text-orange-600 text-xs rounded">Lv.{{ answer.level }}</span>
                  </div>
                  <div class="text-xs text-gray-400 mt-0.5">
                    <span>{{ answer.timeText }}</span>
                    <span v-if="answer.skill" class="ml-3">擅长：{{ answer.skill }}</span>
                  </div>
                </div>
              </div>
              <div class="ql-editor-content text-gray-700 text-sm leading-relaxed mb-3" v-html="answer.content"></div>
              <div v-for="reply in answer.replies" :key="reply.ID" :data-reply-id="reply.ID" class="bg-yellow-50 p-3 rounded mb-2 ml-6">
                <div class="flex items-center gap-2 mb-1">
                  <img v-if="reply.avatarUrl" :src="`${getBaseUrl()}/${reply.avatarUrl}`" class="w-6 h-6 rounded-full object-cover">
                  <span class="text-green-600 font-medium text-xs">{{ reply.nickname }}</span>
                  <span v-if="reply.titleName" class="px-1 py-0.5 bg-red-500 text-white text-xs rounded">{{ reply.titleName }}</span>
                  <span v-if="reply.level" class="px-1 py-0.5 bg-orange-100 text-orange-600 text-xs rounded">Lv.{{ reply.level }}</span>
                  <span class="text-xs text-gray-400 ml-1">{{ reply.timeText }}</span>
                </div>
                <div class="ql-editor-content text-gray-600 text-xs leading-relaxed ml-8" v-html="reply.content"></div>
              </div>
            </div>
          </div>
        </div>
        <div class="preview-body flex items-center justify-center text-gray-400" v-else>
          <div class="text-center">
            <el-icon :size="48"><ChatLineSquare /></el-icon>
            <p class="mt-4">请从上方选择一个页面进行编辑</p>
          </div>
        </div>
      </div>

      <!-- 右侧编辑面板 -->
      <div class="edit-panel">
        <div class="panel-header">
          <span class="panel-title">编辑</span>
        </div>
        <div class="edit-body" v-if="questionDetail.ID">
          <el-tabs v-model="activeTab" type="border-card">
            <el-tab-pane label="页面编辑" name="question">
              <div class="edit-form-scroll">
                <el-form label-position="top" :model="questionForm" size="small">
                  <el-form-item label="所属分类">
                    <el-select v-model="questionForm.regionId" filterable clearable placeholder="选择所属分类">
                      <el-option v-for="r in regionOptions" :key="r.ID" :label="r.name" :value="r.ID" />
                    </el-select>
                  </el-form-item>
                  <el-form-item label="提问标题">
                    <el-input v-model="questionForm.title" />
                  </el-form-item>
                  <el-form-item label="提问时间">
                    <el-input v-model="questionForm.timeAt" placeholder="例如：2天前,10分钟前,刚刚" />
                  </el-form-item>
                  <el-form-item label="备注">
                    <el-input v-model="questionForm.remark" placeholder="仅在后台显示" />
                  </el-form-item>
                  <el-form-item label="选择头像昵称（可选）">
                    <el-select clearable filterable placeholder="选择已有头像昵称" @change="onSelectQuestionAvatarNickname">
                      <el-option v-for="item in avatarNicknameOptions" :key="item.ID" :label="item.nickname" :value="item" />
                    </el-select>
                  </el-form-item>
                  <el-form-item label="提问昵称">
                    <el-input v-model="questionForm.nickname" placeholder="可手动输入" />
                  </el-form-item>
                  <el-form-item label="头像">
                    <div class="flex items-center gap-3">
                      <UploadImage v-model="questionForm.avatarUrl" @on-success="(url) => questionForm.avatarUrl = url"/>
                      <img v-if="questionForm.avatarUrl" :src="`${getBaseUrl()}/${questionForm.avatarUrl}`" class="h-14 w-14 object-contain border rounded flex-shrink-0" />
                    </div>
                  </el-form-item>
                  <el-form-item label="称号">
                    <el-select v-model="questionForm.titleName" clearable filterable allow-create placeholder="选填称号">
                      <el-option v-for="item in titleOptions" :key="item.ID" :label="item.name" :value="item.name" />
                    </el-select>
                  </el-form-item>
                  <el-form-item label="个性签名">
                    <el-select v-model="questionForm.signature" clearable filterable allow-create placeholder="选填">
                      <el-option v-for="item in signatureOptions" :key="item.ID" :label="item.content" :value="item.content" />
                    </el-select>
                  </el-form-item>
                  <el-form-item label="关注人数">
                    <el-input-number v-model="questionForm.followCount" :min="0" />
                  </el-form-item>
                  <el-form-item label="浏览人数">
                    <el-input-number v-model="questionForm.lookCount" :min="0" />
                  </el-form-item>
                  <el-form-item label="收藏人数">
                    <el-input-number v-model="questionForm.favoriteCount" :min="0" />
                  </el-form-item>
                  <el-form-item label="点赞人数">
                    <el-input-number v-model="questionForm.likeCount" :min="0" />
                  </el-form-item>
                  <el-form-item label="标签">
                    <el-select v-model="questionForm.label" clearable filterable multiple allow-create placeholder="选填标签">
                      <el-option v-for="item in tagOptions" :key="item.ID" :label="item.name" :value="item.name" />
                    </el-select>
                  </el-form-item>
                  <el-form-item label="排序">
                    <el-input-number v-model="questionForm.sort" :min="0" />
                  </el-form-item>
                  <el-form-item label="内容">
                    <RichEdit v-model="questionForm.content" :height="300" />
                  </el-form-item>
                  <el-form-item>
                    <el-button type="primary" @click="submitQuestion">保存页面</el-button>
                  </el-form-item>
                </el-form>
              </div>
            </el-tab-pane>

            <el-tab-pane label="评论管理" name="answer">
              <div class="edit-form-scroll">
                <div class="flex justify-between items-center mb-2">
                  <span class="text-sm text-gray-500">共 {{ answerList.length }} 条评论</span>
                  <div class="flex items-center gap-2">
                    <span class="text-xs text-orange-400">点击卡片预览定位</span>
                    <span class="text-xs text-orange-400">拖拽手柄可排序</span>
                    <el-button type="primary" size="small" icon="plus" @click="openAnswerForm()">新增回答</el-button>
                  </div>
                </div>
                <draggable v-model="answerList" group="answer" handle=".drag-handle" item-key="ID" class="space-y-3" @end="onAnswerDragEnd">
                  <template #item="{ element: answer }">
                    <div class="answer-card mb-3 p-4 border rounded" @click="scrollToElement(`[data-answer-id=&quot;${answer.ID}&quot;]`)">
                      <div class="flex items-start justify-between mb-2">
                        <div class="flex items-center gap-2">
                          <span class="drag-handle cursor-grab text-gray-500 hover:text-blue-500 text-lg leading-none select-none px-1 py-1 rounded hover:bg-blue-50" title="拖拽排序">⠿</span>
                          <el-tag>{{ answer.nickname || '匿名' }}</el-tag>
                          <el-tag v-if="answer.level" type="warning" size="small">Lv.{{ answer.level }}</el-tag>
                          <el-tag :type="answer.auditStatus === 1 ? 'success' : 'info'" size="small">
                            {{ answer.auditStatus === 1 ? '已审核' : '未审核' }}
                          </el-tag>
                          <el-tag type="primary" size="small">排序: {{ answer.sort ?? 0 }}</el-tag>
                        </div>
                        <div class="flex gap-1">
                          <el-button size="small" type="primary" link @click="openAnswerForm(answer)">编辑</el-button>
                          <el-button size="small" type="primary" link @click="selectAnswerForReply(answer)">回复管理</el-button>
                          <el-button size="small" type="danger" link @click="removeAnswer(answer)">删除</el-button>
                        </div>
                      </div>
                      <div class="ql-editor-content text-sm text-gray-600 line-clamp-3 mb-2" v-html="answer.content"></div>
                      <div class="text-xs text-gray-400">
                        <span>{{ answer.timeText }}</span>
                        <span v-if="answer.replyCount !== undefined" class="ml-3">{{ answer.replyCount }} 回复</span>
                      </div>
                    </div>
                  </template>
                </draggable>
                <div v-if="answerList.length === 0" class="text-center text-gray-400 py-8">暂无评论</div>
              </div>
            </el-tab-pane>

            <el-tab-pane label="回复管理" name="reply">
              <div class="edit-form-scroll">
                <div v-if="selectedAnswerForReply">
                  <div class="flex justify-between items-center mb-2">
                    <span class="text-sm text-gray-500">
                      回复管理 - 回答ID：{{ selectedAnswerForReply.ID }}（{{ selectedAnswerForReply.nickname }}）
                    </span>
                    <div class="flex items-center gap-2">
                    <span class="text-xs text-orange-400">点击卡片预览定位</span>
                    <span class="text-xs text-orange-400">拖拽手柄可排序</span>
                    <el-button type="primary" size="small" icon="plus" @click="openReplyForm()">新增回复</el-button>
                    </div>
                  </div>
                  <draggable v-model="replyList" group="reply" handle=".drag-handle" item-key="ID" class="space-y-2" @end="onReplyDragEnd">
                    <template #item="{ element: reply }">
                      <div class="reply-card mb-2 p-3 bg-yellow-50 rounded" @click="scrollToElement(`[data-reply-id=&quot;${reply.ID}&quot;]`)">
                        <div class="flex items-start justify-between mb-1">
                          <div class="flex items-center gap-2">
                            <span class="drag-handle cursor-grab text-gray-500 hover:text-blue-500 text-base leading-none select-none px-1 py-1 rounded hover:bg-blue-50" title="拖拽排序">⠿</span>
                            <el-tag size="small">{{ reply.nickname || '匿名' }}</el-tag>
                            <el-tag :type="reply.auditStatus === 1 ? 'success' : 'info'" size="small">
                              {{ reply.auditStatus === 1 ? '已审核' : '未审核' }}
                            </el-tag>
                            <el-tag type="primary" size="small">排序: {{ reply.sort ?? 0 }}</el-tag>
                          </div>
                          <div class="flex gap-1">
                            <el-button size="small" type="primary" link @click="openReplyForm(reply)">编辑</el-button>
                            <el-button size="small" type="danger" link @click="removeReply(reply)">删除</el-button>
                          </div>
                        </div>
                        <div class="ql-editor-content text-sm text-gray-600 line-clamp-2" v-html="reply.content"></div>
                        <div class="text-xs text-gray-400 mt-1">{{ reply.timeText }}</div>
                      </div>
                    </template>
                  </draggable>
                  <div v-if="replyList.length === 0" class="text-center text-gray-400 py-8">暂无回复</div>
                </div>
                <div v-else class="text-center text-gray-400 py-8">
                  请在"评论管理"标签页中点击回答的"回复管理"按钮
                </div>
              </div>
            </el-tab-pane>
          </el-tabs>
        </div>
        <div class="edit-body flex items-center justify-center text-gray-400" v-else>
          <div class="text-center">
            <el-icon :size="48"><EditPen /></el-icon>
            <p class="mt-4">请先选择一个页面进行编辑</p>
          </div>
        </div>
      </div>
    </div>

    <!-- 页面选择对话框 -->
    <el-dialog v-model="showQuestionSelector" title="选择页面" width="800px">
      <div class="mb-4">
        <el-form :inline="true" :model="search">
          <el-form-item label="所属分类">
            <el-select v-model="search.regionId" clearable filterable placeholder="选择分类" style="width: 160px">
              <el-option v-for="r in regionOptions" :key="r.ID" :label="r.name" :value="r.ID" />
            </el-select>
          </el-form-item>
          <el-form-item label="标题">
            <el-input v-model="search.title" clearable placeholder="标题关键词" style="width: 200px" />
          </el-form-item>
          <el-form-item>
            <el-button type="primary" @click="loadQuestionList">查询</el-button>
          </el-form-item>
        </el-form>
      </div>
      <el-table :data="questionTableData" style="width:100%" max-height="400" @row-click="onTableRowClick">
        <el-table-column prop="ID" label="ID" width="60" />
        <el-table-column prop="title" label="标题" min-width="200" show-overflow-tooltip />
        <el-table-column prop="answerCount" label="回答数" width="80" />
        <el-table-column prop="sort" label="排序" width="60" />
        <el-table-column label="操作" width="80">
          <template #default="{ row }">
            <el-button size="small" type="primary" link @click.stop="selectQuestion(row.ID)">选择</el-button>
          </template>
        </el-table-column>
      </el-table>
      <el-pagination class="mt-4" small background layout="total, prev, pager, next"
        :current-page="searchPage" :page-size="searchPageSize" :total="searchTotal"
        @current-change="(v) => { searchPage = v; loadQuestionList() }" />
    </el-dialog>

    <!-- 新增页面对话框 -->
    <el-dialog v-model="showCreateQuestion" title="新增页面" width="650px" @close="resetCreateForm">
      <el-form label-position="top" :model="createForm" size="small">
        <el-form-item label="所属分类">
          <el-select v-model="createForm.regionId" filterable clearable placeholder="请选择所属分类">
            <el-option v-for="r in regionOptions" :key="r.ID" :label="r.name" :value="r.ID" />
          </el-select>
        </el-form-item>
        <el-form-item label="提问标题" required>
          <el-input v-model="createForm.title" placeholder="必填" />
        </el-form-item>
        <el-form-item label="提问时间">
          <el-input v-model="createForm.timeAt" placeholder="例如：2天前,10分钟前,刚刚" />
        </el-form-item>
        <el-form-item label="备注">
          <el-input v-model="createForm.remark" placeholder="仅在后台显示" />
        </el-form-item>
        <el-form-item label="选择头像昵称（可选）">
          <el-select clearable filterable placeholder="选择已有头像昵称" style="width: 100%" @change="onCreateSelectAvatarNickname">
            <el-option v-for="item in avatarNicknameOptions" :key="item.ID" :label="item.nickname" :value="item" />
          </el-select>
        </el-form-item>
        <el-form-item label="提问昵称">
          <el-input v-model="createForm.nickname" placeholder="可手动输入" />
        </el-form-item>
        <el-form-item label="头像">
          <div class="flex items-center gap-3">
            <UploadImage v-model="createForm.avatarUrl" @on-success="(url) => createForm.avatarUrl = url"/>
            <img v-if="createForm.avatarUrl" :src="`${getBaseUrl()}/${createForm.avatarUrl}`" class="h-14 w-14 object-contain border rounded flex-shrink-0" />
          </div>
        </el-form-item>
        <el-form-item label="称号">
          <el-select v-model="createForm.titleName" clearable filterable allow-create placeholder="选填称号" style="width: 100%">
            <el-option v-for="item in titleOptions" :key="item.ID" :label="item.name" :value="item.name" />
          </el-select>
        </el-form-item>
        <el-form-item label="个性签名">
          <el-select v-model="createForm.signature" clearable filterable allow-create placeholder="选填" style="width: 100%">
            <el-option v-for="item in signatureOptions" :key="item.ID" :label="item.content" :value="item.content" />
          </el-select>
        </el-form-item>
        <el-form-item label="关注人数">
          <el-input-number v-model="createForm.followCount" :min="0" />
        </el-form-item>
        <el-form-item label="浏览人数">
          <el-input-number v-model="createForm.lookCount" :min="0" />
        </el-form-item>
        <el-form-item label="收藏人数">
          <el-input-number v-model="createForm.favoriteCount" :min="0" />
        </el-form-item>
        <el-form-item label="点赞人数">
          <el-input-number v-model="createForm.likeCount" :min="0" />
        </el-form-item>
        <el-form-item label="标签">
          <el-select v-model="createForm.label" clearable filterable multiple allow-create placeholder="选填标签" style="width: 100%">
            <el-option v-for="item in tagOptions" :key="item.ID" :label="item.name" :value="item.name" />
          </el-select>
        </el-form-item>
        <el-form-item label="排序">
          <el-input-number v-model="createForm.sort" :min="0" />
        </el-form-item>
        <el-form-item label="内容（客服昵称号码使用统一 ##昵称加号码## 代替，仅昵称使用统一 ##昵称## 代替，客服号码使用统一 ##号码## 代替；根据客服性别替换成他或她，使用统一 ##ta## 代替）" required>
          <RichEdit v-model="createForm.content" :height="300" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="showCreateQuestion = false">取消</el-button>
        <el-button type="primary" @click="submitCreateQuestion" :loading="createLoading">创建</el-button>
      </template>
    </el-dialog>

    <!-- 回答编辑对话框 -->
    <el-dialog v-model="showAnswerForm" :title="answerForm.ID ? '编辑回答' : '新增回答'" width="650px">
      <el-form label-position="top" :model="answerForm" size="small">
        <el-form-item label="选择头像昵称（可选）">
          <el-select clearable filterable placeholder="选择已有头像昵称" @change="(item) => { if(item) { answerForm.nickname = item.nickname; answerForm.avatarUrl = item.avatarUrl } }">
            <el-option v-for="item in avatarNicknameOptions" :key="item.ID" :label="item.nickname" :value="item" />
          </el-select>
        </el-form-item>
        <el-form-item label="昵称">
          <el-input v-model="answerForm.nickname" placeholder="可手动输入" />
        </el-form-item>
        <el-form-item label="头像">
          <div class="flex items-center gap-3">
            <UploadImage v-model="answerForm.avatarUrl" @on-success="(url) => answerForm.avatarUrl = url"/>
            <img v-if="answerForm.avatarUrl" :src="`${getBaseUrl()}/${answerForm.avatarUrl}`" class="h-14 w-14 object-contain border rounded flex-shrink-0" />
          </div>
        </el-form-item>
        <el-row :gutter="16">
          <el-col :span="12">
            <el-form-item label="称号">
              <el-select v-model="answerForm.titleName" clearable filterable allow-create placeholder="选填">
                <el-option v-for="item in titleOptions" :key="item.ID" :label="item.name" :value="item.name" />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="个性签名">
              <el-select v-model="answerForm.signature" clearable filterable allow-create placeholder="选填">
                <el-option v-for="item in signatureOptions" :key="item.ID" :label="item.content" :value="item.content" />
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="16">
          <el-col :span="8">
            <el-form-item label="等级">
              <el-input-number v-model="answerForm.level" :min="0" />
            </el-form-item>
          </el-col>
          <el-col :span="8">
            <el-form-item label="赞">
              <el-input-number v-model="answerForm.likeCount" :min="0" />
            </el-form-item>
          </el-col>
          <el-col :span="8">
            <el-form-item label="关注">
              <el-input-number v-model="answerForm.followCount" :min="0" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="16">
          <el-col :span="12">
            <el-form-item label="排序">
              <el-input-number v-model="answerForm.sort" :min="0" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="时间">
              <el-input v-model="answerForm.timeText" placeholder="例如：2天前,10分钟前,刚刚" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-form-item label="擅长">
          <el-input v-model="answerForm.skill" placeholder="例如：行程规划，私人定制" />
        </el-form-item>
        <el-form-item label="审核状态">
          <el-radio-group v-model="answerForm.auditStatus">
            <el-radio :label="1">已审核</el-radio>
            <el-radio :label="0">未审核</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="内容">
          <RichEdit v-model="answerForm.content" :height="250" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="showAnswerForm = false">取消</el-button>
        <el-button type="primary" @click="submitAnswer">保存</el-button>
      </template>
    </el-dialog>

    <!-- 回复编辑对话框 -->
    <el-dialog v-model="showReplyForm" :title="replyForm.ID ? '编辑回复' : '新增回复'" width="600px">
      <el-form label-position="top" :model="replyForm" size="small">
        <el-form-item label="选择头像昵称（可选）">
          <el-select clearable filterable placeholder="选择已有头像昵称" @change="(item) => { if(item) { replyForm.nickname = item.nickname; replyForm.avatarUrl = item.avatarUrl } }">
            <el-option v-for="item in avatarNicknameOptions" :key="item.ID" :label="item.nickname" :value="item" />
          </el-select>
        </el-form-item>
        <el-form-item label="昵称">
          <el-input v-model="replyForm.nickname" placeholder="可手动输入" />
        </el-form-item>
        <el-form-item label="头像">
          <div class="flex items-center gap-3">
            <UploadImage v-model="replyForm.avatarUrl" @on-success="(url) => replyForm.avatarUrl = url"/>
            <img v-if="replyForm.avatarUrl" :src="`${getBaseUrl()}/${replyForm.avatarUrl}`" class="h-14 w-14 object-contain border rounded flex-shrink-0" />
          </div>
        </el-form-item>
        <el-row :gutter="16">
          <el-col :span="12">
            <el-form-item label="称号">
              <el-select v-model="replyForm.titleName" clearable filterable allow-create placeholder="选填">
                <el-option v-for="item in titleOptions" :key="item.ID" :label="item.name" :value="item.name" />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="等级">
              <el-input-number v-model="replyForm.level" :min="0" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="16">
          <el-col :span="12">
            <el-form-item label="排序">
              <el-input-number v-model="replyForm.sort" :min="0" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="时间">
              <el-input v-model="replyForm.timeText" placeholder="例如：2天前,10分钟前,刚刚" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-form-item label="审核状态">
          <el-radio-group v-model="replyForm.auditStatus">
            <el-radio :label="1">已审核</el-radio>
            <el-radio :label="0">未审核</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="内容">
          <RichEdit v-model="replyForm.content" :height="200" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="showReplyForm = false">取消</el-button>
        <el-button type="primary" @click="submitReply">保存</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, nextTick } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { ChatLineSquare, EditPen } from '@element-plus/icons-vue'
import RichEdit from '@/components/richtext/rich-edit.vue'
import UploadImage from "@/components/upload/image.vue"
import {
  getQAQuestionList,
  getQAQuestionDetail,
  createQAQuestion,
  updateQAQuestion,
  getQAAnswerList,
  createQAAnswer,
  updateQAAnswer,
  deleteQAAnswer,
  getQAReplyList,
  createQAReply,
  updateQAReply,
  deleteQAReply,
  batchUpdateAnswerSort,
  batchUpdateReplySort,
  getRegionCategoryList,
  getAllEnabledQAAvatarNickname,
  getAllEnabledQATitle,
  getAllEnabledQASignature,
  getAllEnabledQATag
} from '@/api/promotion'
import { getBaseUrl } from '@/utils/format.js'
import draggable from 'vuedraggable'

const loading = ref(false)
const activeTab = ref('question')

// 页面选择
const selectedQuestionId = ref(null)
const showQuestionSelector = ref(false)
const search = ref({ regionId: null, title: '' })
const searchPage = ref(1)
const searchPageSize = ref(10)
const searchTotal = ref(0)
const questionTableData = ref([])
const questionOptions = ref([])

// 基础数据
const regionOptions = ref([])
const avatarNicknameOptions = ref([])
const titleOptions = ref([])
const signatureOptions = ref([])
const tagOptions = ref([])

// 页面详情（预览数据）
const questionDetail = ref({ ID: 0, title: '', label: [], content: '', nickname: '', avatarUrl: '', titleName: '', timeAt: '', answers: [] })

// 页面编辑表单
const questionForm = ref({ ID: 0, regionId: null, title: '', content: '', timeAt: '', remark: '', sort: 0, nickname: '', avatarUrl: '', titleName: '', signature: '', followCount: 0, lookCount: 0, favoriteCount: 0, likeCount: 0, label: [] })

// 新增页面
const showCreateQuestion = ref(false)
const createLoading = ref(false)
const createForm = ref({ ID: 0, regionId: null, title: '', content: '', timeAt: '', remark: '', sort: 0, nickname: '', avatarUrl: '', titleName: '', signature: '', followCount: 0, lookCount: 0, favoriteCount: 0, likeCount: 0, label: [] })

// 评论管理
const answerList = ref([])

// 回复管理
const selectedAnswerForReply = ref(null)
const replyList = ref([])

// 回答编辑
const showAnswerForm = ref(false)
const answerForm = ref({ ID: 0, questionId: 0, nickname: '', avatarUrl: '', titleName: '', signature: '', level: null, content: '', followCount: 0, favoriteCount: 0, likeCount: 0, sort: 0, timeText: '', skill: '', auditStatus: 1 })

// 回复编辑
const showReplyForm = ref(false)
const replyForm = ref({ ID: 0, answerId: 0, parentId: null, nickname: '', avatarUrl: '', titleName: '', signature: '', level: null, content: '', followCount: 0, favoriteCount: 0, likeCount: 0, sort: 0, timeText: '', skill: '', auditStatus: 1 })

const totalReplies = computed(() => {
  let count = 0
  for (const answer of questionDetail.value.answers || []) {
    count += (answer.replies || []).length
  }
  return count
})

const scrollToElement = (selector) => {
  nextTick(() => {
    const previewEl = document.querySelector('.preview-body')
    if (!previewEl) return
    const el = previewEl.querySelector(selector)
    if (el) {
      el.scrollIntoView({ behavior: 'smooth', block: 'center' })
    }
  })
}

// 加载基础数据
const loadBasicOptions = async () => {
  const [r, r1, r2, r3, r4] = await Promise.all([
    getRegionCategoryList({ page: 1, pageSize: 10000 }),
    getAllEnabledQAAvatarNickname(),
    getAllEnabledQATitle(),
    getAllEnabledQASignature(),
    getAllEnabledQATag(),
  ])
  if (r.code === 0) regionOptions.value = r.data.list || []
  if (r1.code === 0) avatarNicknameOptions.value = r1.data || []
  if (r2.code === 0) titleOptions.value = r2.data || []
  if (r3.code === 0) signatureOptions.value = r3.data || []
  if (r4.code === 0) tagOptions.value = r4.data || []
}
loadBasicOptions()

// 加载页面列表（用于选项）
const loadQuestionList = async () => {
  const params = { page: searchPage.value, pageSize: searchPageSize.value }
  if (search.value.regionId) params.regionId = search.value.regionId
  if (search.value.title) params.title = search.value.title
  const res = await getQAQuestionList(params)
  if (res.code === 0) {
    questionTableData.value = res.data.list || []
    searchTotal.value = res.data.total
  }
}

// 加载所有页面（用于下拉框）
const loadQuestionOptions = async () => {
  const res = await getQAQuestionList({ page: 1, pageSize: 10000 })
  if (res.code === 0) {
    questionOptions.value = res.data.list || []
  }
}
loadQuestionOptions()

// 选择页面
const onQuestionSelect = async (id) => {
  if (!id) return
  await selectQuestion(id)
}

const selectQuestion = async (id) => {
  selectedQuestionId.value = id
  showQuestionSelector.value = false
  await loadQuestionDetail()
  await loadAnswerList()
  activeTab.value = 'question'
}

const onTableRowClick = (row) => {
  selectQuestion(row.ID)
}

// 加载页面详情
const loadQuestionDetail = async () => {
  if (!selectedQuestionId.value) return
  loading.value = true
  try {
    const res = await getQAQuestionDetail(selectedQuestionId.value)
    if (res.code === 0 && res.data) {
      questionDetail.value = res.data
      // 同步到编辑表单
      const q = res.data
      questionForm.value = {
        ID: q.ID,
        regionId: q.regionId,
        title: q.title,
        content: q.content,
        timeAt: q.timeAt,
        remark: q.remark || '',
        sort: q.sort || 0,
        nickname: q.nickname || '',
        avatarUrl: q.avatarUrl || '',
        titleName: q.titleName || '',
        signature: q.signature || '',
        followCount: q.followCount || 0,
        lookCount: q.lookCount || 0,
        favoriteCount: q.favoriteCount || 0,
        likeCount: q.likeCount || 0,
        label: q.label || []
      }
    }
  } finally {
    loading.value = false
  }
}

// 刷新预览
const refreshPreview = () => {
  loadQuestionDetail()
}

// 新增页面
const openCreateQuestion = () => {
  createForm.value = { ID: 0, regionId: null, title: '', content: '', timeAt: '', remark: '', sort: 0, nickname: '', avatarUrl: '', titleName: '', signature: '', followCount: 0, lookCount: 0, favoriteCount: 0, likeCount: 0, label: [] }
  showCreateQuestion.value = true
}

const resetCreateForm = () => {
  createForm.value = { ID: 0, regionId: null, title: '', content: '', timeAt: '', remark: '', sort: 0, nickname: '', avatarUrl: '', titleName: '', signature: '', followCount: 0, lookCount: 0, favoriteCount: 0, likeCount: 0, label: [] }
}

const onCreateSelectAvatarNickname = (item) => {
  if (item) {
    createForm.value.nickname = item.nickname
    createForm.value.avatarUrl = item.avatarUrl
  }
}

const submitCreateQuestion = async () => {
  if (!createForm.value.title || !createForm.value.content) {
    ElMessage.error('请填写标题与内容')
    return
  }
  createLoading.value = true
  try {
    const res = await createQAQuestion(createForm.value)
    if (res.code === 0) {
      ElMessage.success('创建成功')
      showCreateQuestion.value = false
      await loadQuestionOptions()
      selectedQuestionId.value = res.data.ID
      await selectQuestion(res.data.ID)
    }
  } finally {
    createLoading.value = false
  }
}

// 保存页面
const submitQuestion = async () => {
  if (!questionForm.value.title || !questionForm.value.content) {
    ElMessage.error('请填写标题与内容')
    return
  }
  const res = await updateQAQuestion(questionForm.value)
  if (res.code === 0) {
    ElMessage.success('保存成功')
    await loadQuestionDetail()
    await loadQuestionOptions()
  }
}

// 选择头像昵称
const onSelectQuestionAvatarNickname = (item) => {
  if (item) {
    questionForm.value.nickname = item.nickname
    questionForm.value.avatarUrl = item.avatarUrl
  }
}

// 加载回答列表
const loadAnswerList = async () => {
  if (!selectedQuestionId.value) return
  const res = await getQAAnswerList({ questionId: selectedQuestionId.value, page: 1, pageSize: 100 })
  if (res.code === 0) {
    answerList.value = res.data.list || []
  }
}

// 回答编辑
const openAnswerForm = (row) => {
  answerForm.value = row
    ? { ...row }
    : { ID: 0, questionId: selectedQuestionId.value, nickname: '', avatarUrl: '', titleName: '', signature: '', level: null, content: '', followCount: 0, favoriteCount: 0, likeCount: 0, sort: 0, timeText: '', skill: '', auditStatus: 1 }
  if (row) {
    scrollToElement(`[data-answer-id="${row.ID}"]`)
  }
  showAnswerForm.value = true
}

const onAnswerDragEnd = async () => {
  const items = answerList.value.map((item, index) => ({
    id: item.ID,
    sort: (answerList.value.length - index) * 10
  }))
  const res = await batchUpdateAnswerSort(items)
  if (res.code === 0) {
    ElMessage.success('排序更新成功')
    await loadAnswerList()
    await loadQuestionDetail()
  }
}

const onReplyDragEnd = async () => {
  const items = replyList.value.map((item, index) => ({
    id: item.ID,
    sort: (replyList.value.length - index) * 10
  }))
  const res = await batchUpdateReplySort(items)
  if (res.code === 0) {
    ElMessage.success('排序更新成功')
    await loadReplyList()
    await loadQuestionDetail()
  }
}

const submitAnswer = async () => {
  if (!answerForm.value.content) {
    ElMessage.error('请填写回答内容')
    return
  }
  const res = answerForm.value.ID
    ? await updateQAAnswer(answerForm.value)
    : await createQAAnswer(answerForm.value)
  if (res.code === 0) {
    ElMessage.success('保存成功')
    showAnswerForm.value = false
    await loadAnswerList()
    await loadQuestionDetail()
    activeTab.value = 'answer'
  }
}

const removeAnswer = async (row) => {
  await ElMessageBox.confirm('确认删除该回答？', '提示')
  const res = await deleteQAAnswer({ ID: row.ID })
  if (res.code === 0) {
    ElMessage.success('删除成功')
    await loadAnswerList()
    await loadQuestionDetail()
  }
}

// 选择回答查看回复
const selectAnswerForReply = async (answer) => {
  selectedAnswerForReply.value = answer
  activeTab.value = 'reply'
  await loadReplyList()
  scrollToElement(`[data-answer-id="${answer.ID}"]`)
}

// 加载回复列表
const loadReplyList = async () => {
  if (!selectedAnswerForReply.value) return
  const res = await getQAReplyList({ answerId: selectedAnswerForReply.value.ID, page: 1, pageSize: 100 })
  if (res.code === 0) {
    replyList.value = res.data.list || []
  }
}

// 回复编辑
const openReplyForm = (row) => {
  replyForm.value = row
    ? { ...row }
    : { ID: 0, answerId: selectedAnswerForReply.value.ID, parentId: null, nickname: '', avatarUrl: '', titleName: '', signature: '', level: null, content: '', followCount: 0, favoriteCount: 0, likeCount: 0, sort: 0, timeText: '', skill: '', auditStatus: 1 }
  if (row) {
    scrollToElement(`[data-reply-id="${row.ID}"]`)
  }
  showReplyForm.value = true
}

const submitReply = async () => {
  if (!replyForm.value.content) {
    ElMessage.error('请填写回复内容')
    return
  }
  const res = replyForm.value.ID
    ? await updateQAReply(replyForm.value)
    : await createQAReply(replyForm.value)
  if (res.code === 0) {
    ElMessage.success('保存成功')
    showReplyForm.value = false
    await loadReplyList()
    await loadQuestionDetail()
  }
}

const removeReply = async (row) => {
  await ElMessageBox.confirm('确认删除该回复？', '提示')
  const res = await deleteQAReply({ ID: row.ID })
  if (res.code === 0) {
    ElMessage.success('删除成功')
    await loadReplyList()
    await loadQuestionDetail()
  }
}
</script>

<style scoped>
.page-visual-container {
  height: calc(100vh - 120px);
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.top-bar {
  background: #fff;
  border-radius: 8px;
  padding: 12px 20px;
  box-shadow: 0 1px 3px rgba(0,0,0,0.06);
  flex-shrink: 0;
}

.top-bar-inner {
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.main-content {
  flex: 1;
  display: flex;
  gap: 12px;
  overflow: hidden;
}

.preview-panel {
  flex: 1;
  background: #fff;
  border-radius: 8px;
  box-shadow: 0 1px 3px rgba(0,0,0,0.06);
  display: flex;
  flex-direction: column;
  overflow: hidden;
  min-width: 0;
}

.edit-panel {
  flex: 1;
  background: #fff;
  border-radius: 8px;
  box-shadow: 0 1px 3px rgba(0,0,0,0.06);
  display: flex;
  flex-direction: column;
  overflow: hidden;
  min-width: 0;
}

.panel-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 12px 16px;
  border-bottom: 1px solid #f0f0f0;
  flex-shrink: 0;
}

.panel-title {
  font-size: 15px;
  font-weight: 600;
  color: #333;
}

.preview-body {
  flex: 1;
  overflow-y: auto;
  padding: 16px;
}

.edit-body {
  flex: 1;
  overflow: hidden;
}

.edit-body :deep(.el-tabs) {
  height: 100%;
  display: flex;
  flex-direction: column;
}

.edit-body :deep(.el-tabs__content) {
  flex: 1;
  overflow: hidden;
}

.edit-body :deep(.el-tab-pane) {
  height: 100%;
}

.edit-form-scroll {
  height: 100%;
  overflow-y: auto;
  padding: 12px 16px;
}

.answer-card {
  border: 1px solid #e8e8e8;
  transition: border-color 0.2s;
}

.answer-card:hover {
  border-color: #409eff;
}

.reply-card {
  border: 1px solid #f0e6b8;
}

.line-clamp-3 {
  display: -webkit-box;
  -webkit-line-clamp: 3;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.line-clamp-2 {
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.preview-body :deep(.ql-editor-content img) {
  max-width: 100%;
  height: auto;
}
</style>
