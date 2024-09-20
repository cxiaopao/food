<template>
    <div class="flex items-center justify-center bg-primary bg-opacity-50 h-[600px]">
      <div class="bg-white rounded-full p-20 shadow-lg w-1/3 flex flex-col items-center">
        <div class="text-center mb-6">
          <h1 class="text-3xl font-semibold hover:cursor-pointer">
            <router-link to="/login" class="hover:text-primary text-primary">登录</router-link>
            or
            <router-link to="/register" class="hover:text-primary text-primary text-opacity-50">注册</router-link>
          </h1>
          <div class="border-t-2 border-gray-200 w-1/4 mx-auto mt-3"></div>
        </div>
  
        <el-form :model="form" class="w-[250px]">
          <el-form-item>
            <el-input v-model="form.username" placeholder="用户名" size="large" />
          </el-form-item>
          <el-form-item>
            <el-input v-model="form.password" type="password" placeholder="密码" size="large" />
          </el-form-item>
          <el-button class="w-full" type="primary" @click="onLogin" size="large">登录</el-button>
        </el-form>
      </div>
    </div>
  </template>
  
  <script setup lang="ts">
  import { ElMessage } from 'element-plus';
  import { useUserStore } from '../stores/userStore';
  import { useRouter, useRoute } from 'vue-router';
  
  const router = useRouter();
  const route = useRoute();
  const userStore = useUserStore();
  const form = reactive({
    username: '',
    password: ''
  });
  
  const onLogin = async () => {
    await userStore.getUserInfo(form.username, form.password);
    ElMessage({ type: 'success', message: '登录成功', duration: 1000 });
  
    const redirectPath = route.query.redirect || '/';
    router.push(redirectPath as string);
  };
  </script>
  
  <style scoped>
  </style>
  