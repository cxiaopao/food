<template>
    <div class="bg-white rounded-lg shadow-lg p-6 mt-6">
      <div class="flex items-center">
        <router-link :to="`/article/view/${comment.author.id}`" class="hover:cursor-pointer">
          <img alt="用户头像" class="w-12 h-12 rounded-full mr-4" :src="comment.author.avatar" />
        </router-link>
        <div class="flex-grow">
          <div class="text-sm font-bold text-gray-800">
            <span>{{ comment.author.username }}</span>
            <span class="mx-2 text-gray-500">{{ comment.ip }}</span>
            <span class="text-gray-500">{{ comment.createTime }}</span>
          </div>
          <div class="text-sm text-gray-600">{{ comment.body }}</div>
        </div>
        <button v-if="comment.author.id === userStore.userInfo.id" @click="deleteComment(comment.id)" class="delete-comment-btn ml-auto text-gray-600 hover:text-gray-800 mr-8">
          <i class="fa fa-trash"></i>
        </button>
        <button @click="toggleReplyForm(comment.id)" class="reply-btn ml-auto text-gray-600 hover:text-gray-800">
          <i class="fa fa-reply"></i>
        </button>
      </div>
      <!-- 回复表单 -->
      <div class="mt-4" v-if="replyForms[comment.id] && replyForms[comment.id].visible">
        <textarea rows="3" class="bg-gray-50 rounded-lg text-sm text-gray-600 w-full p-4 focus:outline-none" v-model="replyForms[comment.id].body" :placeholder="'回复：' + comment.author.username"></textarea>
        <div class="flex items-center justify-end mt-4">
          <button @click="submitReply(comment.id)" class="reply-summit bg-primary hover:opacity-50 text-white px-4 py-2 rounded-lg">评论</button>
        </div>
      </div>
      <!-- 子评论 -->
      <div v-for="reply in comment.replies" :key="reply.id">
        <CommentItem :comment="reply" :replyForms="replyForms" :userStore="userStore" :deleteComment="deleteComment" :toggleReplyForm="toggleReplyForm" :submitReply="submitReply" />
      </div>
    </div>
  </template>
  
  <script setup>
  
  const props = defineProps({
    comment: Object,
    replyForms: Object,
    userStore: Object,
    deleteComment: Function,
    toggleReplyForm: Function,
    submitReply: Function,
  });
  </script>
  
  <style scoped></style>
  