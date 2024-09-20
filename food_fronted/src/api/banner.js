import service from "./config"


// 获取banner
export const getBannersAPI = ()=>{
    return service({
        url: '/banner/ads/',
    })
}