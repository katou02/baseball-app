<template>
  <div id="app">
    <v-btn>Vuetifyのボタン</v-btn>
    <router-view></router-view>
  </div>
</template>

<script>
import Vue from 'vue'
import VueRouter from 'vue-router'
import TweetIndexPage from './TweetIndexPage.vue'

Vue.use(VueRouter)

const router = new VueRouter({
  mode: 'history',
  routes: [
    {
      path: '/tweets',
      component: TweetIndexPage,
      name: 'tweet'
     }
  ],
  scrollBehavior (to, from, savedPosition) {
    if (savedPosition) {
      return savedPosition
  } else {
    return { x: 0, y: 0 }
  }
}
})

export default {
  router
}
</script>

<style scoped>

</style>
