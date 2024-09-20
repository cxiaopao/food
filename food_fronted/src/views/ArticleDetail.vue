<template>
    <!-- 发布的文章 -->
    <div class="container mx-auto my-6 px-6 mt-12" v-if="article.status === 'p'">
        <!-- 文章内容 -->
        <div class="flex flex-col justify-center items-center border-b border-gray-300">
            <h1 class="text-3xl font-bold">{{ article.title }}</h1>
            <p class="text-lg  text-zinc my-8"><span class="text-pri font-bold text-2xl">摘要：</span>{{ article.summary }}
            </p>
            <img :src="article.img" alt="文章图片" class="w-1/2">
            <div id="article-body" class="my-8" v-html="article.body"></div>
            <div class="flex justify-between w-full my-4">
                <div v-if="article.author" class="flex justify-center items-center">
                    <router-link :to="`/article/view/${article.author.id}`" class="hover:cursor-pointer">
                        <img alt="作者头像" :src="article.author.avatar" class="rounded-full w-[50px]">
                    </router-link>
                    <span class="mx-2">{{ article.author.username }}</span>
                </div>
                <div class="flex flex-col justify-center items-center text-sm text-gray-500">
                    <div class="align-text-bottom">
                        <span class="text-sm text-gray-500">浏览量：{{ article.views }}</span>
                        <span class="mx-2 text-sm text-gray-500">点赞量：{{ article.votedCount }}</span>
                        <span class="text-sm text-gray-500">收藏量：{{ article.likedCount }}</span>
                    </div>
                    <span>发布日期：{{ article.updateTime }}</span>
                </div>
            </div>
        </div>
        <!-- 互动 -->
        <div class="flex justify-between my-4">
            <div class="flex flex-grow justify-center  text-2xl text-primary">
                <span @click="voteArticle"
                    class="vote-article text-2xl hover:cursor-pointer text-primary hover:opacity-50">
                    <span v-if="article.isVoted" class="fa fa-thumbs-up"></span>
                    <span v-else class="fa fa-thumbs-o-up"></span>
                </span>
                <span class="text-primary pr-8">点赞</span>
                <span @click="likeArticle" class="like-article hover:cursor-pointer text-primary hover:opacity-50">
                    <span v-if="article.isLiked" class="fa fa-heart"></span>
                    <span v-else class="fa fa-heart-o"></span>
                </span>
                <span>收藏</span>
            </div>
        </div>
        <!-- 评论表单 -->
        <div class="space-y-4 my-4 py-4">
            <label for="comment" class="text-sm font-medium text-zinc-700 dark:text-zinc-300">请留下您的评论</label>
            <textarea id="comment" v-model="commentForm.body" rows="4"
                class="mt-1 p-2 w-full rounded-md shadow-sm border focus:outline-none focus:border-primary"
                placeholder="你的留言"></textarea>
            <button @click="postArticleComment"
                class="w-full text-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-primary hover:opacity-50">提交评论</button>
        </div>
        <!-- 显示评论区域 -->
        <div class="mt-8">
            <h3 class="text-lg font-medium text-zinc-900 dark:text-white">最新评论 | {{ total }}条</h3>
            <div class="bg-white rounded-lg shadow-lg p-6 mt-6" v-for="comment in comments" :key="comment.id">
                <!-- 一级评论区域 -->
                <div class="flex items-center">
                    <router-link :to="`/article/view/${comment.author.id}`" class="hover:cursor-pointer">
                        <img alt="用户头像" class="w-12 h-12 rounded-full mr-4" :src="comment.author.avatar" />
                    </router-link>
                    <div class="flex-grow">
                        <div class="text-sm font-bold text-gray-800">
                            <span>{{ comment.author.username }}</span>
                            <span class="mx-2 text-gray-500">{{ comment.ip }}</span>
                            <span class="text-gray-500">{{ comment.createTime }}</span>
                        </div>
                        <div class="text-sm text-gray-600">{{ comment.body }}</div>
                    </div>
                    <button v-if="comment.author.id === userStore.userInfo.id" @click="deleteComment(comment.id)"
                        class="delete-comment-btn ml-auto text-gray-600 hover:text-gray-800 mr-8">
                        <i class="fa fa-trash"></i>
                    </button>
                    <button @click="toggleReplyForm(comment.id)"
                        class="reply-btn ml-auto text-gray-600 hover:text-gray-800">
                        <i class="fa fa-reply"></i>
                    </button>
                </div>
                <!-- 回复表单 -->
                <div class="mt-4" v-if="replyForms[comment.id] && replyForms[comment.id].visible">
                    <textarea rows="3" class="bg-gray-50 rounded-lg text-sm text-gray-600 w-full p-4 focus:outline-none"
                        v-model="replyForms[comment.id].body" :placeholder="'回复：' + comment.author.username"></textarea>
                    <div class="flex items-center justify-end mt-4">
                        <button @click="submitReply(comment.id)"
                            class="reply-summit bg-primary hover:opacity-50 text-white px-4 py-2 rounded-lg">评论</button>
                    </div>
                </div>
                <!-- 子评论 -->
                <div class="bg-gray-100 rounded-lg p-4 mt-4" v-for="reply in comment.replies" :key="reply.id">
                    <div class="flex items-center">
                        <router-link :to="`/article/view/${reply.author.id}`" class="hover:cursor-pointer">
                            <img alt="用户头像" class="w-10 h-10 rounded-full mr-4" :src="reply.author.avatar" />
                        </router-link>
                        <div class="flex-grow">
                            <div class="text-sm font-bold text-gray-800">
                                <span>{{ reply.author.username }}</span> 回复 <span>{{ reply.parent.author.username
                                    }}</span>
                                <span class="mx-2 text-gray-500">{{ reply.ip }}</span>
                                <span class="text-gray-500">{{ reply.createTime }}</span>
                            </div>
                            <div class="text-sm text-gray-600">{{ reply.body }}</div>
                        </div>
                        <button v-if="reply.author.id === userStore.userInfo.id" @click="deleteComment(reply.id)"
                            class="delete-comment-btn ml-auto text-gray-600 hover:text-gray-800 mr-8">
                            <i class="fa fa-trash"></i>
                        </button>
                        <button @click="toggleReplyForm(reply.id, true)"
                            class="reply-btn ml-auto text-gray-600 hover:text-gray-800">
                            <i class="fa fa-reply"></i>
                        </button>
                    </div>
                    <!-- 回复表单 -->
                    <div class="reply-form mt-4"
                        v-if="replyForms[`reply-${reply.id}`] && replyForms[`reply-${reply.id}`].visible">
                        <textarea rows="3"
                            class="bg-gray-50 rounded-lg text-sm text-gray-600 w-full p-4 focus:outline-none"
                            v-model="replyForms[`reply-${reply.id}`].body"
                            :placeholder="'回复：' + reply.author.username"></textarea>
                        <div class="flex items-center justify-end mt-4">
                            <button @click="submitReply(reply.id, true)"
                                class="reply-summit bg-primary hover:opacity-50 text-white px-4 py-2 rounded-lg">评论</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 分页 -->
            <div class="flex justify-center items-center space-x-2 mt-10">
                <el-pagination background layout="prev, pager, next" :total="total" :page-size="pageSize"
                    :current-page="currentPage" @current-change="handlePageChange" :hide-on-single-page="true" />
            </div>
        </div>
    </div>
    <!-- 审核的和草稿的文章 -->
    <div class="container mx-auto my-6 px-6 mt-12" v-else>
        <!-- 文章内容 -->
        <div class="flex flex-col justify-center items-center border-b border-gray-300">
            <h1 class="text-3xl font-bold mb-4">{{ article.title }}</h1>
            <span v-if="article.status === 'r'" class="text-red-500">(文章处于审核状态)</span>
            <span v-else="article.status==='d'" class="text-gray-500">
                <span>(上次保存于{{ article.updateTime }})</span>
                <span @click="resumeWrite(article.id)"
                    class="px-2 hover:text-primary hover:cursor-pointer">点击此处可以继续修改</span>
            </span>
            <p class="text-lg my-6 text-zinc"><span class="text-pri font-bold text-2xl">摘要：</span>{{ article.summary }}
            </p>
            <img :src="article.img" alt="文章图片" class="w-1/2">
            <div id="article-body" class="my-8" v-html="article.body"></div>
        </div>
    </div>
