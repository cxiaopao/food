import { createWebHistory, createRouter } from 'vue-router'
import {useUserStore} from '@/stores/userStore'
import Index from "../views/Index.vue"
import Food from "../views/Food.vue"
import Login from '../views/Login.vue'
import FoodDetail from '../views/FoodDetail.vue'
import Forum from '../views/Forum.vue'
import Write from '../views/Write.vue'
import Register from '../views/Register.vue'
import Profile from '../views/Profile.vue'
import ProfileInfo from '../views/ProfileInfo.vue'
import ProfilePassword from '../views/ProfilePassword.vue'
import ProfileArticle from '../views/ProfileArticle.vue'
import ProfileFood from '../views/ProfileFood.vue'
import ArticleDetail from '../views/ArticleDetail.vue'
import ArticleView from '@/views/ArticleView.vue'
import ResumeWrite from '@/views/ResumeWrite.vue'
import NotFound from '@/views/404.vue'


const routes = [
  { 
    path: '', 
    name: 'index',
    component:  Index,
  },
  { 
    path: '/food', 
    name: 'food',
    component: Food,
   
  },
  {
    path: '/food/:id', 
    name: 'foodDetail',
    component:  FoodDetail,
  },
  { 
    path: '/forum', 
    name: 'forum',
    component:  Forum,
    
  },
  { 
    path: '/write', 
    name: 'write',
    component:  Write,
    
  },
  { 
    path: '/resume/write/:id', 
    name: 'resumWrite',
    component:  ResumeWrite,
  },
  { 
    path: '/login', 
    name: 'login',
    component:  Login
  },
  { 
    path: '/register', 
    name: 'register',
    component:  Register
  },
  { 
    path: '/profile', 
    name: 'profile',
    component:  Profile,
    children:[
      {
        path: 'info/',
        name: 'profileInfo',
        component:  ProfileInfo
      },
      {
        path: 'password/',
        name: 'profilePassword',
        component:  ProfilePassword
      },
      {
        path: 'article/',
        name: 'ProfileArticle',
        component:  ProfileArticle
      },
      {
        path: 'food/',
        name: 'ProfileFood',
        component:  ProfileFood
      },
    ]
  },
  { 
    path: '/article/:id', 
    name: 'ArticleDetail',
    component:  ArticleDetail
  },
  { 
    path: '/article/view/:id', 
    name: 'ArticleView',
    component:  ArticleView
  },
  {
    path: '/404', 
    name: 'NotFound',
    component: NotFound
  },
  {
    path: '/:pathMatch(.*)',
    redirect: '/404'
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes,
})

// 添加全局前置守卫
router.beforeEach((to, from, next) => {
  const userStore = useUserStore();

  if (!userStore.isLoggedIn && to.name !== 'login' && to.name !== 'index' && to.name !== 'register') {
    // 如果用户未登录且试图访问受保护的页面，则重定向到登录页面
    next({ name: 'login', query: { redirect: to.fullPath } });
  } else if (userStore.isLoggedIn && to.name === 'login') {
    // 如果用户已登录且试图访问登录页面，则重定向到首页或其他页面
    next({ name: 'index' });
  } else {
    next();
  }
});

export default router