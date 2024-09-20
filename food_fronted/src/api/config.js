import axios from "axios"
import { useUserStore } from "../stores/userStore";
import { ElMessage } from 'element-plus'
import Cookies from "js-cookie";
import router from "../router"

const service = axios.create({
    // baseURL: 'http://localhost:9000/',
    baseURL: import.meta.env.VITE_APP_BASE_API,
    timeout: 10000,
    withCredentials: true
})


// 请求拦截器
service.interceptors.request.use(
     config => {
        return config;
    },
    error => {
        return Promise.reject(error);
    }
)

// 响应拦截器
service.interceptors.response.use(
    response => {
        return response;
    },
    error => {
        const userStore = useUserStore()
        ElMessage({ type: 'warning', message: error.response.data.msg })
        if(error.response.data.code === 401){
            userStore.clearUserInfo()
            router.push('/login')
        }
        if(error.response.data.code===404){
            router.push('/404')
        }
        return Promise.reject(error);
    }
);


export default service