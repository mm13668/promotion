<template>
  <div class="w-full border border-solid border-gray-100 z-10">
    <ckeditor
      v-if="editor"
      v-model="data"
      :editor="editor"
      :config="editorConfig"
      @ready="onReady"
    />
  </div>
</template>

<script setup>
import { ref, computed, onBeforeUnmount } from 'vue'
import { Ckeditor } from '@ckeditor/ckeditor5-vue'
import {
  ClassicEditor,
  Essentials,
  Paragraph,
  Bold,
  Italic,
  Underline,
  Strikethrough,
  Heading,
  FontSize,
  FontColor,
  FontBackgroundColor,
  Alignment,
  List,
  Indent,
  Link,
  Image,
  ImageUpload,
  ImageCaption,
  ImageStyle,
  ImageToolbar,
  FileRepository,
  Table,
  TableToolbar,
  HorizontalLine,
  Undo,
  SourceEditing,
  CodeBlock,
  FindAndReplace,
  GeneralHtmlSupport
} from 'ckeditor5'
import { useUserStore } from '@/pinia/modules/user'
import { getBaseUrl } from '@/utils/format.js'

import 'ckeditor5/ckeditor5.css'

const basePath = import.meta.env.VITE_BASE_API

const emits = defineEmits(['change', 'update:modelValue'])
const userStore = useUserStore()

const props = defineProps({
  modelValue: {
    type: String,
    default: ''
  },
  height: {
    type: Number,
    default: 300
  }
})

const editor = ClassicEditor
let ckeditorInstance = null

const data = computed({
  get: () => props.modelValue || '',
  set: (val) => {
    emits('update:modelValue', val)
    emits('change', val)
  }
})

const editorConfig = {
  licenseKey: 'GPL',
  height: props.height,
  plugins: [
    Essentials,
    Paragraph,
    Bold,
    Italic,
    Underline,
    Strikethrough,
    Heading,
    FontSize,
    FontColor,
    FontBackgroundColor,
    Alignment,
    List,
    Indent,
    Link,
    Image,
    ImageUpload,
    ImageCaption,
    ImageStyle,
    ImageToolbar,
    FileRepository,
    Table,
    TableToolbar,
    HorizontalLine,
    Undo,
    SourceEditing,
    CodeBlock,
    FindAndReplace,
    GeneralHtmlSupport
  ],
  toolbar: [
    'heading',
    '|',
    'bold',
    'italic',
    'underline',
    'strikethrough',
    '|',
    'fontSize',
    'fontColor',
    'fontBackgroundColor',
    '|',
    'alignment',
    '|',
    'bulletedList',
    'numberedList',
    'outdent',
    'indent',
    '|',
    'link',
    'uploadImage',
    'insertTable',
    'horizontalLine',
    '|',
    'undo',
    'redo',
    '|',
    'sourceEditing',
    'codeBlock',
    '|',
    'findAndReplace'
  ],
  image: {
    upload: {
      types: ['jpeg', 'png', 'gif', 'bmp', 'webp']
    }
  },
  table: {
    contentToolbar: [
      'tableColumn',
      'tableRow',
      'mergeTableCells',
      'tableProperties',
      'tableCellProperties'
    ]
  },
  codeBlock: {
    languages: [
      { language: 'plaintext', label: 'Plain text' },
      { language: 'html', label: 'HTML' },
      { language: 'css', label: 'CSS' },
      { language: 'javascript', label: 'JavaScript' },
      { language: 'go', label: 'Go' },
      { language: 'python', label: 'Python' }
    ]
  },
  htmlSupport: {
    allow: [
      {
        name: 'img',
        attributes: {
          src: true,
          alt: true,
          width: true,
          height: true,
          style: true,
          class: true
        }
      }
    ]
  },
  language: 'zh-hans'
}

const onReady = (editorRef) => {
  ckeditorInstance = editorRef
  editorRef.plugins.get('FileRepository').createUploadAdapter = (loader) => {
    const uploadUrl = basePath + '/fileUploadAndDownload/upload?noSave=1'
    return {
      upload: () => {
        return loader.file.then(file => {
          return new Promise((resolve, reject) => {
            const formData = new FormData()
            formData.append('file', file)
            const xhr = new XMLHttpRequest()
            xhr.open('POST', uploadUrl)
            xhr.setRequestHeader('x-token', userStore.token)
            xhr.onload = () => {
              try {
                const res = JSON.parse(xhr.responseText)
                if (res.code === 0 && res.data && res.data.file) {
                  const fileUrl = res.data.file.url || res.data.file.Url
                  if (fileUrl) {
                    const fullUrl = getBaseUrl() + '/' + fileUrl
                    resolve({ default: fullUrl })
                    return
                  }
                }
                reject(new Error(res.msg || '图片上传失败'))
              } catch (e) {
                reject(new Error('解析上传响应失败'))
              }
            }
            xhr.onerror = () => reject(new Error('网络错误，图片上传失败'))
            xhr.send(formData)
          })
        })
      },
      abort: () => {}
    }
  }
}

onBeforeUnmount(() => {
  if (ckeditorInstance) {
    ckeditorInstance = null
  }
})
</script>

<style scoped lang="scss">
:deep(.ck-editor__editable) {
  min-height: v-bind(height + 'px');
}
</style>
