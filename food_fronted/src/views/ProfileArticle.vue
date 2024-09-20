<template>
    <div class="relative flex flex-col w-full p-8 bg-white">
        <span class="font-bold text-2xl border-b border-gray-300 pb-2 mb-6">文章收藏列表</span>
        <div class="flex items-center mb-4">
            <input v-model="searchQuery" type="text" placeholder="搜索文章"
                class="w-full border focus:outline-none focus:border-primary rounded-full py-2 px-4 text-sm">
        </div>
        <div class="flex flex-col pb-12 h-[600px] relative">
            <div v-for="article in pagedArticles" :key="article.id"
                class="block bg-gray-100 hover:bg-gray-200 transition duration-300 rounded-lg shadow overflow-hidden mb-4">
                <div class="p-4">
                    <div class="flex flex-col w-full">
                        <h3 class="text-gray-800 hover:text-primary text-lg mb-2">
                            <router-link :to="`/article/${article.id}`">{{ article.title }}</router-link>
                        </h3>
                        <div class="flex ">
                            <p class="text-gray-600 text-sm mt-2">
                                发布于 {{ article.updateTime }}
                                · {{ article.views }} 阅读量
                                · {{ article.comments }} 评论
                                · {{ article.votedCount }} 点赞
                                · {{ article.likedCount }} 收藏
                            </p>
                            <button @click="removeLiked(article.id)"
                                class="delete-article-btn ml-auto text-gray-600 hover:text-primary mr-2 text-lg">
                                <span v-if="article.isLiked" class="fa fa-heart text-primary"></span>
                                <span v-else class="fa fa-heart-o"></span>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="absolute bottom-0">
                <el-pagination layout="prev, pager, next" :total="totalArticles" :page-size="pageSize"
                    :current-page="currentPage" @current-change="handlePageChange" />
            </div>
        </div>
    </div>
</template>

<script setup>
import { getLikedArticlesAPI, likeArticleAPI } from "@/api/article"
import { ref, onMounted, computed } from 'vue'
import { useUserStore } from '@/stores/userStore'

const userStore = useUserStore()
const userId = userStore.userInfo.id

const articles = ref([])
const currentPage = ref(1)
const pageSize = ref(5)
const searchQuery = ref('')
const totalArticles = computed(() => filteredArticles.value.length)

const getLikedArticles = async () => {
    const res = await getLikedArticlesAPI()
    articles.value = res.data.data
}

// 处理分页
const handlePageChange = (page) => {
    currentPage.value = page
}

// 移除收藏文章
const removeLiked = (id) => {
    ElMessageBox.confirm(
        '确定取消收藏该文章吗?',
        '警告',
        {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning',
        }
    ).then(async () => {
        const res = await likeArticleAPI(id)
        ElMessage({
            type: 'success',
            message: res.data.msg,
            duration: 1000
        });
        await getLikedArticles()
    }).catch(() => {
        ElMessage({
            type: 'info',
            message: '已取消操作',
            duration: 1000
        });
    });
}

// 过滤后的文章列表
const filteredArticles = computed(() => {
    if (searchQuery.value) {
        return articles.value.filter(article =>
            article.title?.includes(searchQuery.value) ||
            article.content?.includes(searchQuery.value)
        )
    }
    return articles.value
})

// 获取当前页的文章
const pagedArticles = computed(() => {
    const start = (currentPage.value - 1) * pageSize.value
    const end = start + pageSize.value
    return filteredArticles.value.slice(start, end)
})

onMounted(() => {
    getLikedArticles()
})

</script>

<style scoped></style>
