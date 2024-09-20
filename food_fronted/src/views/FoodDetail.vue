<template>
    <div class="my-6  container mx-auto">
        <!-- 食品详情 -->
        <div class=" mt-10 p-6 border border-dark">
            <h1 class="text-2xl font-bold mb-4">
                {{ food.name }}的详情信息
            </h1>
            <div class="flex mb-6">
                <img alt="食品图片" class="w-24 h-28 mr-4 object-contain" :src="food.img" />
                <div class="">
                    <h2 class="text-xl text-primary">
                        <span v-if="food.rating === null">暂无评分</span>
                        <el-rate v-else disabled size="large" show-score v-model="food.rating"
                            disabled-void-color="#666" text-color="#FC6736" />
                    </h2>
                    <p class="text-sm mt-2">
                        <span>简介：</span>
                        <span class=" text-dark">
                            {{ food.desc }}
                        </span>
                    </p>
                    <p class="text-sm mt-2">
                        <span>热量：</span>
                        <span class=" text-dark">
                            {{ nutrition.calories }}
                        </span>
                    </p>
                    <p class="text-sm mt-2">
                        <span>分类：</span>
                        <span class=" text-dark">
                            {{ category.name }}
                        </span>
                    </p>
                </div>
            </div>
            <!-- 食品营养信息 -->
            <div class="border-t border-b border-gray-300 py-4">
                <h3 class="text-lg font-bold mb-2">
                    营养信息
                </h3>
                <div class="grid grid-cols-4 gap-4">
                    <div class="font-medium">
                        <p>
                            营养素
                        </p>
                        <p class="mt-2">
                            热量(大卡)
                        </p>
                        <p class="mt-2">
                            脂肪(克)
                        </p>
                        <p class="mt-2">
                            蛋白质(克)
                        </p>
                    </div>
                    <div class="font-medium text-dark">
                        <p>
                            含量(每100克)
                        </p>
                        <p class="mt-2">
                            {{ nutrition.calories }}
                        </p>
                        <p class="mt-2">
                            {{ nutrition.fat }}
                        </p>
                        <p class="mt-2">
                            {{ nutrition.protein }}
                        </p>
                    </div>
                    <div class="font-medium">
                        <p>
                            营养素
                        </p>
                        <p class="mt-2">
                            碳水化合物(克)
                        </p>
                        <p class="mt-2">
                            膳食纤维(克)
                        </p>
                    </div>
                    <div class="font-medium text-dark">
                        <p>
                            含量(每100克)
                        </p>
                        <p class="mt-2">
                            {{ nutrition.carbohydrates }}
                        </p>
                        <p class="mt-2">
                            {{ nutrition.fiber }}
                        </p>
                    </div>
                </div>
            </div>
            <!-- 食品生产商信息 -->
            <div class="border-t border-gray-300 py-4">
                <h3 class="text-lg font-bold">
                    生产商信息
                </h3>
                <div class="flex flex-col ">
                    <div class="grid grid-cols-2 gap-4 space-x-6 justify-between mt-4 font-medium text-dark">
                        <p>厂商名称</p>
                        <p>厂商地址</p>
                    </div>
                    <div class="grid grid-cols-2 gap-4 space-x-6 justify-between mt-4 font-light">
                        <p>{{ manufacturer.name }}</p>
                        <p>{{ manufacturer.address }}</p>
                    </div>
                </div>
                <div class="flex flex-col ">
                    <div class="grid grid-cols-2 gap-4 space-x-6 justify-between mt-4 font-medium text-dark">
                        <p>联系电话</p>
                        <p>电子邮箱</p>
                    </div>
                    <div class="grid grid-cols-2 gap-4 space-x-6 justify-between mt-4 font-light">
                        <p>{{ manufacturer.phone }}</p>
                        <p>{{ manufacturer.email }}</p>
                    </div>
                </div>
                <div class="flex flex-col ">
                    <div class="grid grid-cols-2 gap-4 space-x-6 justify-between mt-4 font-medium text-dark">
                        <p>官方网站</p>
                        <p>厂商描述</p>
                    </div>
                    <div class="grid grid-cols-2 gap-4 space-x-6 justify-between mt-4 font-light">
                        <p>{{ manufacturer.website }}</p>
                        <p>{{ manufacturer.desc }}</p>
                    </div>
                </div>
            </div>
        </div>
        <!-- 食品历史价格 -->
        <div class=" mt-10 p-6 border border-primary">
            <h1 class="text-2xl font-bold mb-4">
                {{ food.name }}的历史价格
            </h1>
            <div class="mb-6" id="historyPriceChart" style="width: 100%;height:400px;"></div>
        </div>
        <!-- 互动 -->
        <div class="flex my-4 items-center justify-between mb-10">
            <div class="flex items-center text-primary text-xl">
                <span v-if="food.rating === null">
                    暂无评分
                </span>
                <span v-else>
                    综合评分：{{ food.rating }}
                </span>
                <span class="text-dark text-lg ml-4">
                    {{ food.commentCount }} 人做过评价
                </span>
                <span @click="exportFoodData" class="ml-2 hover:cursor-pointer text-dark  rounded-full active:text-primary">导出食品评价</span>
            </div>
            <button @click="addOrRemoveLiked"
                class="bg-primary text-white py-2 px-4 rounded hover:bg-primary hover:opacity-50">
                <i v-if="food.isLiked" class="fa fa-heart"> 取消喜爱</i>
                <i v-else class="fa fa-heart-o"> 喜爱</i>
            </button>
        </div>
        <!-- 评分评论 -->
        <div v-if="food.isCommented" class="bg-white py-6 px-4 flex justify-center">
            您已经为这个食品提交过评分评价，
            <span @click="deleteReview"
                class="text-primary hover:text-opacity-50 hover:cursor-pointer">点击可删除原来的评分评价</span> 。
        </div>
        <!-- 发布评价 -->
        <div v-else>
            <div class="bg-white py-6 container mx-auto px-4">
                <div class="flex flex-col">
                    <h1 class="text-2xl font-bold text-center mb-6">输入您的评分</h1>
                    <div class="flex justify-center space-x-1 text-primary  hover:cursor-pointer">
                        <el-rate v-model="form.rating" :colors="['#99A9BF', '#F7BA2A', '#FC6736']" size="large" />
                    </div>
                    <h1 class="text-2xl font-bold text-center mt-6 mb-4">输入您的评价</h1>
                    <div class="relative">
                        <label for="body" class="block relative mb-12">
                            <textarea v-model="form.body" id="body"
                                class="w-full p-2 border border-dark rounded focus:outline-none focus:border-primary"
                                rows="4"></textarea>
                        </label>
                        <button @click="submitReview"
                            class="absolute right-0 bottom-0 flex px-4 py-2 bg-primary text-white rounded focus:outline-none hover:opacity-50">
                            提交评论
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <!-- 显示评价 -->
        <div class="mt-6 bg-white rounded-lg shadow-lg p-6" v-for="review in reviews" :key="review.id">
            <div class="flex items-center">
                <router-link :to="`/article/view/${review.user.id}`" class="hover:cursor-pointer">
                    <img alt="用户头像" class="w-12 h-12 rounded-full mr-4" :src="review.user.avatar" />
                </router-link>
                <div class="flex-grow">
                    <div class="text-sm font-bold text-gray-800">
                        <span class="">{{ review.user.username }}</span>
                        <span class="mx-2 ">{{ review.createTime }}</span>
                    </div>
                    <div class="text-sm text-gray-600 flex-col items-center">
                        <div><el-rate disabled size="large" show-score v-model="review.rating"
                                disabled-void-color="#666" text-color="#FC6736" /></div>
                        <span> {{ review.body }}</span>
                    </div>
                </div>
            </div>
        </div>
        <!-- 分页 -->
        <div class="flex justify-center items-center space-x-2 mt-10">
            <el-pagination background layout="prev, pager, next" :total="total" :page-size="pageSize"
                :current-page="currentPage" @current-change="handlePageChange" :hide-on-single-page="true" />
        </div>
    </div>
