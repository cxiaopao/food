import service from "./config"


// 登录API
export const loginAPI = (username, password)=>{
    return service({
        url: '/user/login/',
        method: 'POST',
        data: {
            username: username,
            password: password
        }
    })
}

// 退出登录API
export const logoutAPI = ()=>{
    return service({
        url: '/user/logout/',
    })
}

// 更新用户信息API
export const updateUserAPI = (formData)=>{
    return service({
        url: '/user/update/',
        method: 'POST',
        data: formData,
        headers: {
            'Content-Type': 'multipart/form-data'
        }
    })
}

// 更新密码
export const updatePasswordAPI = (data)=>{
    return service({
        url: '/user/password/',
        method: 'PATCH',
        data: data
    })
}

// 查看他人信息接口
export const getUserAPI = (userId)=>{
    return service({
        url: '/user/',  
        params:{
            userId
        }
    })
}

// 发送验证码API
export const postCodeAPI = (email)=>{
    return service({
        url: '/user/send/code/', 
        method: 'POST', 
        data: email
    })
}


// 注册API
export const registerAPI = (data)=>{
    return service({
        url: '/user/register/', 
        method: 'POST', 
        data: data
    })
}

