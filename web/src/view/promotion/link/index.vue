<template>
  <div>
    <div class="gva-search-box">
      <el-form :inline="true" :model="search">
        <el-form-item label="推广平台">
          <el-select v-model="search.platformId" clearable filterable placeholder="选择平台" style="width: 180px">
            <el-option v-for="p in platformOptions" :key="p.ID" :label="p.name" :value="p.ID" />
          </el-select>
        </el-form-item>
        <el-form-item label="所属分类">
          <el-select v-model="search.regionId" clearable filterable placeholder="选择所属分类" style="width: 180px">
            <el-option v-for="r in regionOptions" :key="r.ID" :label="r.name" :value="r.ID" />
          </el-select>
        </el-form-item>
        <el-form-item label="分组">
          <el-select v-model="search.groupId" clearable filterable placeholder="选择分组" style="width: 180px">
            <el-option v-for="g in groupOptions" :key="g.ID" :label="g.name" :value="g.ID" />
          </el-select>
        </el-form-item>
        <el-form-item label="域名">
          <el-select v-model="search.domainId" clearable filterable placeholder="选择域名" style="width: 220px">
            <el-option v-for="d in domainOptions" :key="d.ID" :label="d.domain" :value="d.ID" />
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
        <el-button type="primary" icon="plus" @click="openForm()">新增</el-button>
      </div>
      <el-table :data="tableData" row-key="ID" style="width:100%">
        <el-table-column prop="ID" label="ID" width="80" />
        <el-table-column label="推广平台" width="140">
          <template #default="{ row }">
            {{ (platformOptions.find(p => p.ID === row.platformId) || {}).name || row.platformId }}
          </template>
        </el-table-column>
        <el-table-column label="所属分类" min-width="160">
          <template #default="{ row }">
            {{ (regionOptions.find(r => r.ID === row.regionId) || {}).name || row.regionId }}
          </template>
        </el-table-column>
        <el-table-column label="分组" min-width="160">
          <template #default="{ row }">
            {{ (groupOptions.find(g => g.ID === row.groupId) || {}).name || row.groupId }}
          </template>
        </el-table-column>
        <el-table-column label="域名" min-width="220" show-overflow-tooltip>
          <template #default="{ row }">
            {{ (domainOptions.find(d => d.ID === row.domainId) || {}).domain || row.domainId }}
          </template>
        </el-table-column>

        <el-table-column label="客服" width="100">
          <template #default="{ row }">
            <el-button type="primary" link @click="openServiceDialog(row)">
              {{ row.serviceOnlineCount || 0 }}/{{ row.serviceCount || 0 }}
            </el-button>
          </template>
        </el-table-column>

        <el-table-column prop="remark" label="备注" width="100" />
        <el-table-column label="数据" width="240">
          <template #default="{ row }">
            <div class="flex justify-between text-sm">
              <span>昨访问 {{ row.yesterdayVisitCount || 0 }}</span>
              <span>今访问 {{ row.todayVisitCount || 0 }}</span>
            </div>
            <div class="flex justify-between text-sm">
              <span>昨复制 {{ row.yesterdayCopyCount || 0 }}</span>
              <span>今复制 {{ row.todayCopyCount || 0 }}</span>
            </div>
            <div class="flex justify-between text-sm">
              <span>昨点获客链接 {{ row.yesterdayAssistClickCount || 0 }}</span>
              <span>今点获客链接 {{ row.todayAssistClickCount || 0 }}</span>
            </div>
            <div class="flex justify-between text-sm">
              <span>昨回传 {{ row.yesterdayOcpcCallbackCount || 0 }}</span>
              <span>今回传 {{ row.todayOcpcCallbackCount || 0 }}</span>
            </div>
          </template>
        </el-table-column>
