import service from '@/utils/request'

// ===== 新闻 =====
export const createNews = (data) => {
  return service({
    url: '/promotion/createNews',
    method: 'post',
    data
  })
}

export const updateNews = (data) => {
  return service({
    url: '/promotion/updateNews',
    method: 'put',
    data
  })
}

export const deleteNews = (data) => {
  return service({
    url: '/promotion/deleteNews',
    method: 'delete',
    data
  })
}

export const findNews = (params) => {
  return service({
    url: '/promotion/findNews',
    method: 'get',
    params
  })
}

export const getNewsList = (params) => {
  return service({
    url: '/promotion/getNewsList',
    method: 'get',
    params
  })
}

export const publishNews = (data) => {
  return service({
    url: '/promotion/publishNews',
    method: 'post',
    data
  })
}

export const batchPublishNews = () => {
  return service({
    url: '/promotion/batchPublishNews',
    method: 'post'
  })
}

export const publishNewsCenter = () => {
  return service({
    url: '/promotion/publishNewsCenter',
    method: 'post'
  })
}

export const submitToBaidu = (data) => {
  return service({
    url: '/promotion/submitToBaidu',
    method: 'post',
    data
  })
}

// ===== 新闻分类 =====
export const createNewsCategory = (data) => {
  return service({
    url: '/promotion/createNewsCategory',
    method: 'post',
    data
  })
}

export const updateNewsCategory = (data) => {
  return service({
    url: '/promotion/updateNewsCategory',
    method: 'put',
    data
  })
}

export const deleteNewsCategory = (data) => {
  return service({
    url: '/promotion/deleteNewsCategory',
    method: 'delete',
    data
  })
}

export const findNewsCategory = (params) => {
  return service({
    url: '/promotion/findNewsCategory',
    method: 'get',
    params
  })
}

export const getNewsCategoryList = (params) => {
  return service({
    url: '/promotion/getNewsCategoryList',
    method: 'get',
    params
  })
}

export const getAllEnabledNewsCategories = (params) => {
  return service({
    url: '/promotion/getAllEnabledNewsCategories',
    method: 'get',
    params
  })
}
