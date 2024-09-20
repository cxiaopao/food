<template>
    <div class="container mx-auto mt-8 flex">
        <!-- 左栏 -->
        <div class="flex flex-col w-1/4">
            <!-- 搜索框 -->
            <div class="flex items-center w-full relative mb-4 ">
                <input v-model="searchArticleInput" placeholder="请搜索您想要浏览的文章"
                    class=" border border-primary px-2 py-4 focus:outline-none flex-grow" />
                <button @click="onSearchArticle(searchArticleInput)"
                    class="bg-primary text-white px-4 py-4 absolute right-0 top-0 bottom-0">
                    搜索
                </button>
            </div>
            <!-- 文章排行榜 -->
            <div class="flex flex-col mt-8">
                <span class="text-black text-lg font-bold pb-2">收藏量最高文章排行榜</span>
                <span class="border-b border-gray-300 w-full mb-4"></span>
                <div class="flex items-center justify-center space-x-4 mb-4" v-for="article in likedArticles"
                    :key="article.id">
                    <router-link :to="`/article/${article.id}`">
                        <img class="w-[100px] h-[70px] mr-4 hover:cursor-pointer rounded-lg" :src="article.img" alt="文章图片">
                    </router-link>
                    <div class="flex flex-col w-full">
                        <router-link :to="`/article/${article.id}`"
                            class="hover:text-primary hover:cursor-pointer text-black text-sm text-center mb-2">
                            <span class="mr-2">{{ article.title }}</span>
                        </router-link>
                    </div>
                </div>
            </div>
            <!-- 文章排行榜 -->
            <div class="flex flex-col mt-8">
                <span class="text-black text-lg font-bold pb-2">点赞量最高文章排行榜</span>
                <span class="border-b border-gray-300 w-full mb-4"></span>
                <div class="flex items-center justify-center space-x-4 mb-4" v-for="article in votedArticles"
                    :key="article.id">
                    <router-link :to="`/article/${article.id}`">
                        <img class="w-[100px] h-[75px] mr-4 hover:cursor-pointer rounded-lg" :src="article.img" alt="文章图片">
                    </router-link>
                    <div class="flex flex-col w-full">
                        <router-link :to="`/article/${article.id}`"
                            class="hover:text-primary hover:cursor-pointer text-black text-sm text-center mb-2">
                            <span class="mr-2">{{ article.title }}</span>
                        </router-link>
                    </div>
                </div>
            </div>
        </div>
        <!-- 右栏 -->
        <div class="relative flex flex-col w-3/4 ml-10 pl-10 h-[900px] ">
            <!-- 分类 -->
            <ul class="flex space-x-2 border-b border-gray-400 mb-4 w-full">
                <button @click="onCategoryArticle('')" class="px-3 py-2 pb-2 text-lg font-bold cursor-pointer"
                    :class="{ 'bg-primary text-white': selectedCategory === '' }">
                    全部分类
                </button>
                <button v-for="category in categories" :key="category.id" @click="onCategoryArticle(category.id)"
                    class="px-3 py-2 pb-2 text-lg font-bold cursor-pointer "
                    :class="{ 'bg-primary': selectedCategory === category.id }">
                    {{ category.name }}
                </button>
            </ul>
            <!-- 文章列表 -->
            <div class=" w-full grid grid-cols-3 gap-3 justify-between">
                <div class="relative cursor-pointer" v-for="article in articles" :key="article.id">
                    <div
                        class="overflow-hidden rounded-lg shadow-none hover:shadow-xl transition-shadow duration-300 ease-in-out">
                        <router-link :to="`/article/${article.id}`">
                            <img :src="article.img" alt="文章图片" class="w-full object-cover h-[250px]">
                        </router-link>
                        <div class="absolute top-0 left-0 right-0 p-2 flex justify-between items-start text-white">
                            <span class="bg-primary bg-opacity-80 px-2 py-1 rounded">收藏量: {{ article.likedCount
                                }}</span>
                            <span class="bg-primary bg-opacity-80 px-2 py-1 rounded">点赞量: {{ article.votedCount
                                }}</span>
                        </div>
                        <div class="p-4 bg-white flex flex-col">
                            <div class="text-xs text-gray-500 mb-4 flex justify-between">
                                <span>作者：{{ article.author.username }}</span>
                                <span>发布日期：{{ article.createTime }}</span>
                            </div>
                            <router-link :to="`article/${article.id}`"
                                class="text-md text-center font-bold mb-1 hover:text-primary">
                                {{ truncateTitle(article.title) }}
                            </router-link>
                            <div class="text-sm text-gray-700">
                                {{ truncateSummary(article.summary) }}
                            </div>
                        </div>
                    </div>
                </div>
                <!-- 分页 -->
                <div class="absolute bottom-0 left-0 right-0 flex justify-center items-center space-x-2">
                    <el-pagination background layout="prev, pager, next" :total="total" :page-size="pageSize"
                        :current-page="currentPage" @current-change="handlePageChange" :hide-on-single-page="true" />
                </div>
            </div>
        </div>
    </div>
</template>

<script setup lang="ts">
import { onMounted, ref } from 'vue';
import { getArticlesAPI, getCategorisAPI, getLikesCountdArticlesAPI, getVotedArticlesAPI } from '../api/article'

const selectedCategory = ref('');
const searchArticleTitle = ref('')
const searchArticleInput = ref('')
const articles = ref([])
const likedArticles = ref([])
const votedArticles = ref([])
const total = ref(0)
const currentPage = ref(1)
const categories = ref([])
const isSearching = ref(false)
const isCategorying = ref(false)
const pageSize = 6


// 截断文章标题
const truncateTitle = (title) => {
    const maxLength = 10;
    return title.length > maxLength ? title.substring(0, maxLength) + '...' : title;
};

// 截断文章摘要
const truncateSummary = (summary) => {
    const maxLength = 20;
    return summary.length > maxLength ? summary.substring(0, maxLength) + '...' : summary;
};

// 获取文章
const getArticles = async (category, search, pageNum) => {
    const res = await getArticlesAPI(category, search, pageNum, pageSize);
    articles.value = res.data.data;
    total.value = res.data.total;
    currentPage.value = pageNum
};

// 获取文章类别
const getCategories = async () => {
    const res = await getCategorisAPI();
    categories.value = res.data.data;
};


// 获取点赞量最多的文章
const getLikedArticles = async () => {
    const res = await getLikesCountdArticlesAPI();
    likedArticles.value = res.data.data;
};

// 获取收藏量最多的文章
const getVotedArticles = async () => {
    const res = await getVotedArticlesAPI();
    votedArticles.value = res.data.data;
};

// 处理分页
const handlePageChange = async (pageNum) => {
    currentPage.value = pageNum;
    if (isSearching.value) {
        await getArticles('', searchArticleTitle.value, pageNum);
    } else if (isCategorying.value) {
        await getArticles(selectedCategory.value, '', pageNum);
    } else {
        await getArticles('', '', pageNum);
    }
};

// 搜索文章
const onSearchArticle = async (title) => {
    isSearching.value = true;
    isCategorying.value = false;
    searchArticleTitle.value = title
    searchArticleInput.value = ''
    selectedCategory.value = null
    await getArticles('', title, 1);
};

// 分类文章
const onCategoryArticle = async (categoryId) => {
    isCategorying.value = true;
    isSearching.value = false;
    selectedCategory.value = categoryId;
    await getArticles(categoryId, '', 1);
};


onMounted(() => {
    getCategories()
    getArticles('', '', 1)
    getLikedArticles()
    getVotedArticles()
});


</script>

<style scoped></style>