<!--        <el-table-column prop="inquiryCount" label="咨询" width="80" />-->
<!--        <el-table-column prop="conversionCount" label="转化" width="80" />-->
<!--        <el-table-column prop="followCount" label="到粉" width="80" />-->
<!--        <el-table-column prop="sort" label="排序" width="100" />-->
        <el-table-column fixed="right" label="操作" width="280">
          <template #default="{ row }">
            <el-button type="primary" link @click="openForm(row)">编辑</el-button>
            <el-button type="primary" link @click="openBasic(row)">基本设置</el-button>
            <el-button type="primary" link @click="openCompany(row)">资质公司</el-button>
            <el-button type="info" link @click="openOcpc(row)">OCPC</el-button>
            <br>
            <el-button type="success" link @click="showLink(row)">推广链接</el-button>
            <el-tooltip content="请先设置好「基本设置」和「资质公司」两个选项，才能发布更新" placement="top">
              <el-button type="warning" link @click="publishLink(row)">发布更新</el-button>
            </el-tooltip>
            <el-badge :value="unprocessedMsgMap[row.ID] || 0" :hidden="!unprocessedMsgMap[row.ID]" class="mr-2">
              <el-button type="success" link @click="openMessage(row)">留言信息</el-button>
            </el-badge>
            <el-button type="primary" link @click="remove(row)">删除</el-button>
            <!--            <el-button type="primary" link @click="openCode(row)">代码设置</el-button>-->
            <!--            <el-button type="primary" link @click="openTheme(row)">颜色调整</el-button>-->
            <!--            <el-button type="primary" link @click="openComment(row)">评论设置</el-button>-->
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
        <el-form-item label="推广平台">
          <el-select v-model="form.platformId" filterable clearable placeholder="请选择平台">
            <el-option v-for="p in platformOptions" :key="p.ID" :label="p.name" :value="p.ID" />
          </el-select>
        </el-form-item>
        <el-form-item label="所属分类">
          <el-select v-model="form.regionId" filterable clearable placeholder="请选择所属分类">
            <el-option v-for="r in regionOptions" :key="r.ID" :label="r.name" :value="r.ID" />
          </el-select>
        </el-form-item>
        <el-form-item label="分组">
          <el-select v-model="form.groupId" filterable clearable placeholder="请选择分组">
            <el-option v-for="g in groupOptions" :key="g.ID" :label="g.name" :value="g.ID" />
          </el-select>
        </el-form-item>
        <el-form-item label="域名">
          <el-select v-model="form.domainId" filterable clearable placeholder="请选择域名">
            <el-option v-for="d in domainOptions" :key="d.ID" :label="d.domain" :value="d.ID" />
          </el-select>
        </el-form-item>
        <el-form-item label="选择提问">
          <el-select v-model="form.questionId" filterable clearable placeholder="请选择提问">
            <el-option v-for="q in qaQuestionOptions" :key="q.ID" :label="q.title" :value="q.ID" />
          </el-select>
        </el-form-item>

        <el-form-item label="排序">
          <el-input-number v-model="form.sort" />
        </el-form-item>
        <el-form-item label="备注">
          <el-input type="textarea" v-model="form.remark" />
        </el-form-item>
      </el-form>
    </el-drawer>
    <el-drawer v-model="drawerBasic" :show-close="false" size="600">
      <template #header>
        <div class="flex justify-between items-center">
          <span class="text-lg">基本设置</span>
          <div>
            <el-button @click="drawerBasic=false">取消</el-button>
            <el-button type="primary" @click="submitBasic">保存</el-button>
          </div>
        </div>
      </template>
      <el-form label-position="left" label-width="160px" :model="basic">
        <el-form-item label="手机端模板">
          <el-select v-model="basic.templateMobileId" clearable filterable placeholder="请选择手机端模板" style="width: 300px">
            <el-option v-for="item in mobileTemplateOptions" :key="item.ID" :label="item.name" :value="item.ID" />
          </el-select>
          <el-image
            v-if="getPreviewImage(mobileTemplateOptions, basic.templateMobileId)"
            :src="getBaseUrl() + '/' + getPreviewImage(mobileTemplateOptions, basic.templateMobileId)"
            style="width: 40px; height: 40px; margin-left: 8px; border-radius: 4px; cursor: pointer; vertical-align: middle;"
            fit="cover"
            @click="showPreview(mobileTemplateOptions, basic.templateMobileId)"
          />
          <el-button type="primary" link class="ml-2" @click="showPreview(mobileTemplateOptions, basic.templateMobileId)">预览</el-button>
        </el-form-item>
        <el-form-item label="电脑端模板">
          <el-select v-model="basic.templatePcId" clearable filterable placeholder="请选择电脑端模板" style="width: 300px">
            <el-option v-for="item in pcTemplateOptions" :key="item.ID" :label="item.name" :value="item.ID" />
          </el-select>
          <el-image
            v-if="getPreviewImage(pcTemplateOptions, basic.templatePcId)"
            :src="getBaseUrl() + '/' + getPreviewImage(pcTemplateOptions, basic.templatePcId)"
            style="width: 40px; height: 40px; margin-left: 8px; border-radius: 4px; cursor: pointer; vertical-align: middle;"
            fit="cover"
            @click="showPreview(pcTemplateOptions, basic.templatePcId)"
          />
          <el-button type="primary" link class="ml-2" @click="showPreview(pcTemplateOptions, basic.templatePcId)">预览</el-button>
        </el-form-item>
        <el-form-item label="手机复制插件">
          <el-select v-model="basic.mobileCopyWidgetId" clearable filterable placeholder="请选择手机复制插件" style="width: 300px">
            <el-option v-for="item in copyWidgetOptions" :key="item.ID" :label="item.name" :value="item.ID" />
          </el-select>
          <el-image
            v-if="getPreviewImage(copyWidgetOptions, basic.mobileCopyWidgetId)"
            :src="getBaseUrl() + '/' + getPreviewImage(copyWidgetOptions, basic.mobileCopyWidgetId)"
            style="width: 40px; height: 40px; margin-left: 8px; border-radius: 4px; cursor: pointer; vertical-align: middle;"
            fit="cover"
            @click="showPreview(copyWidgetOptions, basic.mobileCopyWidgetId)"
          />
          <el-button type="primary" link class="ml-2" @click="showPreview(copyWidgetOptions, basic.mobileCopyWidgetId)">预览</el-button>
        </el-form-item>
        <el-form-item label="手机底部插件">
          <el-select v-model="basic.mobileBottomWidgetId" clearable filterable placeholder="请选择手机底部插件" style="width: 300px">
            <el-option v-for="item in bottomWidgetOptions" :key="item.ID" :label="item.name" :value="item.ID" />
          </el-select>
          <el-image
            v-if="getPreviewImage(bottomWidgetOptions, basic.mobileBottomWidgetId)"
            :src="getBaseUrl() + '/' + getPreviewImage(bottomWidgetOptions, basic.mobileBottomWidgetId)"
            style="width: 40px; height: 40px; margin-left: 8px; border-radius: 4px; cursor: pointer; vertical-align: middle;"
            fit="cover"
            @click="showPreview(bottomWidgetOptions, basic.mobileBottomWidgetId)"
          />
          <el-button type="primary" link class="ml-2" @click="showPreview(bottomWidgetOptions, basic.mobileBottomWidgetId)">预览</el-button>
        </el-form-item>
        <el-form-item label="电脑端二维码插件">
          <el-select v-model="basic.pcQrcodeWidgetId" clearable filterable placeholder="请选择电脑端二维码插件" style="width: 300px">
            <el-option v-for="item in qrcodeWidgetOptions" :key="item.ID" :label="item.name" :value="item.ID" />
          </el-select>
          <el-image
            v-if="getPreviewImage(qrcodeWidgetOptions, basic.pcQrcodeWidgetId)"
            :src="getBaseUrl() + '/' + getPreviewImage(qrcodeWidgetOptions, basic.pcQrcodeWidgetId)"
            style="width: 40px; height: 40px; margin-left: 8px; border-radius: 4px; cursor: pointer; vertical-align: middle;"
            fit="cover"
            @click="showPreview(qrcodeWidgetOptions, basic.pcQrcodeWidgetId)"
          />
          <el-button type="primary" link class="ml-2" @click="showPreview(qrcodeWidgetOptions, basic.pcQrcodeWidgetId)">预览</el-button>
        </el-form-item>
        <el-form-item label="优先使用获客助手链接">
          <el-switch v-model="basic.preferCustomerAssist" active-text="是" inactive-text="否" />
          <span class="ml-4 text-gray-500">开启后跳转到添加企业微信账号</span>
        </el-form-item>
        <el-form-item label="显示12301投诉电话">
          <el-switch v-model="basic.show12301Phone" active-text="是" inactive-text="否" />
          <span class="ml-4 text-gray-500">开启后落地页上显示投诉电话</span>
        </el-form-item>
        <el-form-item label="移动端显示二维码">
          <el-switch v-model="basic.mobileShowQrcode" active-text="是" inactive-text="否" />
          <span class="ml-4 text-gray-500">开启后移动端显示微信二维码</span>
        </el-form-item>
        <el-form-item label="电脑端右侧二维码">
          <el-switch v-model="basic.pcShowRightQrcode" active-text="是" inactive-text="否" />
          <span class="ml-4 text-gray-500">开启后电脑端右侧显示二维码</span>
        </el-form-item>
        <el-form-item label="自动判断移动电脑端">
          <el-switch v-model="basic.autoDetectDevice" active-text="是" inactive-text="否" />
          <span class="ml-4 text-gray-500">开启自动跳转</span>
        </el-form-item>
        <el-divider />
        <el-form-item label="SEO标题">
          <el-input v-model="basic.seoTitle" placeholder="请输入SEO标题" maxlength="255" show-word-limit />
          <span class="ml-4 text-gray-500">页面标题，建议60字符以内</span>
        </el-form-item>
        <el-form-item label="SEO关键词">
          <el-input v-model="basic.seoKeywords" type="textarea" placeholder="请输入SEO关键词，多个关键词用逗号分隔" maxlength="500" show-word-limit :rows="3" />
          <span class="ml-4 text-gray-500">多个关键词用逗号分隔，建议5-10个关键词</span>
        </el-form-item>
        <el-form-item label="SEO描述">
          <el-input v-model="basic.seoDescription" type="textarea" placeholder="请输入SEO描述" maxlength="500" show-word-limit :rows="3" />
          <span class="ml-4 text-gray-500">页面描述，建议120-160字符</span>
        </el-form-item>
      </el-form>
    </el-drawer>
    <el-drawer v-model="drawerCompany" :show-close="false">
      <template #header>
        <div class="flex justify-between items-center">
          <span class="text-lg">资质公司</span>
          <div>
            <el-button @click="drawerCompany=false">取消</el-button>
            <el-button type="primary" @click="submitCompany">保存</el-button>
          </div>
        </div>
      </template>
      <el-form label-position="top" :model="company">
        <el-form-item label="公司名称">
          <el-input v-model="company.companyName" />
        </el-form-item>
        <el-form-item label="ICP备案号">
          <el-input v-model="company.icpRecordNo" />
        </el-form-item>
        <el-form-item label="许可证号">
          <el-input v-model="company.licenseNo" />
        </el-form-item>
        <el-form-item label="首页链接">
          <el-input v-model="company.homepageUrl" />
        </el-form-item>
        <el-form-item label="关于我们链接">
          <el-input v-model="company.aboutUrl" />
        </el-form-item>
        <el-form-item label="PC LOGO">
          <div class="flex items-center space-x-4">
            <UploadImage v-model="company.logoPcUrl" @on-success="handleLogoPcUrlSuccess"/>
            <img v-if="company.logoPcUrl" :src="`${getBaseUrl()}/${company.logoPcUrl}`" class="h-16 w-16 object-contain border rounded" />
          </div>
        </el-form-item>
        <el-form-item label="移动 LOGO">
          <div class="flex items-center space-x-4">
            <UploadImage v-model="company.logoMobileUrl" @on-success="handleLogoMobileUrlSuccess"/>
            <img v-if="company.logoMobileUrl" :src="`${getBaseUrl()}/${company.logoMobileUrl}`" class="h-16 w-16 object-contain border rounded" />
          </div>
        </el-form-item>
      </el-form>
    </el-drawer>
    <el-drawer v-model="drawerCode" :show-close="false" size="60%">
      <template #header>
        <div class="flex justify-between items-center">
          <span class="text-lg">代码设置</span>
          <div>
            <el-button @click="drawerCode=false">取消</el-button>
            <el-button type="primary" @click="submitCode">保存</el-button>
          </div>
        </div>
      </template>
      <el-form label-position="top" :model="codeCfg">
        <el-form-item label="统计-顶部代码">
          <el-input v-model="codeCfg.statHeaderHtml" type="textarea" rows="6" />
        </el-form-item>
        <el-form-item label="统计-底部代码">
          <el-input v-model="codeCfg.statFooterHtml" type="textarea" rows="6" />
        </el-form-item>
        <el-form-item label="转化代码">
          <el-input v-model="codeCfg.conversionScript" type="textarea" rows="6" />
        </el-form-item>
        <el-form-item label="CSS 样式">
          <el-input v-model="codeCfg.cssStyleText" type="textarea" rows="6" />
        </el-form-item>
      </el-form>
    </el-drawer>
    <el-drawer v-model="drawerTheme" :show-close="false">
      <template #header>
        <div class="flex justify-between items-center">
          <span class="text-lg">颜色调整</span>
          <div>
            <el-button @click="drawerTheme=false">取消</el-button>
            <el-button type="primary" @click="submitTheme">保存</el-button>
          </div>
        </div>
      </template>
      <el-form label-position="top" :model="theme">
        <el-form-item label="微信/电话颜色">
          <el-color-picker v-model="theme.colorWechatPhone" show-alpha />
        </el-form-item>
        <el-form-item label="客服名称颜色">
          <el-color-picker v-model="theme.colorServiceName" show-alpha />
        </el-form-item>
        <el-form-item label="版权颜色">
          <el-color-picker v-model="theme.colorCopyright" show-alpha />
        </el-form-item>
        <el-form-item label="一键加粗">
          <el-switch v-model="theme.boldAll" />
        </el-form-item>
      </el-form>
    </el-drawer>
    <el-drawer v-model="drawerComment" :show-close="false">
      <template #header>
        <div class="flex justify-between items-center">
          <span class="text-lg">评论设置</span>
          <div>
            <el-button @click="drawerComment=false">取消</el-button>
            <el-button type="primary" @click="submitComment">保存</el-button>
          </div>
        </div>
      </template>
      <el-form label-position="top" :model="comment">
        <el-form-item label="开启评论">
          <el-switch v-model="comment.enableComment" />
        </el-form-item>
        <el-form-item label="权限">
          <el-select v-model="comment.permission">
            <el-option label="手机登录可评" value="mobile_login" />
            <el-option label="游客可评" value="guest" />
          </el-select>
        </el-form-item>
      </el-form>
    </el-drawer>

    <!-- 推广链接弹窗 -->
    <el-dialog v-model="linkDialogVisible" title="推广链接" width="600px">
      <el-form label-width="100px">
        <el-form-item label="移动端链接">
          <el-input :value="formatLinkUrl(currentLink.mobileUrl)" readonly>
            <template #append>
              <el-button @click="copyLink(formatLinkUrl(currentLink.mobileUrl))">复制</el-button>
            </template>
          </el-input>
        </el-form-item>
        <el-form-item label="PC端链接">
          <el-input :value="formatLinkUrl(currentLink.pcUrl)" readonly>
            <template #append>
              <el-button @click="copyLink(formatLinkUrl(currentLink.pcUrl))">复制</el-button>
            </template>
          </el-input>
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="linkDialogVisible = false">关闭</el-button>
      </template>
    </el-dialog>

    <!-- OCPC配置弹窗 -->
    <el-dialog v-model="ocpcDialogVisible" title="OCPC配置" width="600px">
      <el-form label-width="120px" :model="ocpcForm">
        <el-form-item label="推广平台">
          <el-select v-model="ocpcForm.platformId" disabled filterable placeholder="推广平台不可修改">
            <el-option v-for="p in platformOptions" :key="p.ID" :label="p.name" :value="p.ID" />
          </el-select>
        </el-form-item>
        <el-form-item label="Key">
          <el-input v-model="ocpcForm.ocpcKey" placeholder="请输入Key或Token" />
        </el-form-item>
        <el-form-item label="Secret">
          <el-input v-model="ocpcForm.ocpcSecret" placeholder="请输入Secret" />
        </el-form-item>
        <el-form-item label="转化类型">
          <el-select v-model="ocpcForm.ocpcConversionType" placeholder="请选择转化类型">
            <el-option label="微信复制按钮点击" :value="35" />
            <el-option label="表单提交成功(线索转化)" :value="3" />
            <el-option label="注册激活后登录（注册转化）" :value="49" />
            <el-option label="客户自定义类型" :value="27" />
            <el-option label="有效咨询" :value="19" />
            <el-option label="电话拨通" :value="30" />
          </el-select>
        </el-form-item>
        <el-form-item label="回传方式">
          <el-select v-model="ocpcForm.ocpcCallbackType" placeholder="请选择回传方式">
            <el-option label="手动回传" :value="1" />
            <el-option label="自动回传" :value="2" />
          </el-select>
        </el-form-item>
        <el-form-item label="浏览时长大于" v-if="ocpcForm.ocpcCallbackType === 2">
          <el-input-number v-model="ocpcForm.ocpcMinDuration" :min="0" :max="3600" style="width: 180px" />
          <span style="margin-left: 8px; color: #999;">秒</span>
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="ocpcDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="saveOcpc">保存</el-button>
       </template>
     </el-dialog>

     <!-- 留言信息弹窗 -->
     <el-dialog v-model="messageDialogVisible" title="留言信息" width="1000px" @open="getMessageList">
       <el-form :inline="true" :model="messageSearch" class="mb-4">
         <el-form-item label="IP">
           <el-input v-model="messageSearch.ip" placeholder="请输入IP" />
         </el-form-item>
         <el-form-item label="手机号">
           <el-input v-model="messageSearch.phone" placeholder="请输入手机号" />
         </el-form-item>
         <el-form-item label="时间范围">
           <el-date-picker v-model="messageSearch.dateRange" type="daterange" range-separator="至" start-placeholder="开始日期" end-placeholder="结束日期" />
         </el-form-item>
         <el-form-item label="是否已处理">
           <el-select v-model="messageSearch.processed" clearable placeholder="全部" style="width:120px">
             <el-option label="未处理" :value="0" />
             <el-option label="已处理" :value="1" />
           </el-select>
         </el-form-item>
         <el-form-item>
           <el-button type="primary" @click="getMessageList">查询</el-button>
           <el-button @click="resetMessageSearch">重置</el-button>
         </el-form-item>
       </el-form>
       <div class="mb-2">
         <el-button type="primary" :disabled="!messageSelectedIds.length" @click="batchMarkProcessed(true)">批量标为已处理</el-button>
         <el-button type="warning" :disabled="!messageSelectedIds.length" @click="batchMarkProcessed(false)">批量标为未处理</el-button>
         <el-button type="success" @click="markAllProcessed">全部标记已处理</el-button>
         <span class="ml-4 text-gray-500">未处理：{{ messageUnprocessedTotal }}</span>
       </div>
       <el-table :data="messageList" style="width:100%" @selection-change="handleMessageSelectionChange">
         <el-table-column type="selection" width="55" />
         <el-table-column prop="phone" label="手机号" width="130" />
         <el-table-column prop="content" label="留言内容" show-overflow-tooltip />
         <el-table-column prop="userAgent" label="设备信息" show-overflow-tooltip />
         <el-table-column prop="ip" label="IP" />
         <el-table-column prop="CreatedAt" label="提交时间" width="180" />
         <el-table-column label="已处理" width="100" align="center">
           <template #default="{ row }">
             <el-switch
               v-model="row.processed"
               active-text="是"
               inactive-text="否"
               @change="handleMessageProcessedChange(row)"
             />
           </template>
         </el-table-column>
       </el-table>
       <el-pagination
         class="mt-4"
         background
         layout="total, sizes, prev, pager, next, jumper"
         :current-page="messagePage"
         :page-size="messagePageSize"
         :total="messageTotal"
         @size-change="handleMessageSizeChange"
         @current-change="handleMessageCurrentChange"
       />
     </el-dialog>

      <!-- 登录信息弹窗 -->
      <el-dialog v-model="phoneDialogVisible" title="登录信息" width="800px">
        <el-form :inline="true" :model="phoneSearch" class="mb-4">
          <el-form-item label="IP">
            <el-input v-model="phoneSearch.ip" placeholder="请输入IP" />
          </el-form-item>
          <el-form-item label="手机号">
            <el-input v-model="phoneSearch.phone" placeholder="请输入手机号" />
          </el-form-item>
          <el-form-item label="时间范围">
            <el-date-picker v-model="phoneSearch.dateRange" type="daterange" range-separator="至" start-placeholder="开始日期" end-placeholder="结束日期" />
          </el-form-item>
          <el-form-item>
            <el-button type="primary" @click="getPhoneList">查询</el-button>
            <el-button @click="resetPhoneSearch">重置</el-button>
          </el-form-item>
        </el-form>
        <el-table :data="phoneList" style="width:100%">
          <el-table-column prop="phone" label="手机号" width="150" />
          <el-table-column prop="ip" label="IP"  />
          <el-table-column prop="CreatedAt" label="提交时间" />
        </el-table>
        <el-pagination
          class="mt-4"
          background
          layout="total, sizes, prev, pager, next, jumper"
          :current-page="phonePage"
          :page-size="phonePageSize"
          :total="phoneTotal"
          @size-change="handlePhoneSizeChange"
          @current-change="handlePhoneCurrentChange"
        />
      </el-dialog>

      <!-- 客服管理弹窗 -->
      <el-dialog v-model="serviceDialogVisible" title="客服管理" width="800px">
        <el-table :data="serviceList" style="width:100%">
          <el-table-column prop="realName" label="姓名" width="120" />
          <el-table-column prop="nickname" label="昵称" width="120" />
          <el-table-column prop="wechat" label="微信号" width="150" />
          <el-table-column prop="mobile" label="手机号" width="130" />
          <el-table-column label="状态" width="150">
            <template #default="{ row }">
              <el-switch
                v-model="row.status"
                :active-value="1"
                :inactive-value="2"
                active-text="在线"
                inactive-text="离线"
                @change="handleStatusChange(row)"
              />
            </template>
          </el-table-column>
          <el-table-column prop="remark" label="备注" show-overflow-tooltip />
        </el-table>
        <div class="mt-4 text-gray-500 text-sm">
          提示：切换开关可设置客服在线/离线状态
        </div>
      </el-dialog>

    <!-- 预览图片弹窗 -->
    <el-dialog v-model="previewVisible" title="预览" width="auto" :close-on-click-modal="true" align-center>
      <div class="flex justify-center items-center">
        <el-image
          v-if="previewUrl"
          :src="previewUrl"
          style="max-width: 80vw; max-height: 80vh"
          fit="contain"
        />
      </div>
    </el-dialog>
    </div>
  </template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage, ElMessageBox } from 'element-plus'
