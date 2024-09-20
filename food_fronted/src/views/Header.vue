<template>
    <header class="container mx-auto flex justify-between items-center h-[80px]">
        <router-link to="/">
            <img src="../assets/img/logo.png" class="w-[50px] h-[50px]" alt="logo">
        </router-link>
        <ol class="flex justify-center items-center space-x-6">
            <router-link to="/" active-class="text-primary" >主页</router-link>
            <router-link to="/food" active-class="text-primary" >食品信息</router-link>
            <router-link to="/forum" active-class="text-primary" >食品论坛</router-link>
            <router-link to="/write" active-class="text-primary" >写文章</router-link>
        </ol>
        <el-dropdown class="dropdown" v-if="isShow">
            <el-avatar class=" border-none" :size="50" :src="userStore.userInfo.avatar" />
            <template #dropdown>
                <el-dropdown-menu>
                    <el-dropdown-item v-if="userStore.userInfo.isStaff" @click="toAdmin">后台管理</el-dropdown-item>
                    <el-dropdown-item @click="toProfile">个人信息</el-dropdown-item>
                    <el-dropdown-item @click="toArticleView">我的文章</el-dropdown-item>
                    <el-dropdown-item @click="logout">退出登录</el-dropdown-item>
                </el-dropdown-menu>
            </template>
        </el-dropdown>
        <div class="flex space-x-4 text-md" v-else>
            <router-link to="/login" active-class="text-primary" class="hover:text-primary hover:cursor-pointer">
                登录
            </router-link>
            <router-link to="/register" active-class="text-primary" class="hover:text-primary hover:cursor-pointer">
                注册
            </router-link>
        </div>
    </header>

</template>

<script setup lang="ts">
import { ref, watch } from 'vue';
import { useUserStore } from '../stores/userStore';
import { useRouter } from 'vue-router';

const userStore = useUserStore()
const isShow = ref(true)
const router = useRouter()

watch(() => userStore.userInfo, (newVal) => {
    isShow.value = Object.keys(newVal).length > 0;
  },
  { immediate: true }
);

// 跳转去后台管理
const toAdmin = () => {
    window.location.href =  import.meta.env.VITE_APP_BASE_API + 'admin/';
}

// 退出登录
const logout = () => {
    ElMessageBox.confirm(
        '确认退出登录吗?',
        '警告',
        {
            confirmButtonText: '确认',
            cancelButtonText: '取消',
            type: 'warning',
        }
    ).then(() => {
        ElMessage({
            type: 'success',
            message: '退出登录成功',
        })
        router.push('/')
        userStore.clearUserInfo()
    })
   
}

// 跳转个人信息
const toProfile = ()=>{
    router.push('/profile/info')
}

// 跳转文章
const toArticleView = ()=>{
    router.push(`/article/view/${userStore.userInfo.id}`)
}

</script>

<style scoped>
.dropdown:deep(.el-tooltip__trigger:focus-visible) {
    outline: unset;
}
</style>
