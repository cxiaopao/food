<template>
    <div class="container mx-auto mt-24">
        <div class="flex flex-col justify-center items-center">
            <span class="border-2 border-black w-20 rounded-sm"></span>
            <span class="text-4xl text-zinc-950 font-medium my-10">食品信息：让信息，更透明</span>
            <span class=" text-zinc-700 text-center">
                在现代社会，食品安全和透明度变得尤为重要。
                我们越来越关注所购买和食用的食品的来源、成分和生产过程。
                透明的信息使得我们可以做出更明智的选择，从而保障我们的健康和安全。
                让食品信息更透明，不仅是对消费者的尊重，更是对整个社会健康发展的承诺。
            </span>
        </div>

        <!-- 收藏最高的一篇文章 -->
        <div class="mt-24 ml-2 flex justify-between">
            <img class="mr-10 w-2/3 h-[300px] object-cover rounded-lg" :src="sigleLikedArticle.img" alt="文章图片" />
            <div class="w-1/3 flex flex-col mr-14 items-center">
                <span class="pt-10 text-3xl text-zinc-900 text-center">{{ sigleLikedArticle.title }}</span>
                <span class="pt-10 text-zinc-400">
                    {{ truncate(sigleLikedArticle.summary) }}
                </span>
                <router-link :to="`/article/${sigleLikedArticle.id}`"
                    class="mt-6 border-2 border-primary text-primary py-2 px-6 rounded-full" to="">
                    查看详情
                </router-link>
            </div>
        </div>

        <!-- 收藏量最高的食品展览 -->
        <div class="mt-24 flex flex-col items-center">
            <div class="py-4 w-full flex justify-center items-center text-2xl font-bold mb-4">收藏量最高的食品</div>
            <div class="w-full flex flex-wrap justify-center md:justify-between">
                <router-link :to="`/food/${food.id}`" class="group p-2 cursor-pointer w-full sm:w-1/2 md:w-1/4"
                    v-for="food in likedFoods" :key="food.id">
                    <div
                        class="relative overflow-hidden rounded-lg shadow-none hover:shadow-xl transition-shadow duration-300 ease-in-out">
                        <img :src="food.img" alt="食品图片" class="w-full object-cover h-[200px]">
                        <div
                            class="absolute bottom-0 left-0 right-0 bg-white bg-opacity-75 p-2 hidden group-hover:block group-hover:rounded-b-lg">
                            <div class="flex justify-center ">
                                <el-rate disabled v-model="food.rating" text-color="#FC6736"
                                    disabled-void-color="#666" />
                            </div>
                            <div class="text-center">{{ food.name }}</div>
                        </div>
                    </div>
                </router-link>
            </div>
        </div>

        <!-- 评分最高的食品展览 -->
        <div class="mt-24 flex flex-col items-center">
            <div class="py-4 w-full flex justify-center items-center text-2xl font-bold mb-4">评分最高的食品</div>
            <div class="w-full flex flex-wrap justify-center md:justify-between">
                <router-link :to="`/food/${food.id}`" class="group p-2 cursor-pointer w-full sm:w-1/2 md:w-1/4"
                    v-for="food in ratingFoods" :key="food.id">
                    <div
                        class="relative overflow-hidden rounded-lg shadow-none hover:shadow-xl transition-shadow duration-300 ease-in-out">
                        <img :src="food.img" alt="食品图片" class="w-full object-cover h-[200px]">
                        <div
                            class="absolute bottom-0 left-0 right-0 bg-white bg-opacity-75 p-2 hidden group-hover:block group-hover:rounded-b-lg">
                            <div class="flex justify-center ">
                                <el-rate disabled v-model="food.rating" text-color="#FC6736"
                                    disabled-void-color="#666" />
                            </div>
                            <div class="text-center">{{ food.name }}</div>
                        </div>
                    </div>
                </router-link>
            </div>
        </div>

        <!-- 点赞量高的一篇文章 -->
        <div class="mt-24 ml-2 flex justify-between">
            <img class="mr-10 w-2/3 h-[300px] object-cover rounded-lg" :src="sigleVotedArticle.img" alt="文章图片" />
            <div class="w-1/3 flex flex-col mr-14 items-center">
                <span class="pt-10 text-3xl text-zinc-900 text-center">{{ sigleVotedArticle.title }}</span>
                <span class="pt-10 text-zinc-400">
                    {{ truncate(sigleVotedArticle.summary, 50) }}
                </span>
                <router-link :to="`/article/${sigleVotedArticle.id}`"
                    class="mt-6 border-2 border-primary text-primary py-2 px-6 rounded-full" to="">
                    查看详情
                </router-link>
            </div>
        </div>

        <!-- 最新文章展览组 -->
        <div class="mt-24 mb-10 flex flex-col items-center">
            <div class="py-4 w-full flex justify-center items-center text-3xl font-bold mb-4">最新发布文章</div>
            <div class="w-full flex flex-wrap justify-between">
                <router-link :to="`/article/${article.id}`" v-for="article in latestArticles" :key="article.id"
                    class="group relative p-2 cursor-pointer flex-auto md:w-1/4 lg:w-1/5">
                    <div
                        class="overflow-hidden rounded-lg shadow-none hover:shadow-xl transition-shadow duration-300 ease-in-out">
                        <img :src="article.img" alt="文章图片" class="w-full object-cover h-[250px]">
                        <div class="absolute top-0 left-0 right-0 p-2 flex justify-between items-start text-white">
                            <span class="bg-primary bg-opacity-80 px-2 py-1 rounded">点赞量: {{ article.votedCount }}</span>
                            <span class="bg-primary bg-opacity-80 px-2 py-1 rounded">收藏量: {{ article.likedCount }}</span>
                        </div>
                        <div class="p-4 bg-white">
                            <div class="text-xs text-gray-500 mb-2 flex justify-between" v-if="article.author">
                                <span>作者：{{ article.author.username }}</span>
                                <span>发布日期：{{ article.updateTime }}</span>
                            </div>
                            <div class="text-lg text-center font-semibold mb-1">{{ truncate(article.title, 10) }}</div>
                            <div class="text-sm text-gray-700">{{ truncate(article.summary, 30) }}</div>
                        </div>
                    </div>
                </router-link>
            </div>
        </div>

    </div>