const router = useRouter()
import {
  getPromotionLinkList, createPromotionLink, updatePromotionLink, deletePromotionLink,
  getLinkBasic, upsertLinkBasic,
  getLinkCompany, upsertLinkCompany,
  getLinkCode, upsertLinkCode,
  getLinkTheme, upsertLinkTheme,
  getLinkComment, upsertLinkComment,
  getRegionCategoryList, getPromotionGroupList, getPromotionDomainList,
  getAdPlatformList, getQAQuestionList, getTemplateWidgetList,
  publishPromotionLink, updatePromotionLinkOcpc,
  getLandingMessageList, getLandingPhoneList,
  getLinkGroupMembers, updateGroupMemberStatus,
  updateLandingMessageProcessed, batchUpdateLandingMessageProcessed,
  markAllLandingMessageProcessed, getUnprocessedMessageCount
} from '@/api/promotion'
import { getBaseUrl } from '@/utils/format'
import { useAppStore } from '@/pinia/modules/app'
import UploadImage from "@/components/upload/image.vue";
const appStore = useAppStore()

const search = ref({ platformId: null, regionId: null, groupId: null, domainId: null })
const tableData = ref([])
const page = ref(1)
const pageSize = ref(10)
const total = ref(0)
const unprocessedMsgMap = ref({})
const platformOptions = ref([])
const regionOptions = ref([])
const groupOptions = ref([])
const domainOptions = ref([])
const qaQuestionOptions = ref([])
const mobileTemplateOptions = ref([])
const pcTemplateOptions = ref([])
const copyWidgetOptions = ref([])
const bottomWidgetOptions = ref([])
const qrcodeWidgetOptions = ref([])
// 服务端筛选，按需传递查询参数
const getTableData = async () => {
  const res = await getPromotionLinkList({ page: page.value, pageSize: pageSize.value })
  if (res.code === 0) {
    tableData.value = res.data.list
    total.value = res.data.total
    page.value = res.data.page
    pageSize.value = res.data.pageSize
    loadUnprocessedCounts()
  }
}

