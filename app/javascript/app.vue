<template>
  <div>
    <router-view></router-view>
  </div>
</template>

<script>
import Vue from 'vue'
import VueRouter from 'vue-router'

import TweetIndexPage from 'TweetIndexPage.vue'

const router = new VueRouter({
  mode: 'history',
  routes: [
    {path: '/tweets',
     component: TweetIndexPage}
  ]
})

Vue.use(VueRouter)

export default {
  router
}
</script>

<style scoped>

</style>
