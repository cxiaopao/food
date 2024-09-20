<template>
    <div class="container mx-auto mt-8 flex">
        <!-- 左栏 -->
        <div class="flex flex-col w-1/4">
            <!-- 搜索框 -->
            <div class="flex items-center w-full relative mb-4 ">
                <input v-model="searchKey" placeholder="请搜索您的食物"
                    class=" border border-primary px-2 py-4 focus:outline-none flex-grow" />
                <button @click="searchFood" class="bg-primary text-white px-4 py-4 absolute right-0 top-0 bottom-0">
                    搜索
                </button>
            </div>
            <!-- 食品排行榜 -->
            <div class="mb-4">
                <div class="text-black text-lg font-bold pb-2 border-b border-primary w-full">最受喜爱的食品排行榜</div>
                <div class="mt-2 flex items-center" v-for="food in likedFoods" :key="food.id">
                    <router-link class="mr-6" :to="`/food/${food.id}`">
                        <img class="w-24 h-24 rounded-full" :src="food.img">
                    </router-link>
                    <div class="flex flex-col justify-center items-center">
                        <router-link :to="`/food/${food.id}`" class="hover:text-primary">
                            <span class="mr-2 font-bold text-lg">{{ food.name }}</span>
                            <span v-if="food.price.price">¥{{ food.price.price }}</span>
                        </router-link>
                        <span>
                            <el-rate disabled v-model="food.rating" text-color="#FC6736"
                                disabled-void-color="#666"  />
                        </span>
                    </div>
                </div>
            </div>
            <!-- 食品排行榜 -->
            <div class="mb-4">
                <div class="text-black text-lg font-bold pb-2 border-b border-primary w-full">评分最高的食品排行榜</div>
                <div class="mt-2 flex items-center" v-for="food in scoredFoods" :key="food.id">
                    <router-link class="mr-6" :to="`/food/${food.id}`">
                        <img class="w-24 h-24 rounded-full" :src="food.img">
                    </router-link>
                    <div class="flex flex-col justify-center items-center">
                        <router-link :to="`/food/${food.id}`" class="hover:text-primary">
                            <span class="mr-2 font-bold text-lg">{{ food.name }}</span>
                            <span v-if="food.price.price">¥{{ food.price.price }}</span>
                        </router-link>
                        <span>
                            <el-rate disabled  v-model="food.rating" text-color="#FC6736"
                                disabled-void-color="#666" />
                        </span>
                    </div>
                </div>
            </div>
        </div>
        <!-- 右栏 -->
        <div class="flex flex-col w-3/4 ml-10 pl-10 relative h-[960px]">
            <!-- 食品类别 -->
            <ul class="flex space-x-2 border-b border-gray-400 mb-4 w-full">
                <button @click="categoryFood('')" class="px-3 py-2 pb-2 text-lg font-bold cursor-pointer"
                    :class="{ 'bg-primary text-white': categoryKey === '' }">
                    全部分类
                </button>
                <button v-for="category in categories" :key="category.id" @click="categoryFood(category.id)"
                    class="px-3 py-2 pb-2 text-lg font-bold cursor-pointer "
                    :class="{ 'bg-primary': categoryKey === category.id }">
                    {{ category.name }}
                </button>
            </ul>
            <!-- 食品列表 -->
            <div class=" w-full grid grid-cols-3 gap-4 justify-between">
                <div class="cursor-pointer" v-for="food in foods" :key="food.id">
                    <div
                        class="overflow-hidden rounded-lg shadow-none hover:shadow-xl transition-shadow duration-300 ease-in-out">
                        <router-link :to="`/food/${food.id}`">
                            <img :src="food.img" alt="食品图片" class="w-full object-cover h-[250px] ">
                        </router-link>
                        <div class="flex flex-col p-4 bg-white">
                            <div class="text-2xl text-center text-primary mb-3 space-x-3">
                            </div>
                            <router-link :to="`/food/${food.id}`"
                                class="hover:text-primary text-lg text-center font-semibold mb-3">
                                <span class="mr-2">{{ food.name }}</span>
                                <span v-if="food.price.price" class="text-sm text-gray-500">¥ {{ food.price.price }}</span>
                            </router-link>
                            <span class="text-center">
                                <el-rate disabled  v-model="food.rating" text-color="#FC6736"
                                    disabled-void-color="#666" />
                            </span>
                            <div class="text-2xl text-dark mb-3 flex justify-between">
                                <router-link :to="`/food/${food.id}`" class="hover:text-primary hover:text-opacity-50">
                                    <i class="l hover:text-primary fa fa-eye"></i>
                                </router-link>
                                <span @click="addOrRemoveLiked(food)" class=" hover:text-primary hover:text-opacity-50">
                                    <i v-if="food.isLiked" class="fa fa-heart text-primary"></i>
                                    <i v-else class="fa fa-heart-o"></i>
                                </span>
                            </div>
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
</template>

<script setup lang="ts">
import { Star, StarFilled } from '@element-plus/icons-vue';
import { getFoodsAPI, getFoodCategoriesAPI, getTopFoodsAPI, addOrRemoveFoodLikedAPI } from '../api/food';
import { onMounted, ref } from 'vue';

const foods = ref([])
const categories = ref([])
const categoryKey = ref('')
const searchKey = ref('')
const total = ref(0)
const currentPage = ref(1)
const pageSize = ref(6)
const likedFoods = ref([])
const scoredFoods = ref([])


// 获取食品
const getFoods = async () => {
    const res = await getFoodsAPI(
        currentPage.value,
        pageSize.value,
        categoryKey.value,
        searchKey.value
    )
    foods.value = res.data.data
    total.value = res.data.total
};

// 获取食品类别
const getFoodCategories = async () => {
    const res = await getFoodCategoriesAPI(1, 6)
    categories.value = res.data.data
}

// 分类食品，默认为全部食品
const categoryFood = async (category) => {
    categoryKey.value = category
    await getFoods()
}

// 搜索食品
const searchFood = async () => {
    await getFoods()
    searchKey.value = ''
    categoryKey.value = 0
}

// 处理分页
const handlePageChange = (page) => {
    currentPage.value = page
    getFoods()
};


// 获取最受喜爱的排行榜食品
const getLikedFoods = async () => {
    const res = await getTopFoodsAPI(1)
    likedFoods.value = res.data.data
}

// 获取评分最高的排行榜食品
const getScoredFoods = async () => {
    const res = await getTopFoodsAPI(2)
    scoredFoods.value = res.data.data
}

// 添加或者取消喜爱
const addOrRemoveLiked = async (food) => {
    const res = await addOrRemoveFoodLikedAPI(food.id)
    food.isLiked = !food.isLiked;
    ElMessage({
        type: 'success',
        message: res.data.msg,
        duration: 1000
    });
}

onMounted(() => {
    getFoods()
    getFoodCategories()
    getLikedFoods()
    getScoredFoods()
})

</script>

<style scoped></style>