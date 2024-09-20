import { defineStore } from "pinia";
import { loginAPI, logoutAPI, updateUserAPI } from "../api/user";
import Cookies from "js-cookie";

export const useUserStore = defineStore('user', ()=>{

    const userInfo = ref({})

    const getUserInfo = async(username, password)=>{
        const res = await loginAPI(username, password)
        userInfo.value = res.data.data
        Cookies.set("csrftoken", res.data.data.csrf_token, { path: "/", secure: true });
        Cookies.set("sessionid", res.data.data.session_id, { path: "/", secure: true });
    }
    
    const clearUserInfo = async()=>{
        userInfo.value = {}
        await logoutAPI()
        Cookies.remove('csrftoken', { path: '/' });
        Cookies.remove('sessionid', { path: '/' });
    }

    const updateUserInfo = async(updatedInfo)=>{
        const res = await updateUserAPI(updatedInfo);
        userInfo.value = { ...userInfo.value, ...res.data.data };
    }

    const isLoggedIn = computed(() => !!userInfo.value.id) // 判断是否已登录
    
    return {userInfo, getUserInfo, clearUserInfo, updateUserInfo, isLoggedIn }
},
//持久化
{
    persist: true,
})