const loadUnprocessedCounts = async () => {
  const map = {}
  await Promise.all(tableData.value.map(async (row) => {
    try {
      const res = await getUnprocessedMessageCount({ linkId: row.ID })
      if (res.code === 0) {
        map[row.ID] = res.data
      }
    } catch (e) {
      // ignore
    }
  }))
  unprocessedMsgMap.value = map
}
getTableData()
const loadBasicOptions = async () => {
  const [p, r, g, d, q, t1, t2, t3, t4, t5] = await Promise.all([
    getAdPlatformList({ page: 1, pageSize: 10000 }),
    getRegionCategoryList({ page: 1, pageSize: 10000 }),
    getPromotionGroupList({ page: 1, pageSize: 10000 }),
    getPromotionDomainList({ page: 1, pageSize: 10000 }),
    getQAQuestionList({ page: 1, pageSize: 10000 }),
    getTemplateWidgetList({ page: 1, pageSize: 10000, type: 1 }),
    getTemplateWidgetList({ page: 1, pageSize: 10000, type: 2 }),
    getTemplateWidgetList({ page: 1, pageSize: 10000, type: 3 }),
    getTemplateWidgetList({ page: 1, pageSize: 10000, type: 4 }),
    getTemplateWidgetList({ page: 1, pageSize: 10000, type: 5 })
  ])
  if (p.code === 0) platformOptions.value = p.data.list || []
  if (r.code === 0) regionOptions.value = r.data.list || []
  if (g.code === 0) groupOptions.value = g.data.list || []
  if (d.code === 0) domainOptions.value = d.data.list || []
  if (q.code === 0) qaQuestionOptions.value = q.data.list || []
  if (t1.code === 0) mobileTemplateOptions.value = t1.data.list || []
  if (t2.code === 0) pcTemplateOptions.value = t2.data.list || []
  if (t3.code === 0) copyWidgetOptions.value = t3.data.list || []
  if (t4.code === 0) bottomWidgetOptions.value = t4.data.list || []
  if (t5.code === 0) qrcodeWidgetOptions.value = t5.data.list || []
}
loadBasicOptions()
const onSubmit = async () => {
  const params = {
    page: page.value,
    pageSize: pageSize.value
  }
  if (search.value.platformId) params.platformId = search.value.platformId
  if (search.value.regionId) params.regionId = search.value.regionId
  if (search.value.groupId) params.groupId = search.value.groupId
  if (search.value.domainId) params.domainId = search.value.domainId
  const res = await getPromotionLinkList(params)
  if (res.code === 0) {
    tableData.value = res.data.list
    total.value = res.data.total
    page.value = res.data.page
    pageSize.value = res.data.pageSize
    loadUnprocessedCounts()
  }
}
const onReset = () => { search.value = { platformId: null, regionId: null, groupId: null, domainId: null }; onSubmit() }
const handleSizeChange = (val) => { pageSize.value = val; getTableData() }
const handleCurrentChange = (val) => { page.value = val; getTableData() }

