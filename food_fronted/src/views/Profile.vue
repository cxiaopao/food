<template>
    <div class="container mx-auto mb-8 mt-10">
        <div class="flex">
            <!-- 菜单栏 -->
            <nav class="flex justify-center items-start w-1/5 h-[300px] mr-4 bg-white">
                <ul class="space-y-4 w-full text-center p-4">
                    <li>
                        <router-link to="/profile/info" active-class="text-white bg-primary"
                           class="block p-2 rounded hover:bg-primary hover:text-white">个人资料</router-link>
                    </li>
                    <li>
                        <router-link to="/profile/password" active-class="text-white bg-primary"
                           class="block p-2 rounded hover:bg-primary hover:text-white">修改密码</router-link>
                    </li>   
                    <li>
                        <router-link to="/profile/article" active-class="text-white bg-primary"
                           class="block p-2 rounded hover:bg-primary hover:text-white">文章收藏列表</router-link>
                    </li>
                    <li>
                        <router-link to="/profile/food" active-class="text-white bg-primary"
                           class="block p-2 rounded hover:bg-primary hover:text-white">食品喜爱列表</router-link>
                    </li>
                </ul>
            </nav>
            <div class="flex flex-col w-full">
                <!-- 头部 -->
                <div class="flex w-full p-8 bg-white mb-4 items-center">
                    <img class="rounded-full h-[100px] w-[100px] object-cover" :src="userStore.userInfo.avatar"
                         alt="用户头像">
                    <div class="flex flex-col ml-4 space-y-2">
                        <span class="text-xl text-zinc">用户名：{{ userStore.userInfo.username }}</span>
                        <span class="text-gray-500">个人简介：{{ userStore.userInfo.bio }}</span>
                    </div>
                </div>
                <router-view></router-view>
            </div>
        </div>
    </div>
</template>

<script setup lang="ts">
    import { useUserStore } from '../stores/userStore';
    
    const userStore = useUserStore()

</script>

<style scoped>

</style>
