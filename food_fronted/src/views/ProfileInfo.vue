<template>
    <!-- 修改基本信息 -->
    <div id="change-profile" class="flex flex-col w-full p-8 bg-white">
        <span class="font-bold text-2xl border-b border-gray-300 pb-2 mb-6">基本信息</span>
        <div class="grid grid-cols-2 gap-4">
            <div class="mb-4">
                <label for="email" class="block text-zinc-700">邮箱</label>
                <input type="text" id="email" placeholder="请输入您的邮箱" v-model="form.email"
                    class="mt-1 p-2 w-full border rounded-lg focus:outline-none focus:ring-primary focus:border-primary" />
            </div>
            <div class="mb-4">
                <label for="phone" class="block text-zinc-700">电话</label>
                <input type="text" id="phone" placeholder="请输入您的电话" v-model="form.phone"
                    class="mt-1 p-2 w-full border rounded-lg focus:outline-none focus:ring-primary focus:border-primary" />
            </div>
            <div class="mb-4">
                <label for="wechat" class="block text-zinc-700 ">微信</label>
                <input type="text" id="wechat" placeholder="请输入您的微信" v-model="form.wechat"
                    class="mt-1 p-2 w-full border rounded-lg focus:outline-none focus:ring-primary focus:border-primary" />
            </div>
            <div class="mb-4">
                <label for="qq" class="block text-zinc-700 ">QQ</label>
                <input type="text" id="qq" placeholder="请输入您的QQ" v-model="form.qq"
                    class="mt-1 p-2 w-full border rounded-lg focus:outline-none focus:ring-primary focus:border-primary" />
            </div>
            <div class="mb-4 col-span-2">
                <label for="bio" class="block text-zinc-700 ">简介</label>
                <textarea rows="4" id="bio" placeholder="请输入您的简介" v-model="form.bio"
                    class="text-left mt-1 p-2 w-full border rounded-lg focus:outline-none focus:ring-primary focus:border-primary"></textarea>
            </div>
            <div class="flex justify-start items-center w-full mb-6">
                <label for="avatar" class="block text-zinc-700 mr-2">头像</label>
                <el-upload class="rounded-full h-[120px] w-[120px] p-1 flex flex-col items-center justify-center
                                space-y-2 text-gray-400 border  border-gray-300 hover:text-primary transition-all"
                    :show-file-list="false" 
                    :auto-upload="false"
                    :on-change="handleAvatarChange">
                    <img v-if="form.avatarUrl" :src="form.avatarUrl" class="rounded-full h-[100px] w-[100px]" />
                    <el-icon v-else class="text-lg text-gray-300">
                        <Plus />
                    </el-icon>
                </el-upload>
            </div>
        </div>
        <button @click="onSubmit" class="w-[150px] bg-primary text-white py-2 px-4 rounded hover:bg-primary hover:opacity-50">
            更新信息
        </button>
    </div>
</template>

<script setup>
import { reactive } from 'vue';
import { useUserStore } from '../stores/userStore';

const userStore = useUserStore()
const userInfo = userStore.userInfo
const form = ref({
    email: userInfo.email,
    phone: userInfo.phone,
    wechat: userInfo.wechat,
    qq: userInfo.qq,
    bio: userInfo.bio,
    avatar: null,
    avatarUrl: userInfo.avatar ? userInfo.avatar : null
})

const onSubmit =  () => {
    ElMessageBox.confirm(
        '确定更新信息吗?',
        '警告',
        {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning',
        }
    ).then( async() => {
        let formData = new FormData()
        Object.keys(form.value).forEach(key => {
            formData.append(key, form.value[key]);
        });
        if (form.value.avatar) {
            formData.append('avatar', form.value.avatar);
        }
        await userStore.updateUserInfo(formData);
        ElMessage({
            type: 'success',
            message: '更新成功',
            duration: 1500,
        })
    })
}


const handleAvatarChange = (file) => {
    form.value.avatar = file.raw;
    form.value.avatarUrl = URL.createObjectURL(file.raw);
};


</script>

<style scoped></style>