</template>

<script setup lang="ts">
import { useRoute } from 'vue-router';
import {
    getFoodDetailAPI, getFoodPricesAPI, addOrRemoveFoodLikedAPI,
    getFoodReviewsAPI, postFoodReviewAPI, deleteFoodReviewAPI, exportFoodDataAPI
} from '../api/food';
import { computed, onBeforeUpdate, onUpdated, ref } from 'vue';
import * as echarts from "echarts";

const food = ref({})
const route = useRoute();
let prices = ref([])
let prices_create_time = ref([])
const reviews = ref([])
const currentPage = ref(1)
const pageSize = ref(2)
const total = ref(0)

const nutrition = computed(() => {
    return food.value.nutrition || ''
})

const manufacturer = computed(() => {
    return food.value.manufacturer || ''
})

const category = computed(() => {
    return food.value.category || ''
})


// 获取食品详情信息
const getFoodDetail = async () => {
    const id = route.params.id;
    const res = await getFoodDetailAPI(id)
    food.value = res.data.data
    reviews.value = res.data.data.reviews || []
}

// 获取食品价格信息
const getFoodPrices = async () => {
    const res = await getFoodPricesAPI(food.value.id)
    let data = res.data.data
    prices.value = data.map(item => item.price)
    prices_create_time.value = data.map(item => item.create_time)
}

