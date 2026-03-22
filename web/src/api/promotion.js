import service from '@/utils/request'

export const createRegionCategory = (data) => {
  return service({
    url: '/promotion/createRegionCategory',
    method: 'post',
    data
  })
}

export const updateRegionCategory = (data) => {
  return service({
    url: '/promotion/updateRegionCategory',
    method: 'put',
    data
  })
}

export const deleteRegionCategory = (data) => {
  return service({
    url: '/promotion/deleteRegionCategory',
    method: 'delete',
    data
  })
}

export const findRegionCategory = (params) => {
  return service({
    url: '/promotion/findRegionCategory',
    method: 'get',
    params
  })
}

export const getRegionCategoryList = (params) => {
  return service({
    url: '/promotion/getRegionCategoryList',
    method: 'get',
    params
  })
}

export const createPromotionGroup = (data) => {
  return service({
    url: '/promotion/createPromotionGroup',
    method: 'post',
    data
  })
}

export const updatePromotionGroup = (data) => {
  return service({
    url: '/promotion/updatePromotionGroup',
    method: 'put',
    data
  })
}

export const deletePromotionGroup = (data) => {
  return service({
    url: '/promotion/deletePromotionGroup',
    method: 'delete',
    data
  })
}

export const findPromotionGroup = (params) => {
  return service({
    url: '/promotion/findPromotionGroup',
    method: 'get',
    params
  })
}

export const getPromotionGroupList = (params) => {
  return service({
    url: '/promotion/getPromotionGroupList',
    method: 'get',
    params
  })
}

export const createGroupMember = (data) => {
  return service({
    url: '/promotion/createGroupMember',
    method: 'post',
    data
  })
}

export const updateGroupMember = (data) => {
  return service({
    url: '/promotion/updateGroupMember',
    method: 'put',
    data
  })
}

export const deleteGroupMember = (data) => {
  return service({
    url: '/promotion/deleteGroupMember',
    method: 'delete',
    data
  })
}

export const findGroupMember = (params) => {
  return service({
    url: '/promotion/findGroupMember',
    method: 'get',
    params
  })
}

export const getGroupMemberList = (params) => {
  return service({
    url: '/promotion/getGroupMemberList',
    method: 'get',
    params
  })
}

export const createPromotionDomain = (data) => {
  return service({
    url: '/promotion/createPromotionDomain',
    method: 'post',
    data
  })
}

export const updatePromotionDomain = (data) => {
  return service({
    url: '/promotion/updatePromotionDomain',
    method: 'put',
    data
  })
}

export const deletePromotionDomain = (data) => {
  return service({
    url: '/promotion/deletePromotionDomain',
    method: 'delete',
    data
  })
}

export const findPromotionDomain = (params) => {
  return service({
    url: '/promotion/findPromotionDomain',
    method: 'get',
    params
  })
}

export const getPromotionDomainList = (params) => {
  return service({
    url: '/promotion/getPromotionDomainList',
    method: 'get',
    params
  })
}

export const createPromotionLink = (data) => {
  return service({ url: '/promotion/createPromotionLink', method: 'post', data })
}
export const updatePromotionLink = (data) => {
  return service({ url: '/promotion/updatePromotionLink', method: 'put', data })
}
export const deletePromotionLink = (data) => {
  return service({ url: '/promotion/deletePromotionLink', method: 'delete', data })
}
export const getPromotionLinkList = (params) => {
  return service({ url: '/promotion/getPromotionLinkList', method: 'get', params })
}
export const upsertLinkBasic = (data) => {
  return service({ url: '/promotion/upsertLinkBasic', method: 'post', data })
}
export const getLinkBasic = (params) => {
  return service({ url: '/promotion/getLinkBasic', method: 'get', params })
}
export const upsertLinkCompany = (data) => {
  return service({ url: '/promotion/upsertLinkCompany', method: 'post', data })
}
export const getLinkCompany = (params) => {
  return service({ url: '/promotion/getLinkCompany', method: 'get', params })
}
export const upsertLinkCode = (data) => {
  return service({ url: '/promotion/upsertLinkCode', method: 'post', data })
}
export const getLinkCode = (params) => {
  return service({ url: '/promotion/getLinkCode', method: 'get', params })
}
export const upsertLinkTheme = (data) => {
  return service({ url: '/promotion/upsertLinkTheme', method: 'post', data })
}
export const getLinkTheme = (params) => {
  return service({ url: '/promotion/getLinkTheme', method: 'get', params })
}
export const upsertLinkComment = (data) => {
  return service({ url: '/promotion/upsertLinkComment', method: 'post', data })
}
export const getLinkComment = (params) => {
  return service({ url: '/promotion/getLinkComment', method: 'get', params })
}