</template>

<script setup>
import { getLikedOneArticleAPI, getVotedOneArticleAPI, getLatestArticlesAPI } from '@/api/article'
import { getTopFoodsAPI } from '@/api/food'

// 截断文章
const truncate = (text='', maxLength) => {
    return text.length > maxLength ? text.substring(0, maxLength) + '...' : text;
};

// 获取收藏量最高的文章
const sigleLikedArticle = ref({
    title: '',
    summary: '',
    img: ''
})
const getSingleLikedArticle = async () => {
    const res = await getLikedOneArticleAPI()
    sigleLikedArticle.value = res.data.data
}


// 获取收藏量最多的食品
const likedFoods = ref([])
const getLikedFoods = async () => {
    const res = await getTopFoodsAPI(1)
    likedFoods.value = res.data.data
}

// 获取评分最高的食品
const ratingFoods = ref([])
const getratingFoods = async () => {
    const res = await getTopFoodsAPI(2)
    ratingFoods.value = res.data.data
}


// 获取点赞量最高的文章
const sigleVotedArticle = ref({
    title: '',
    summary: '',
    img: ''
})
const getSingleVotedArticle = async () => {
    const res = await getVotedOneArticleAPI()
    sigleVotedArticle.value = res.data.data
}


// 获取最新时间的文章
const latestArticles = ref({
    title: '',
    summary: '',
    img: '',
    author: {
        username: ''
    }
})
const getLatestArticles = async () => {
    const res = await getLatestArticlesAPI(4)
    latestArticles.value = res.data.data
}

onMounted(() => {
    getSingleLikedArticle()
    getLikedFoods()
    getratingFoods()
    getSingleVotedArticle()
    getLatestArticles()
})
</script>

<style scoped></style>