// 食品历史价格图
const historyPrice = () => {
    let myChart = echarts.init(document.getElementById('historyPriceChart'));
    const colorList = ["#9E87FF", '#73DDFF', '#fe9a8b', '#F56948', '#9E87FF']
    let option = {
        backgroundColor: '#EEECEC',
        title: {
            text: food.value.name + '的历史价格',
            textStyle: {
                fontSize: 24,
                fontWeight: 400
            },
            left: 'center',
            top: '5%'
        },

        tooltip: {
            trigger: 'axis',
            axisPointer: {
                label: {
                    show: true,
                    backgroundColor: '#fff',
                    color: '#556677',
                    borderColor: 'rgba(0,0,0,0)',
                    shadowColor: 'rgba(0,0,0,0)',
                    shadowOffsetY: 0
                },
                lineStyle: {
                    width: 0
                }
            },
            backgroundColor: '#fff',
            textStyle: {
                color: '#5c6c7c'
            },
            padding: [10, 10],
            extraCssText: 'box-shadow: 1px 0 2px 0 rgba(163,163,163,0.5)'
        },
        grid: {
            top: '25%'
        },
        xAxis: [{
            type: 'category',
            data: prices_create_time.value,
            axisLine: {
                lineStyle: {
                    color: '#DCE2E8'
                }
            },
            axisTick: {
                show: false
            },
            axisLabel: {
                interval: 0,
                textStyle: {
                    color: '#556677'
                },
                fontSize: 12,
                margin: 15
            },
            axisPointer: {
                label: {
                    padding: [0, 0, 10, 0],
                    margin: 15,
                    fontSize: 12,
                    backgroundColor: {
                        type: 'linear',
                        x: 0,
                        y: 0,
                        x2: 0,
                        y2: 1,
                        colorStops: [{
                            offset: 0,
                            color: '#EEECEC' // 0% 处的颜色
                        }, {
                            offset: 0.86,
                            color: '#EEECEC' // 0% 处的颜色
                        }, {
                            offset: 0.86,
                            color: '#33c0cd' // 0% 处的颜色
                        }, {
                            offset: 1,
                            color: '#33c0cd' // 100% 处的颜色
                        }],
                        global: false
                    }
                }
            },
            boundaryGap: false
        }],
        yAxis: [{
            type: 'value',
            axisTick: {
                show: false
            },
            axisLine: {
                show: true,
                lineStyle: {
                    color: '#DCE2E8'
                }
            },
            axisLabel: {
                textStyle: {
                    color: '#556677'
                }
            },
            splitLine: {
                show: false
            }
        }, {
            type: 'value',
            position: 'right',
            axisTick: {
                show: false
            },
            axisLabel: {
                textStyle: {
                    color: '#556677'
                },
                formatter: '{value}元'
            },
            axisLine: {
                show: true,
                lineStyle: {
                    color: '#DCE2E8'
                }
            },
            splitLine: {
                show: false
            }
        }],
        series: [{
            name: food.value.name + '的价格',
            type: 'line',
            data: prices.value,
            symbolSize: 1,
            yAxisIndex: 1,
            symbol: 'circle',
            smooth: true,
            showSymbol: false,
            lineStyle: {
                width: 5,
                color: new echarts.graphic.LinearGradient(0, 0, 1, 0, [{
                    offset: 0,
                    color: '#fe9a'
                },
                {
                    offset: 1,
                    color: '#fe9a8b'
                }
                ]),
                shadowColor: 'rgba(254,154,139, 0.3)',
                shadowBlur: 10,
                shadowOffsetY: 20
            },
            itemStyle: {
                normal: {
                    color: colorList[2],
                    borderColor: colorList[2]
                }
            }
        }
        ]
    };
    myChart.setOption(option);
}


// 添加或者取消喜爱
const addOrRemoveLiked = async () => {
    const res = await addOrRemoveFoodLikedAPI(food.value.id)
    food.value.isLiked = !food.value.isLiked;
    ElMessage({
        type: 'success',
        message: res.data.msg,
        duration: 1000
    });
}

// 获取该食品下的评论
const getFoodReviews = async () => {
    const res = await getFoodReviewsAPI(food.value.id, currentPage.value, pageSize.value)
    reviews.value = res.data.data
    total.value = res.data.total
}

// 处理分页
const handlePageChange = (page) => {
    currentPage.value = page
    getFoodReviews()
};


// 评价表单
const form = ref({
    foodId: null,
    rating: 5,
    body: ''
})

// 提交评价
const submitReview = async () => {
    form.value.foodId = food.value.id
    await postFoodReviewAPI(form.value)
    await getFoodDetail()
    await getFoodPrices()
    await getFoodReviews()

    ElMessage({
        type: 'success',
        message: '评价成功',
        duration: 1000
    });

    // 重置表单
    form.value.rating = 5
    form.value.body = ''
}


// 删除评价
const deleteReview = () => {
    ElMessageBox.confirm(
        '确定删除信息吗?',
        '警告',
        {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning',
        }
    ).then(async () => {
        await deleteFoodReviewAPI(food.value.user.id)
        await getFoodDetail()
        await getFoodPrices()
        await getFoodReviews()
        ElMessage({
            type: 'success',
            message: '删除评价成功',
            duration: 1000
        });
    })
}


const exportFoodData = async() => {
    const response = await exportFoodDataAPI(food.value.name.trim());
    const blob = new Blob([response.data], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' });
    const link = document.createElement('a');
    link.href = URL.createObjectURL(blob);
    link.download = `${food.value.name}_data.xlsx`;
    link.click();
    URL.revokeObjectURL(link.href);
}

onMounted(async () => {
    await getFoodDetail()
    await getFoodPrices()
    await getFoodReviews()
    nextTick(() => {
        historyPrice()
    });
});



</script>

<style scoped></style>