const drawer = ref(false)
const form = ref({ ID: 0, platformId: null, regionId: null, groupId: null, domainId: null, questionId: null, sort: 0, remark: '' })
const openForm = (row) => {
  form.value = row ? { ...row } : { ID: 0, platformId: null, regionId: null, groupId: null, domainId: null, questionId: null, sort: 0, remark: '' }
  drawer.value = true
}
const submit = async () => {
  let res
  if (form.value.ID) res = await updatePromotionLink(form.value)
  else res = await createPromotionLink(form.value)
  if (res.code === 0) { ElMessage.success('保存成功'); drawer.value = false; getTableData() }
}
const remove = async (row) => {
  await ElMessageBox.confirm('确认删除该记录？', '提示')
  const res = await deletePromotionLink({ ID: row.ID })
  if (res.code === 0) { ElMessage.success('删除成功'); getTableData() }
}

const drawerBasic = ref(false)
const basic = ref({
  linkId: 0,
  templateMobileId: null,
  templatePcId: null,
  mobileCopyWidgetId: null,
  mobileBottomWidgetId: null,
  pcQrcodeWidgetId: null,
  show12301Phone: false,
  preferCustomerAssist: false,
  mobileShowQrcode: false,
  pcShowRightQrcode: false,
  autoDetectDevice: false,
  seoTitle: '',
  seoKeywords: '',
  seoDescription: ''
})
const openBasic = async (row) => {
  basic.value = {
    linkId: row.ID,
    templateMobileId: null,
    templatePcId: null,
    mobileCopyWidgetId: null,
    mobileBottomWidgetId: null,
    pcQrcodeWidgetId: null,
    show12301Phone: false,
    preferCustomerAssist: false,
    mobileShowQrcode: false,
    pcShowRightQrcode: false,
    autoDetectDevice: false,
    seoTitle: '',
    seoKeywords: '',
    seoDescription: ''
  }
  try {
    const res = await getLinkBasic({ linkId: row.ID })
    if (res.code === 0 && res.data && res.data.data) Object.assign(basic.value, res.data.data)
  } catch (e) {
    console.error('获取基本设置失败', e)
  }
  drawerBasic.value = true
}
const submitBasic = async () => {
  const res = await upsertLinkBasic(basic.value)
  if (res.code === 0) { ElMessage.success('保存成功'); drawerBasic.value = false }
}

