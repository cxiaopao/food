<template>
    <div class="container mx-auto mb-8 mt-10 bg-white">
        <div class="w-3/4 mx-auto py-6">
            <div class="border border-gray-500">
                <Toolbar class="border-b border-gray-500" :editor="editorRef" :defaultConfig="toolbarConfig"
                    :mode="mode" />
                <Editor style="height: 500px; overflow: hidden;" v-model="valueHtml" :defaultConfig="editorConfig"
                    :mode="mode" @onCreated="handleCreated" />
            </div>
            <div class="mt-4">
                <el-upload
                    class="text-center leading-[200px] hover:border-primary border-2 h-[200px] w-[200px] border-dashed overflow-hidden"
                    :on-change="handleImgChange" :show-file-list="false" :auto-upload="false">
                    <img v-if="imgUrl" :src="imgUrl" class="w-[200px] h-[200px] object-cover" />
                    <i v-else class="fa fa-plus text-2lg text-gray-500 h-[200px] w-[200px]"></i>
                </el-upload>
            </div>
            <div class="mt-4">
                <el-radio-group v-model="article.status">
                    <el-radio value="d" size="large" border>保存</el-radio>
                    <el-radio value="r" size="large" border>发布</el-radio>
                </el-radio-group>
            </div>
            <button @click="onSubmit" class="mt-4 w-full text-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm
                    font-medium text-white bg-primary hover:opacity-50">
                提交
            </button>
        </div>


    </div>
</template>

<script setup>
import '@wangeditor/editor/dist/css/style.css'
import { onBeforeUnmount, ref, shallowRef, onMounted } from 'vue'
import { Editor, Toolbar } from '@wangeditor/editor-for-vue'
import { writeArticleAPI } from '@/api/article'
import router from '@/router'

// 富文本配置
const editorRef = shallowRef()
const toolbarConfig = {}
const editorConfig = { placeholder: '请注意：文章的第一段话系统将默认提取为文章的标题，第二段提取为文章的摘要' }
const mode = ref('default')

// 记录 editor 实例
const handleCreated = (editor) => {
    editorRef.value = editor
    console.log('created', editor)
}

// 组件销毁时，也及时销毁编辑器
onBeforeUnmount(() => {
    const editor = editorRef.value
    if (editor == null) return
    editor.destroy()
    console.log('destroy')
})

// 内容 HTML
const valueHtml = ref('')

// 文章实体
const imgUrl = ref(null)
const article = ref({
    title: '',
    summary: '',
    body: '',
    img: null,
    status: 'd'
})

// 文章图片上传
const handleImgChange = (file) => {
    article.value.img = file.raw;
    imgUrl.value = URL.createObjectURL(file.raw);
};

// 提交文章
const onSubmit = () => {

    ElMessageBox.confirm(
        '确定提交信息吗?',
        '警告',
        {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning',
        }
    ).then(async () => {
        // 创建一个临时的 DOM 元素来解析 HTML
        const tempDiv = document.createElement('div')
        tempDiv.innerHTML = valueHtml.value

        // 获取所有的子节点
        const children = Array.from(tempDiv.children)

        // 提取第一个标签的内容作为标题并去除空白字符
        if (children.length > 0) {
            article.value.title = children[0].innerText.trim() || ''
        }

        // 提取第二个标签的内容作为摘要并去除空白字符
        if (children.length > 1) {
            article.value.summary = children[1].innerText.trim() || ''
        }

        // 剩余内容作为正文
        if (children.length > 2) {
            const bodyContent = children.slice(2).map(node => node.outerHTML).join('')
            article.value.body = bodyContent
        }

        // 提交文章
        let formData = new FormData()
        Object.keys(article.value).forEach(key => formData.append(key, article.value[key]))

        for (let [key, value] of formData.entries()) {
            console.log(`${key}: ${value}`);
        }


        const res = await writeArticleAPI(formData)



        if (res.data.data.status === 'r') {
            ElMessage({
                type: 'success',
                message: '文章提交成功，待审核，即将跳转文章页面',
                duration: 1000,
            })
        }
        else {
            ElMessage({
                type: 'success',
                message: '文章保存成功，即将跳转文章页面',
                duration: 1000,
            })
        }

        setTimeout(() => {
            router.push(`/article/${res.data.data.id}/`)
            // 重置表单
            article.value.title = ''
            article.value.summary = ''
            article.value.body = ''
            article.value.img = null
            article.value.status = 'd'
            imgUrl.value = null
            valueHtml.value = ''
        }, 1000);

    })


}



</script>

<style scoped></style>