</template>

<script setup>
import { useRoute } from 'vue-router';
import { getArticleDetailAPI, likeArticleAPI, voteArticleAPI, postArticleCommentAPI, getArticleCommentsAPI, deleteCommentAPI } from '@/api/article'
import { ref, onMounted } from 'vue';
import router from '@/router'
import { useUserStore } from '@/stores/userStore'

// 登录用户信息
const userStore = useUserStore()

const route = useRoute()

// 文章信息
const article = ref({})

// 是否显示回复表单
const replyForms = ref({})

// 获取文章详情信息
const getArticleDetail = async () => {
    const articleId = route.params.id
    const res = await getArticleDetailAPI(articleId)
    article.value = res.data.data
}

// 收藏文章
const likeArticle = async () => {
    const res = await likeArticleAPI(article.value.id)
    article.value.isLiked = !article.value.isLiked
    if (article.value.isLiked){
        article.value.likedCount++
    }else{
        article.value.likedCount--
    }
    ElMessage({
        type: 'success',
        message: res.data.msg,
        duration: 1000
    });
}

// 点赞文章
const voteArticle = async () => {
    const res = await voteArticleAPI(article.value.id)
    article.value.isVoted = !article.value.isVoted
    if(article.value.isVoted){
        article.value.votedCount++
    }else{
        article.value.votedCount--
    }
    ElMessage({
        type: 'success',
        message: res.data.msg,
        duration: 1000
    });
}

