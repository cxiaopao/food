<template>
     <el-carousel height="400px"  :interval="5000">
        <el-carousel-item v-for="ad in banners" :key="ad.id">
            <img class="w-full" :src="ad.img" alt=""> 
        </el-carousel-item>
    </el-carousel>
</template>

<script setup>
import {getBannersAPI} from '@/api/banner'


// 获取广告
const banners = ref([])
const getBanners = async()=>{
    const res = await getBannersAPI()
    banners.value = res.data.data
}

onMounted(()=>{
    getBanners()
})
</script>

<style scoped>

</style>
