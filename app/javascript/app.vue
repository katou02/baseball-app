<template>
  <div id="app">
    <router-view></router-view>
  </div>
</template>

<script>
import Vue from 'vue'
import VueRouter from 'vue-router'
import TweetIndexPage from './TweetIndexPage.vue'
import TweetShowPage from './TweetShowPage.vue'
import TournamentPage from './TournamentPage.vue'
import AnalysisPage from './AnalysisPage.vue'
import WatchaysPage from './WatchaysPage.vue'
import ForecastPage from './ForecastPage.vue'
import WatchfcsPage from './WatchfcsPage.vue'
import UserPage from './UserPage.vue'
import MapPage from './MapPage.vue'

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
       path: '/tweets/:id(\\d+)',
       component: TweetShowPage,
       name: 'tweetshow'
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
     },
     {
       path: '/tournaments/:id/watch_fcs',
       component: WatchfcsPage,
       name: 'watch_fcs'
     },
     {
       path: '/users',
       component: UserPage,
       name: 'user'
     },
     {
       path: '/maps',
       component: MapPage,
       name: 'map'
     }
  ]
    // scrollBehavior(to, from, savedPosition) {
    //   // console.log(savedPosition)
    //     if (savedPosition) {
    //       sessionStorage.setItem('positionY', savedPosition.y);
    //         return savedPosition
    //     } else {
    //       sessionStorage.setItem('positionY', 0);
    //         return { x: 0, y: 0 }
    //     }
    // }
})

export default {
  router
}
</script>

<style scoped>

</style>