const handleLogoPcUrlSuccess = (url, raw) => {
  company.value.logoPcUrl = url
}
const handleLogoMobileUrlSuccess = (url, raw) => {
  company.value.logoMobileUrl = url
}
const drawerCompany = ref(false)
const company = ref({ linkId: 0, companyName: '', icpRecordNo: '', licenseNo: '', homepageUrl: '', aboutUrl: '', logoPcUrl: '', logoMobileUrl: '' })
const openCompany = async (row) => {
  company.value = { linkId: row.ID, companyName: '', icpRecordNo: '', licenseNo: '', homepageUrl: '', aboutUrl: '', logoPcUrl: '', logoMobileUrl: '' }
  const res = await getLinkCompany({ linkId: row.ID })
  if (res.code === 0 && res.data && res.data.data) Object.assign(company.value, res.data.data)
  drawerCompany.value = true
}
const submitCompany = async () => {
  const res = await upsertLinkCompany(company.value)
  if (res.code === 0) { ElMessage.success('保存成功'); drawerCompany.value = false }
}

const drawerCode = ref(false)
const codeCfg = ref({ linkId: 0, statHeaderHtml: '', statFooterHtml: '', conversionScript: '', cssStyleText: '' })
const openCode = async (row) => {
  codeCfg.value = { linkId: row.ID, statHeaderHtml: '', statFooterHtml: '', conversionScript: '', cssStyleText: '' }
  const res = await getLinkCode({ linkId: row.ID })
  if (res.code === 0 && res.data && res.data.data) Object.assign(codeCfg.value, res.data.data)
  drawerCode.value = true
}
const submitCode = async () => {
  const res = await upsertLinkCode(codeCfg.value)
  if (res.code === 0) { ElMessage.success('保存成功'); drawerCode.value = false }
}

