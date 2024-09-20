import service from "./config"


// 获取文章接口
export const getArticlesAPI = (category, search, pageNum, pageSize) => {
    return service({
        url: '/forum/articles/',
        params: {
            category,
            search,
            pageNum,
            pageSize
        }
    })
}


// 获取文章类别接口
export const getCategorisAPI = ()=>{
    return service({
        url: '/forum/categories/',
    })
}

// 获取点赞量最高的多篇文章接口
export const getLikesCountdArticlesAPI = ()=>{
    return service({
        url: '/forum/top/',
        params:{
            top: 1
        }
    })
}

// 获取收藏量最高的多篇文章接口
export const getVotedArticlesAPI = ()=>{
    return service({
        url: '/forum/top/',
        params:{
            top: 2
        }
    })
}

// 获取收藏量最高的一篇文章接口
export const getLikedOneArticleAPI = ()=>{
    return service({
        url: '/forum/top/',
        params:{
            single: 1
        }
    })
}

// 获取点赞量最高的一篇文章接口
export const getVotedOneArticleAPI = ()=>{
    return service({
        url: '/forum/top/',
        params:{
            single: 2
        }
    })
}

// 获取最新更新的文章
export const getLatestArticlesAPI = (limit)=>{
    return service({
        url: '/forum/latest/',
        params:{
            limit
        }
    })
}


// 获取文章详情
export const getArticleDetailAPI = (id)=>{
    return service({
        url: `/forum/article/${id}/`,
    })
}

// 点赞文章接口
export const voteArticleAPI = (articleId)=>{
    return service({
        url: '/forum/article/voted/',
        method: 'PATCH',
        params:{
            articleId
        }
    })
}

// 收藏文章接口
export const likeArticleAPI = (articleId)=>{
    return service({
        url: '/forum/article/liked/',
        method: 'PATCH',
        params:{
            articleId
        }
    })
}


// 获取收藏文章接口
export const getLikedArticlesAPI = ()=>{
    return service({
        url: '/forum/article/likes/',
    })
}


// 提交文章接口
export const writeArticleAPI = (article) => {
    return service({
        url: '/forum/article/write/',
        method: 'POST',
        data: article
    })
}

// 获取文章的所有评论
export const getArticleCommentsAPI = (articleId, pageNum, pageSize)=>{
    return service({
        url: '/forum/article/comments/',
        params: {
            articleId,
            pageNum,
            pageSize
        }
    })
}

// 删除文章接口
export const deleteArticleAPI = (id) => {
    return service({
        url: '/forum/article/delete/',
        method: 'DELETE',
        params:{
            id
        }
    })
}

// 添加评论API
export const postArticleCommentAPI = (data)=>{
    return service({
        url: '/forum/article/add/comment/',
        method: 'POST',
        data: data
    })
}

// 删除评论API
export const deleteCommentAPI = (id)=>{
    return service({
        url: '/forum/article/delete/comment/',
        method: 'DELETE',
        params:{
            id
        }
    })
}