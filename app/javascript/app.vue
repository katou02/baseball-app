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
     component: TweetIndexPage,
     name: 'Hoge'}
  ],
  scrollBehavior (to, from, savedPosition) {
  if (savedPosition) {
     return savedPosition
  } else {
     return { x: 0, y: 0 }
  }
}
})

Vue.use(VueRouter)

export default {
  router
}
</script>

<style scoped>

</style>