// 模板插件管理
export const createTemplateWidget = (data) => {
  return service({ url: '/promotion/createTemplateWidget', method: 'post', data })
}
export const updateTemplateWidget = (data) => {
  return service({ url: '/promotion/updateTemplateWidget', method: 'put', data })
}
export const deleteTemplateWidget = (data) => {
  return service({ url: '/promotion/deleteTemplateWidget', method: 'delete', data })
}
export const findTemplateWidget = (params) => {
  return service({ url: '/promotion/findTemplateWidget', method: 'get', params })
}
export const getTemplateWidgetList = (params) => {
  return service({ url: '/promotion/getTemplateWidgetList', method: 'get', params })
}

export const createQAQuestion = (data) => service({ url: '/promotion/createQAQuestion', method: 'post', data })
export const updateQAQuestion = (data) => service({ url: '/promotion/updateQAQuestion', method: 'put', data })
export const deleteQAQuestion = (data) => service({ url: '/promotion/deleteQAQuestion', method: 'delete', data })
export const getQAQuestionList = (params) => service({ url: '/promotion/getQAQuestionList', method: 'get', params })
export const createQAAnswer = (data) => service({ url: '/promotion/createQAAnswer', method: 'post', data })
export const updateQAAnswer = (data) => service({ url: '/promotion/updateQAAnswer', method: 'put', data })
export const deleteQAAnswer = (data) => service({ url: '/promotion/deleteQAAnswer', method: 'delete', data })
export const getQAAnswerList = (params) => service({ url: '/promotion/getQAAnswerList', method: 'get', params })
export const createQAReply = (data) => service({ url: '/promotion/createQAReply', method: 'post', data })
export const updateQAReply = (data) => service({ url: '/promotion/updateQAReply', method: 'put', data })
export const deleteQAReply = (data) => service({ url: '/promotion/deleteQAReply', method: 'delete', data })
export const getQAReplyList = (params) => service({ url: '/promotion/getQAReplyList', method: 'get', params })

export const createAdPlatform = (data) => service({ url: '/promotion/createAdPlatform', method: 'post', data })
export const updateAdPlatform = (data) => service({ url: '/promotion/updateAdPlatform', method: 'put', data })
export const deleteAdPlatform = (data) => service({ url: '/promotion/deleteAdPlatform', method: 'delete', data })
export const getAdPlatformList = (params) => service({ url: '/promotion/getAdPlatformList', method: 'get', params })
export const createAdCampaign = (data) => service({ url: '/promotion/createAdCampaign', method: 'post', data })
export const updateAdCampaign = (data) => service({ url: '/promotion/updateAdCampaign', method: 'put', data })
export const deleteAdCampaign = (data) => service({ url: '/promotion/deleteAdCampaign', method: 'delete', data })
export const getAdCampaignList = (params) => service({ url: '/promotion/getAdCampaignList', method: 'get', params })
export const createAdKeyword = (data) => service({ url: '/promotion/createAdKeyword', method: 'post', data })
export const updateAdKeyword = (data) => service({ url: '/promotion/updateAdKeyword', method: 'put', data })
export const deleteAdKeyword = (data) => service({ url: '/promotion/deleteAdKeyword', method: 'delete', data })
export const getAdKeywordList = (params) => service({ url: '/promotion/getAdKeywordList', method: 'get', params })
export const getAdDailySummaryList = (params) => service({ url: '/promotion/getAdDailySummaryList', method: 'get', params })

