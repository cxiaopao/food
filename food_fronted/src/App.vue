<template>
  <div class="bg-red-50">
    <Header></Header>
    <Banner></Banner>
    <router-view></router-view>
    <Footer></Footer>
  </div>
</template>

<script setup lang="ts">
import Header from './views/Header.vue';
import Banner from './views/Banner.vue';
import Footer from './views/Footer.vue';
</script>

<style>

</style>

