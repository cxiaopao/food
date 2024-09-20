<template>
    <div class="flex flex-col w-full p-8 bg-white relative">
        <span class="font-bold text-2xl border-b border-gray-300 pb-2 mb-6">食品喜爱列表</span>
        <input v-model="searchQuery" type="text" placeholder="搜索食品"
                class="w-full border focus:outline-none focus:border-primary rounded-full py-2 px-4 mx-4 text-sm">
        <div class="grid grid-cols-4 gap-4 px-4 pb-24 py-4">
            <router-link :to="`/food/${food.id}`" v-for="food in pageFoods" :key="food.id"
                class="group relative cursor-pointer rounded-lg shadow-none hover:shadow-xl bg-primary transition-shadow duration-300 ease-in-out">
                <img :src="food.img" alt="食品图片" class="h-full p-4">
                <div
                    class="absolute bottom-0 left-0 right-0 bg-white bg-opacity-75 py-6 hidden group-hover:block group-hover:rounded-b-lg">
                    <div class="text-center">{{ food.name }}</div>
                </div>
            </router-link>
        </div>
        <div class="absolute bottom-2 right-0 left-0 flex justify-center items-center">
            <el-pagination layout="prev, pager, next" :total="totalFoods" :page-size="pageSize"
                :current-page="currentPage" @current-change="handlePageChange" hide-on-single-page />
        </div>
    </div>
</template>

<script setup>
import { getLikedFoodsAPI } from '@/api/food'


const foods = ref([])
const pageSize = ref(4)
const currentPage = ref(1)
const totalFoods = computed(() => filteredFoods.value.length)
const searchQuery = ref('')

// 获取用户收藏的食品信息
const getLikedFoods = async () => {
    const res = await getLikedFoodsAPI()
    foods.value = res.data.data
}

// 处理分页
const handlePageChange = (page) => {
    currentPage.value = page
}

// 获取当前页的食品
const pageFoods = computed(() => {
    const start = (currentPage.value - 1) * pageSize.value
    const end = start + pageSize.value
    return filteredFoods.value.slice(start, end)
})

// 过滤后的食品列表
const filteredFoods = computed(() => {
    if (searchQuery.value) {
        return foods.value.filter(food =>
            food.name?.includes(searchQuery.value)
        )
    }
    return foods.value
})

onMounted(() => {
    getLikedFoods()
})
</script>

<style scoped></style>