// 继续修改文章
const resumeWrite = (id) => {
    router.push(`/resume/write/${id}`)
}

// 获取文章下的所有评论
const comments = ref([])
const currentPage = ref(1)
const pageSize = ref(2)
const total = ref(0)

// 处理分页
const handlePageChange = (page) => {
    currentPage.value = page
    getArticleComments()
}

// 获取文章评论
const getArticleComments = async () => {
    const res = await getArticleCommentsAPI(article.value.id, currentPage.value, pageSize.value)
    comments.value = res.data.data
    total.value = res.data.total
}

// 评论表单
const commentForm = ref({
    articleId: null,
    body: '',
    parentId: null,
})

// 添加评论
const postArticleComment = async () => {
    commentForm.value.articleId = article.value.id
    console.log(commentForm.value);
    const res = await postArticleCommentAPI(commentForm.value)
    commentForm.value = {}
    await getArticleDetail()
    await getArticleComments()
    ElMessage({
        type: 'success',
        message: res.data.msg,
        duration: 1000
    });
}

// 删除评论
const deleteComment = async (id) => {
    await deleteCommentAPI(id)
    await getArticleDetail()
    await getArticleComments()
    ElMessage({
        type: 'success',
        message: '删除评论成功',
        duration: 1000
    });
}

// 显示/隐藏回复表单
const toggleReplyForm = (commentId, isReply = false) => {
    const formId = isReply ? `reply-${commentId}` : commentId.toString();
    if (!replyForms.value[formId]) {
        replyForms.value[formId] = { body: '', visible: true };
    } else {
        replyForms.value[formId].visible = !replyForms.value[formId].visible;
    }
}

// 提交回复
const submitReply = async (parentId, isReply = false) => {
    const formId = isReply ? `reply-${parentId}` : parentId.toString();
    const body = replyForms.value[formId].body;

    const reply = {
        articleId: article.value.id,
        body: body,
        parentId: parentId
    };

    const res = await postArticleCommentAPI(reply);
    replyForms.value[formId].body = '';
    replyForms.value[formId].visible = false;
    await getArticleComments();
    ElMessage({
        type: 'success',
        message: res.data.msg,
        duration: 1000
    });
}


onMounted(async () => {
    await getArticleDetail()
    await getArticleComments()
})
</script>

<style scoped></style>
