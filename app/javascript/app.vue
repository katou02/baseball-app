<template>
  <div id="app">
    <router-view></router-view>
  </div>
</template>

<script>
import Vue from 'vue'
import VueRouter from 'vue-router'
import TweetIndexPage from './TweetIndexPage.vue'
import TournamentPage from './TournamentPage.vue'
import AnalysisPage from './AnalysisPage.vue'
import WatchaysPage from './WatchaysPage.vue'
import ForecastPage from './ForecastPage.vue'

Vue.use(VueRouter)

const router = new VueRouter({
  mode: 'history',
  routes: [
     {
      path: '/tweets',
      component: TweetIndexPage,
      name: 'tweet'
     },
     {
       path: '/tournaments/:id',
       component: TournamentPage,
       name: 'tournament'
     },
     {
       path: '/analyses',
       component: AnalysisPage,
       name: 'anaysis'
     },
     {
       path: '/tournaments/:id/watch_ays',
       component: WatchaysPage,
       name: 'watch_ays'
     },
     {
       path: '/forecasts',
       component: ForecastPage,
       name: 'forecast'
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