export const createActivityMarket = (data) => service({ url: '/promotion/createActivityMarket', method: 'post', data })
export const updateActivityMarket = (data) => service({ url: '/promotion/updateActivityMarket', method: 'put', data })
export const deleteActivityMarket = (data) => service({ url: '/promotion/deleteActivityMarket', method: 'delete', data })
export const getActivityMarketList = (params) => service({ url: '/promotion/getActivityMarketList', method: 'get', params })
export const createActivityPackage = (data) => service({ url: '/promotion/createActivityPackage', method: 'post', data })
export const updateActivityPackage = (data) => service({ url: '/promotion/updateActivityPackage', method: 'put', data })
export const deleteActivityPackage = (data) => service({ url: '/promotion/deleteActivityPackage', method: 'delete', data })
export const getActivityPackageList = (params) => service({ url: '/promotion/getActivityPackageList', method: 'get', params })
export const createActivityData = (data) => service({ url: '/promotion/createActivityData', method: 'post', data })
export const updateActivityData = (data) => service({ url: '/promotion/updateActivityData', method: 'put', data })
export const deleteActivityData = (data) => service({ url: '/promotion/deleteActivityData', method: 'delete', data })
export const getActivityDataList = (params) => service({ url: '/promotion/getActivityDataList', method: 'get', params })

// QA头像昵称管理
export const createQAAvatarNickname = (data) => service({ url: '/promotion/createQAAvatarNickname', method: 'post', data })
export const updateQAAvatarNickname = (data) => service({ url: '/promotion/updateQAAvatarNickname', method: 'put', data })
export const deleteQAAvatarNickname = (data) => service({ url: '/promotion/deleteQAAvatarNickname', method: 'delete', data })
export const getQAAvatarNicknameList = (params) => service({ url: '/promotion/getQAAvatarNicknameList', method: 'get', params })
export const getAllEnabledQAAvatarNickname = (params) => service({ url: '/promotion/getAllEnabledQAAvatarNickname', method: 'get', params })

// QA称号管理
export const createQATitle = (data) => service({ url: '/promotion/createQATitle', method: 'post', data })
export const updateQATitle = (data) => service({ url: '/promotion/updateQATitle', method: 'put', data })
export const deleteQATitle = (data) => service({ url: '/promotion/deleteQATitle', method: 'delete', data })
export const getQATitleList = (params) => service({ url: '/promotion/getQATitleList', method: 'get', params })
export const getAllEnabledQATitle = (params) => service({ url: '/promotion/getAllEnabledQATitle', method: 'get', params })

// QA个性签名管理
export const createQASignature = (data) => service({ url: '/promotion/createQASignature', method: 'post', data })
export const updateQASignature = (data) => service({ url: '/promotion/updateQASignature', method: 'put', data })
export const deleteQASignature = (data) => service({ url: '/promotion/deleteQASignature', method: 'delete', data })
export const getQASignatureList = (params) => service({ url: '/promotion/getQASignatureList', method: 'get', params })
export const getAllEnabledQASignature = (params) => service({ url: '/promotion/getAllEnabledQASignature', method: 'get', params })

// QA标签管理
export const createQATag = (data) => service({ url: '/promotion/createQATag', method: 'post', data })
export const updateQATag = (data) => service({ url: '/promotion/updateQATag', method: 'put', data })
export const deleteQATag = (data) => service({ url: '/promotion/deleteQATag', method: 'delete', data })
export const getQATagList = (params) => service({ url: '/promotion/getQATagList', method: 'get', params })
export const getAllEnabledQATag = (params) => service({ url: '/promotion/getAllEnabledQATag', method: 'get', params })
export const getQAQuestionDetail = (id) => service({ url: `/promotion/getQAQuestionDetail/${id}`, method: 'get' })
