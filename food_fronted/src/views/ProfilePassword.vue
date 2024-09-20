<template>
    <div class="flex flex-col w-full p-8 bg-white">
        <span class="font-bold text-2xl border-b border-gray-300 pb-2 mb-6">修改密码</span>
        <div class="flex flex-col">
            <div class="mb-4">
                <label for="password" class="block text-zinc-700">旧密码</label>
                <input type="password" id="password" v-model="form.password" placeholder="请输入您的旧密码"
                    class="mt-1 p-2 w-full border rounded-lg focus:outline-none focus:ring-primary focus:border-primary" />
            </div>
            <div class="mb-4">
                <label for="newPassword" class="block text-zinc-700">新密码</label>
                <input type="password" id="newPassword" v-model="form.newPassword" placeholder="请输入您的新密码"
                    class="mt-1 p-2 w-full border rounded-lg focus:outline-none focus:ring-primary focus:border-primary" />
            </div>
            <div class="mb-4">
                <label for="reNewPassword" class="block text-zinc-700 ">确认新密码</label>
                <input type="password" id="reNewPassword" v-model="form.reNewPassword" placeholder="请再次输入您的新密码"
                    class="mt-1 p-2 w-full border rounded-lg focus:outline-none focus:ring-primary focus:border-primary" />
            </div>
        </div>
        <button @click="onSubmit"
            class="w-[150px] bg-primary text-white py-2 px-4 rounded hover:bg-primary hover:opacity-50">
            确认修改
        </button>
    </div>
</template>

<script setup>
import { updatePasswordAPI } from "../api/user";
import { useUserStore } from "../stores/userStore"
import router from "../router"

const form = ref({
    password: '',
    newPassword: '',
    reNewPassword: ''
})

const onSubmit = () => {
    ElMessageBox.confirm(
        '确定更新信息吗?',
        '警告',
        {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning',
        }
    ).then(async() => {
        const res = await updatePasswordAPI(form.value)
        ElMessage.success(res.data.msg)
        const userStore = useUserStore()
        await userStore.clearUserInfo()
        router.push('/login')
    })

}

</script>

<style scoped></style>
