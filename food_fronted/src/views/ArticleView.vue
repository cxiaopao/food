<template>
   <div class="container mx-auto mt-8 mb-6 p-4 bg-white shadow-lg">
      <!--基本信息-->
      <div class="flex items-center space-x-4 p-4 border-b">
         <img alt="Profile picture placeholder" class="rounded-full w-[100px] h-[100px]" :src="user.avatar" />
         <div>
            <h1 class="text-2xl font-bold mb-1">
               {{ user.username }}
            </h1>
            <p class="text-gray-600 mb-1">
               个人简介：{{ user.bio }}
            </p>
         </div>
      </div>
      <div class="flex p-4">
         <!--个人信息-->
         <div class="w-1/4 pr-4 border-r">
            <div class="mb-4">
               <h2 class="text-lg font-bold mb-2">
                  个人成就
               </h2>
               <div class="flex items-center mb-2">
                  <div class="w-10 h-10 flex items-center justify-center">
                     <el-icon :size="30">
                        <Pointer class="text-primary" />
                     </el-icon>
                  </div>
                  <div class="ml-2">
                     共获得 {{ user.totalVotes }} 次点赞
                  </div>
               </div>
               <div class="flex items-center mb-2">
                  <div class="w-10 h-10 flex items-center justify-center">
                     <el-icon :size="30">
                        <ChatLineRound class="text-blue-500" />
                     </el-icon>
                  </div>
                  <div class="ml-2">
                     共获得 {{ user.totalComments }} 次评论
                  </div>
               </div>
               <div class="flex items-center mb-2">
                  <div class="w-10 h-10 flex items-center justify-center">
                     <el-icon :size="30">
                        <StarFilled class="text-primary" />
                     </el-icon>
                  </div>
                  <div class="ml-2">
                     共获得 {{ user.totalLikes }} 次收藏
                  </div>
               </div>
            </div>
            <div class="mb-4">
               <h2 class="text-lg font-bold mb-2">
                  创作历程
               </h2>
               <div v-if="user.perYearCreated" class="grid grid-cols-4 gap-2 text-gray-600 mb-1 bg-gray-50 p-2">
                  <div class="text-center" v-for="item in user.perYearCreated" :key="item.year">
                     <span>{{ item.count }} 篇</span>
                     <span>{{ item.year }} 年</span>
                  </div>
               </div>
            </div>
         </div>
         <!--文章列表-->
         <div class="w-3/4 pl-4 relative h-[600px] overflow-auto" v-if="user.articles">
            <div class="flex justify-between items-center border-b-2 border-gray-200 pb-2">
               <div class="flex space-x-6 w-3/5">
                  <a href="#" class="text-red-600 font-semibold text-lg border-b-2 border-red-600 pb-1">文章</a>
               </div>
               <div class="flex items-center w-2/5">
                  <input v-model="searchQuery" type="text" placeholder="找我的文章" v-if="user.id === id"
                     class="w-full border focus:outline-none focus:border-primary rounded-full py-2 px-4 text-sm">
                  <input v-model="searchQuery" type="text" placeholder="找TA的文章" v-else
                     class="w-full border focus:outline-none focus:border-primary rounded-full py-2 px-4 text-sm">
               </div>
            </div>
            <div class="flex space-x-4 my-4">
               <span @click="sortArticles('all')" :class="{ 'text-primary': sortOrder === 'all' }"
                  class=" hover:text-primary hover:cursor-pointer">全部文章</span>
               <span @click="sortArticles('statusP')" :class="{ 'text-primary': sortOrder === 'statusP' }"
                  v-if="user.id === id" class="selectedCategory hover:text-primary hover:cursor-pointer">已发布的文章</span>
               <span @click="sortArticles('statusR')" :class="{ 'text-primary': sortOrder === 'statusR' }"
                  v-if="user.id === id" class="selectedCategory hover:text-primary hover:cursor-pointer">处于审核的文章</span>
               <span @click="sortArticles('statusD')" :class="{ 'text-primary': sortOrder === 'statusD' }"
                  v-if="user.id === id" class="selectedCategory hover:text-primary hover:cursor-pointer">存为草稿的文章</span>
               <span @click="sortArticles('views')" :class="{ 'text-primary': sortOrder === 'views' }"
                  class="selectedCategory hover:text-primary hover:cursor-pointer">按阅读量排序</span>
               <span @click="sortArticles('votes')" :class="{ 'text-primary': sortOrder === 'votes' }"
                  class="selectedCategory hover:text-primary hover:cursor-pointer">按点赞量排序</span>
               <span @click="sortArticles('likes')" :class="{ 'text-primary': sortOrder === 'likes' }"
                  class="selectedCategory hover:text-primary hover:cursor-pointer">按收藏量排序</span>
            </div>
            <div class="bg-gray-100 hover:bg-gray-200 transition duration-300 rounded-lg shadow overflow-hidden mb-4"
               v-if="pagedArticles" v-for="article in pagedArticles" :key="article.id">
               <div class="p-4 flex flex-col w-full">
                  <router-link :to="`/article/${article.id}`" class="text-gray-800 hover:text-primary text-lg mb-2">
                     {{ article.title }}
                  </router-link>
                  <div class="flex">
                     <p class="text-gray-600 text-sm mt-2">
                        发布于 {{ article.updateTime }}
                        · {{ article.views }} 阅读量
                        · {{ article.votedCount }} 点赞
                        · {{ article.likedCount }} 收藏
                        · {{ article.comments }} 评论
                     </p>
                     <button v-if="user.id === id" @click="deleteArticle(article.id)"
                        class="delete-article-btn ml-auto text-gray-600 hover:text-primary mr-2 text-lg">
                        <i class="fa fa-trash"></i>
                     </button>
                  </div>
               </div>
            </div>
            <!-- 分页 -->
            <el-pagination class="flex justify-center items-center absolute bottom-0 right-0 left-0"
               :current-page="currentPage" :page-size="pageSize" layout="prev, pager, next" :total="totalArticles"
               @current-change="handlePageChange" :hide-on-single-page="true" />
         </div>
      </div>
   </div>