const drawerTheme = ref(false)
const theme = ref({ linkId: 0, colorWechatPhone: '', colorServiceName: '', colorCopyright: '', boldAll: false })
const openTheme = async (row) => {
  theme.value = { linkId: row.ID, colorWechatPhone: '', colorServiceName: '', colorCopyright: '', boldAll: false }
  const res = await getLinkTheme({ linkId: row.ID })
  if (res.code === 0 && res.data && res.data.data) Object.assign(theme.value, res.data.data)
  drawerTheme.value = true
}
const submitTheme = async () => {
  const res = await upsertLinkTheme(theme.value)
  if (res.code === 0) { ElMessage.success('保存成功'); drawerTheme.value = false }
}

const drawerComment = ref(false)
const comment = ref({ linkId: 0, enableComment: false, permission: 'mobile_login' })

// 推广链接相关
const linkDialogVisible = ref(false)
const ocpcDialogVisible = ref(false)
const currentLink = ref({ mobileUrl: '', pcUrl: '' })
const ocpcForm = ref({ ID: 0, platformId: null, ocpcKey: '', ocpcSecret: '', ocpcConversionType: null, ocpcCallbackType: null, ocpcMinDuration: 30 })

// 留言信息相关
const messageDialogVisible = ref(false)
const currentLinkId = ref(0)
const messageSearch = ref({ ip: '', phone: '', dateRange: [] })
const messageList = ref([])
const messagePage = ref(1)
const messagePageSize = ref(10)
const messageTotal = ref(0)
const messageSelectedIds = ref([])
const messageUnprocessedTotal = ref(0)

// 登录信息相关
const phoneDialogVisible = ref(false)
const phoneSearch = ref({ ip: '', phone: '', dateRange: [] })
const phoneList = ref([])
const phonePage = ref(1)
const phonePageSize = ref(10)
const phoneTotal = ref(0)

// 客服管理相关
const serviceDialogVisible = ref(false)
const serviceList = ref([])

// 显示推广链接
const showLink = (row) => {
  currentLink.value = { mobileUrl: row.mobileUrl || '', pcUrl: row.pcUrl || '' }
  linkDialogVisible.value = true
}

// 打开OCPC配置
const openOcpc = (row) => {
  ocpcForm.value = {
    ID: row.ID,
    platformId: row.platformId || null,
    ocpcKey: row.ocpcKey || '',
    ocpcSecret: row.ocpcSecret || '',
    ocpcConversionType: row.ocpcConversionType || null,
    ocpcCallbackType: row.ocpcCallbackType || null,
    ocpcMinDuration: row.ocpcMinDuration || 30
  }
  ocpcDialogVisible.value = true
}

// 格式化链接，自动拼接 https://
const formatLinkUrl = (url) => {
  if (!url) return ''
  return url.startsWith('http://') || url.startsWith('https://') ? url : 'https://' + url
}

// 复制链接
const copyLink = (url) => {
  if (!url) return
  const input = document.createElement('textarea')
  input.value = url
  document.body.appendChild(input)
  input.select()
  document.execCommand('copy')
  document.body.removeChild(input)
  ElMessage.success('复制成功')
}

// 发布更新链接
const publishLink = async (row) => {
  await ElMessageBox.confirm('确认发布更新？发布后将重新生成移动端和PC端推广页面', '提示')
  const res = await publishPromotionLink({ ID: row.ID })
  if (res.code === 0) {
    ElMessage.success('发布成功')
    getTableData()
  }
}



// 保存OCPC配置
const saveOcpc = async () => {
  const res = await updatePromotionLinkOcpc(ocpcForm.value)
  if (res.code === 0) {
    ElMessage.success('OCPC配置保存成功')
    ocpcDialogVisible.value = false
    getTableData()
  }
}

const openComment = async (row) => {
  comment.value = { linkId: row.ID, enableComment: false, permission: 'mobile_login' }
  const res = await getLinkComment({ linkId: row.ID })
  if (res.code === 0 && res.data && res.data.data) Object.assign(comment.value, res.data.data)
  drawerComment.value = true
}
const submitComment = async () => {
  const res = await upsertLinkComment(comment.value)
  if (res.code === 0) { ElMessage.success('保存成功'); drawerComment.value = false }
}

// 打开留言信息弹窗
const openMessage = (row) => {
  currentLinkId.value = row.ID
  messageSearch.value = { ip: '', phone: '', dateRange: [], processed: null }
  messagePage.value = 1
  messagePageSize.value = 10
  messageSelectedIds.value = []
  getMessageList()
  messageDialogVisible.value = true
}

