import service from "./config"

// 获取食品API
export const getFoodsAPI = (pageNum, pageSize, category, search)=>{
    return service({
        url: '/food/all/',
        params: {
            pageNum,
            pageSize,
            category,
            search
        }
    })
}

// 获取食品类别API
export const getFoodCategoriesAPI = (pageNum, pageSize)=>{
    return service({
        url: '/food/categories/',
        params: {
            pageNum,
            pageSize
        }
    })
}

// 获取食品详情API
export const getFoodDetailAPI = (foodId)=>{
    return service({
        url: `/food/${foodId}`,
    })
}


// 获取排行榜食品API
export const getTopFoodsAPI = (top)=>{
    return service({
        url: '/food/top/',
        params: {
           top
        }
    })
}


// 添加或者移除喜爱食品API
export const addOrRemoveFoodLikedAPI = (foodId)=>{
    return service({
        url: '/food/liked/',
        method: 'PATCH',
        params: {
            foodId
        }
    })
}


// 获取收藏的食品
export const getLikedFoodsAPI = ()=>{
    return service({
        url: '/food/likes/',
    })
}

// 获取食品的历史价格信息API
export const getFoodPricesAPI = (foodId) => {
    return service({
        url: '/food/prices/',
        params: {
            foodId
        }
    })
}


// 获取食品的评价信息API
export const getFoodReviewsAPI = (foodId, pageNum, pageSize)=>{
    return service({
        url: '/food/reviews/',
        params: {
            foodId,
            pageNum,
            pageSize
        }
    })
}

// 发布评价API
export const postFoodReviewAPI = (data)=>{
    return service({
        url: '/food/review/add/',
        method: 'POST',
        data: data
    })
}

// 删除评价API
export const deleteFoodReviewAPI = (userId)=>{
    return service({
        url: '/food/review/delete/',
        method: 'DELETE',
        params: {
            userId
        }
    })
}

// 导出食品数据
export const exportFoodDataAPI = (foodName)=>{
    return service({
        url: '/food/export-food',
        method: 'GET',
        params: {
            foodName
        },
        responseType: 'blob'
    })
}