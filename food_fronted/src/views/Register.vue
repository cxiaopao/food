<template>
    <div class="flex items-center justify-center bg-primary bg-opacity-50 h-[600px]">
        <div class="bg-white rounded-lg p-20 shadow-lg w-1/3 flex flex-col items-center">
            <div class="text-center mb-6">
                <h1 class="text-3xl font-semibold hover:cursor-pointer">
                    <router-link to="/login" class="hover:text-primary text-primary text-opacity-50">登录</router-link>
                    or
                    <router-link to="/register" class="hover:text-primary text-primary">注册</router-link>
                </h1>
                <div class="border-t-2 border-gray-200 w-1/4 mx-auto mt-3"></div>
            </div>

            <el-form :model="form" class="w-[250px]">
                <el-form-item>
                    <el-input v-model="form.username" placeholder="用户名" size="large" />
                </el-form-item>
                <el-form-item>
                    <el-input v-model="form.password1" type="password" placeholder="密码" size="large" />
                </el-form-item>
                <el-form-item>
                    <el-input v-model="form.password2" type="password" placeholder="确认密码" size="large" />
                </el-form-item>
                <el-form-item>
                    <el-input v-model="form.email" placeholder="邮箱" size="large" />
                </el-form-item>
                <el-form-item>
                    <el-input v-model="form.code" placeholder="验证码" size="large">
                        <template #append>
                            <el-button type="primary" :disabled="isSending || countdown > 0"
                                @click="sendVerificationCode">
                                <span v-if="countdown === 0">发送验证码</span>
                                <span v-else>{{ countdown }} 秒</span>
                            </el-button>
                        </template>
                    </el-input>
                </el-form-item>
                <el-button class="w-full" type="primary" @click="onRegister" size="large">注册</el-button>
            </el-form>
        </div>
    </div>
</template>

<script setup lang="ts">
import { postCodeAPI, registerAPI } from '@/api/user';
import { useRouter } from 'vue-router';

const router = useRouter()
const form = ref({
    username: '',
    password1: '',
    password2: '',
    email: '',
    code: ''
})
const countdown = ref(0);
const isSending = ref(false);
let timer: number | undefined;

const sendVerificationCode = async () => {
    if (!form.value.email) {
        ElMessage({ type: 'warning', message: '请输入邮箱', duration: 1000 })
        return;
    }

    isSending.value = true;

    try {
        await postCodeAPI({ email: form.value.email });
        countdown.value = 120;
        timer = setInterval(() => {
            if (countdown.value > 0) {
                countdown.value--;
            } else {
                clearInterval(timer);
            }
        }, 1000);
    } finally {
        isSending.value = false;
    }
};


const onRegister = async () => {
    if (form.value.username.trim().length <= 2) {
        ElMessage({ type: 'warning', message: '用户名必须大于2个字符', duration: 1000 });
        return;
    }
    if (form.value.password1.trim().length < 6) {
        ElMessage({ type: 'warning', message: '密码长度必须大于6个字符', duration: 1000 });
        return;
    }
    if (form.value.password1 !== form.value.password2) {
        ElMessage({ type: 'warning', message: '两次输入的密码不一致', duration: 1000 });
        return;
    }
    if (!form.value.email.trim()) {
        ElMessage({ type: 'warning', message: '请输入邮箱', duration: 1000 });
        return;
    }
    if (!form.value.code.trim()) {
        ElMessage({ type: 'warning', message: '请输入验证码', duration: 1000 });
        return;
    }

    
    const response = await registerAPI({
        username: form.value.username.trim(),
        password1: form.value.password1.trim(),
        password2: form.value.password2.trim(),
        email: form.value.email.trim(),
        code: form.value.code.trim()
    });

    if(response.data.code===0){
        ElMessage({ type: 'success', message: '注册成功', duration: 2000 })
    }
  
    router.push('/login')

};

</script>

<style scoped></style>