// 获取留言列表
const getMessageList = async () => {
  const params = {
    linkId: currentLinkId.value,
    page: messagePage.value,
    pageSize: messagePageSize.value,
    ip: messageSearch.value.ip,
    phone: messageSearch.value.phone
  }
  if (messageSearch.value.dateRange && messageSearch.value.dateRange.length === 2) {
    params.startTime = messageSearch.value.dateRange[0]
    params.endTime = messageSearch.value.dateRange[1]
  }
  if (messageSearch.value.processed !== null && messageSearch.value.processed !== '') {
    params.processed = messageSearch.value.processed
  }
  const res = await getLandingMessageList(params)
  if (res.code === 0) {
    messageList.value = res.data.list
    messageTotal.value = res.data.total
    messagePage.value = res.data.page
    messagePageSize.value = res.data.pageSize
    messageSelectedIds.value = []
  }
  updateUnprocessedTotal()
}

const updateUnprocessedTotal = async () => {
  try {
    const res = await getUnprocessedMessageCount({ linkId: currentLinkId.value })
    if (res.code === 0) {
      messageUnprocessedTotal.value = res.data
    }
  } catch (e) {
    // ignore
  }
}

// 留言分页事件
const handleMessageSizeChange = (val) => { messagePageSize.value = val; getMessageList() }
const handleMessageCurrentChange = (val) => { messagePage.value = val; getMessageList() }

// 重置留言搜索
const resetMessageSearch = () => {
  messageSearch.value = { ip: '', phone: '', dateRange: [], processed: null }
  getMessageList()
}

// 单个标记处理状态
const handleMessageProcessedChange = async (row) => {
  try {
    const res = await updateLandingMessageProcessed({ id: row.ID, processed: row.processed })
    if (res.code === 0) {
      ElMessage.success(row.processed ? '已标记为已处理' : '已标记为未处理')
      updateUnprocessedTotal()
      loadUnprocessedCounts()
    } else {
      row.processed = !row.processed
    }
  } catch (e) {
    row.processed = !row.processed
  }
}

// 批量选择
const handleMessageSelectionChange = (selection) => {
  messageSelectedIds.value = selection.map(item => item.ID)
}

// 批量标记
const batchMarkProcessed = async (processed) => {
  try {
    const res = await batchUpdateLandingMessageProcessed({ ids: messageSelectedIds.value, processed })
    if (res.code === 0) {
      ElMessage.success(processed ? '已批量标记为已处理' : '已批量标记为未处理')
      getMessageList()
      loadUnprocessedCounts()
    }
  } catch (e) {
    // ignore
  }
}

// 全部标记已处理
const markAllProcessed = async () => {
  try {
    const res = await markAllLandingMessageProcessed({ linkId: String(currentLinkId.value), processed: true })
    if (res.code === 0) {
      ElMessage.success('已全部标记为已处理')
      getMessageList()
      loadUnprocessedCounts()
    }
  } catch (e) {
    // ignore
  }
}

// 打开登录信息弹窗
const openPhone = (row) => {
  currentLinkId.value = row.ID
  phoneSearch.value = { ip: '', phone: '', dateRange: [] }
  phonePage.value = 1
  phonePageSize.value = 10
  getPhoneList()
  phoneDialogVisible.value = true
}

// 获取登录列表
const getPhoneList = async () => {
  const params = {
    linkId: currentLinkId.value,
    page: phonePage.value,
    pageSize: phonePageSize.value,
    ip: phoneSearch.value.ip,
    phone: phoneSearch.value.phone
  }
  if (phoneSearch.value.dateRange && phoneSearch.value.dateRange.length === 2) {
    params.startTime = phoneSearch.value.dateRange[0]
    params.endTime = phoneSearch.value.dateRange[1]
  }
  const res = await getLandingPhoneList(params)
  if (res.code === 0) {
    phoneList.value = res.data.list
    phoneTotal.value = res.data.total
    phonePage.value = res.data.page
    phonePageSize.value = res.data.pageSize
  }
}

// 登录分页事件
const handlePhoneSizeChange = (val) => { phonePageSize.value = val; getPhoneList() }
const handlePhoneCurrentChange = (val) => { phonePage.value = val; getPhoneList() }

// 重置登录搜索
const resetPhoneSearch = () => {
  phoneSearch.value = { ip: '', phone: '', dateRange: [] }
  getPhoneList()
}

// 打开客服管理弹窗
const openServiceDialog = async (row) => {
  currentLinkId.value = row.ID
  serviceList.value = []
  try {
    const res = await getLinkGroupMembers({ linkId: row.ID })
    if (res.code === 0) {
      serviceList.value = res.data.list || []
    }
  } catch (e) {
    console.error('获取客服列表失败', e)
  }
  serviceDialogVisible.value = true
}

// 处理客服状态切换
const handleStatusChange = async (row) => {
  try {
    const res = await updateGroupMemberStatus({
      id: row.ID,
      status: row.status
    })
    if (res.code === 0) {
      ElMessage.success('状态更新成功')
    } else {
      // 更新失败，恢复原状态
      row.status = row.status === 1 ? 2 : 1
      ElMessage.error('状态更新失败')
    }
  } catch (e) {
    // 更新失败，恢复原状态
    row.status = row.status === 1 ? 2 : 1
    console.error('更新状态失败', e)
    ElMessage.error('状态更新失败')
  }
}

// 预览相关
const previewVisible = ref(false)
const previewUrl = ref('')

const getPreviewImage = (options, id) => {
  if (!id) return null
  const item = options.find(opt => opt.ID === id)
  return item ? item.previewImage : null
}

const showPreview = (options, id) => {
  const previewImage = getPreviewImage(options, id)
  if (!previewImage) {
    ElMessage.warning('暂无预览图片')
    return
  }
  previewUrl.value = getBaseUrl() + '/' + previewImage
  previewVisible.value = true
}
</script>

<style scoped></style>