</template>

<script setup>
import { getUserAPI } from '@/api/user'
import { deleteArticleAPI } from '@/api/article'
import { useRoute } from 'vue-router'
import { useUserStore } from '@/stores/userStore'
import { ref, watch, onMounted, computed } from 'vue'

const user = ref({})
const route = useRoute()
const userStore = useUserStore()
const id = userStore.userInfo.id
const sortOrder = ref('all')
const currentPage = ref(1)
const pageSize = ref(4)
const searchQuery = ref('')

// 获取该用户信息
const getUser = async () => {
   const res = await getUserAPI(route.params.id)
   user.value = res.data.data
}

// 监听路由参数的变化
watch(() => route.params.id, () => {
   getUser()
})

// 排序方法
const sortArticles = (order) => {
   sortOrder.value = order
   currentPage.value = 1 // 选择排序方式时重置为第一页
}

// 动态排序和搜索
const sortedArticles = computed(() => {
   let sorted = [...user.value.articles]

   // 按 updateTime 倒序排序
   sorted.sort((a, b) => new Date(b.updateTime) - new Date(a.updateTime))

   // 排序逻辑
   if (sortOrder.value === 'views') {
      sorted.sort((a, b) => b.views - a.views)
   } else if (sortOrder.value === 'votes') {
      sorted.sort((a, b) => b.votedCount - a.votedCount)
   } else if (sortOrder.value === 'likes') {
      sorted.sort((a, b) => b.likedCount - a.likedCount)
   } else if (sortOrder.value === 'statusP') {
      sorted = sorted.filter(article => article.status === 'p')
   } else if (sortOrder.value === 'statusD') {
      sorted = sorted.filter(article => article.status === 'd')
   } else if (sortOrder.value === 'statusR') {
      sorted = sorted.filter(article => article.status === 'r')
   } else {
      sorted = [...user.value.articles]  // 默认显示全部文章
   }

   // 搜索过滤
   if (searchQuery.value) {
      sorted = sorted.filter(article =>
         article.title?.includes(searchQuery.value) ||
         article.content?.includes(searchQuery.value)
      )
   }

   return sorted
})

// 处理分页
const pagedArticles = computed(() => {
   const start = (currentPage.value - 1) * pageSize.value
   const end = start + pageSize.value
   return sortedArticles.value.slice(start, end)
})
const totalArticles = computed(() => {
   return sortedArticles.value.length
})
const handlePageChange = (page) => {
   currentPage.value = page
}

// 删除文章
const deleteArticle =  (id) => {
   ElMessageBox.confirm(
      '确定删除信息吗?',
      '警告',
      {
         confirmButtonText: '确定',
         cancelButtonText: '取消',
         type: 'warning',
      }
   ).then(async () => {
      const res = await deleteArticleAPI(id)
      ElMessage({
         type: 'success',
         message: '删除成功',
         duration: 1000,
      })
      // 重新获取用户信息
      await getUser()
   })
}


onMounted(() => {
   getUser()
})
</script>

<style scoped></style>
