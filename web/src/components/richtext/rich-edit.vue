<template>
  <div class="w-full border border-solid border-gray-100 z-10">
    <div class="flex items-center justify-end bg-gray-50 border-b border-gray-200">
      <div class="px-2">
        <el-button size="small" @click="toggleMode">
          {{ showCode ? '可视化' : '代码' }}
        </el-button>
      </div>
    </div>
    <div v-show="!showCode" class="w-full">
      <Toolbar
        :editor="editorRef"
        :default-config="toolbarConfig"
        mode="default"
      />
      <Editor
        v-model="valueHtml"
        class="overflow-y-hidden"
        :style="{ height: height + 'px' }"
        :default-config="editorConfig"
        mode="default"
        @onCreated="handleCreated"
        @onChange="change"
      />
    </div>
    <div v-if="showCode" class="w-full" :style="{ height: height + 'px' }">
      <v-ace-editor
        v-model:value="codeContent"
        lang="html"
        theme="github_dark"
        style="width:100%;height:100%"
        :options="{ showPrintMargin: false, fontSize: 13, wrap: true }"
      />
    </div>
  </div>
</template>

<script setup>
  import '@wangeditor/editor/dist/css/style.css'

  const basePath = import.meta.env.VITE_BASE_API

  import { onBeforeUnmount, ref, shallowRef, watch } from 'vue'
  import { Editor, Toolbar } from '@wangeditor/editor-for-vue'
  import { VAceEditor } from 'vue3-ace-editor'
  import 'ace-builds/src-noconflict/mode-html'
  import 'ace-builds/src-noconflict/theme-github_dark'

  import { ElMessage } from 'element-plus'
  import { getUrl } from '@/utils/image'
  import { useUserStore } from '@/pinia/modules/user'

  const emits = defineEmits(['change', 'update:modelValue'])

  const change = (editor) => {
    emits('change', editor)
    emits('update:modelValue', valueHtml.value)
  }

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

  const editorRef = shallowRef()
  const valueHtml = ref('')
  const showCode = ref(false)
  const codeContent = ref('')

  const toolbarConfig = {}
  const editorConfig = {
    placeholder: '请输入内容...',
    MENU_CONF: {}
  }
  editorConfig.MENU_CONF['uploadImage'] = {
    fieldName: 'file',
    server: basePath + '/fileUploadAndDownload/upload?noSave=1',
    headers: {
      'x-token': userStore.token,
    },
    customInsert(res, insertFn) {
      if (res.code === 0) {
        const urlPath = getUrl(res.data.file.url)
        insertFn(urlPath, res.data.file.name)
        return
      }
      ElMessage.error(res.msg)
    }
  }

  onBeforeUnmount(() => {
    const editor = editorRef.value
    if (editor == null) return
    editor.destroy()
  })

  const handleCreated = (editor) => {
    editorRef.value = editor
    valueHtml.value = props.modelValue
  }

  watch(
    () => props.modelValue,
    (val) => {
      if (valueHtml.value === val) return
      valueHtml.value = val
    }
  )

  const toggleMode = () => {
    if (showCode.value) {
      valueHtml.value = codeContent.value
      emits('update:modelValue', codeContent.value)
      showCode.value = false
    } else {
      codeContent.value = valueHtml.value
      showCode.value = true
    }
  }
</script>

<style scoped lang="scss">

</style>
