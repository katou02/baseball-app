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
import AnalysisShowPage from './AnalysisShowPage.vue'
import WatchaysPage from './WatchaysPage.vue'
import ForecastPage from './ForecastPage.vue'
import ForecastShowPage from './ForecastShowPage.vue'
import WatchfcsPage from './WatchfcsPage.vue'
import UserPage from './UserPage.vue'
import MapPage from './MapPage.vue'
import MapShowPage from './MapShowPage'
import ChampionPage from './ChampionPage'
import RoomPage from './RoomPage'
import RoomShowPage from './RoomShowPage'
import Average from './Average'

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
       name: 'analysis'
     },
    {
      path: '/analyses/:id(\\d+)',
      component: AnalysisShowPage,
      name: 'analysisshow'
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
      path: '/forecasts/:id(\\d+)',
      component: ForecastShowPage,
      name: 'forecastshow'
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
     },
     {
       path: '/maps/:id',
       component: MapShowPage,
       name: 'mapshow'
     },
     {
       path: '/champions/:id',
       component: ChampionPage,
       name: 'champion'
     },
     {
       path: '/rooms',
       component: RoomPage,
       name: 'room'
     },
     {
       path: '/rooms/:id',
       component: RoomShowPage,
       name: 'roomshow'
     },
     {
       path: '/tournaments/:id/watch_avg',
       component: Average,
       name: 'average'
     }
  ],
  scrollBehavior(to, from, savedPosition) {
    if (savedPosition) {
      sessionStorage.setItem('positionY', savedPosition.y);
        return savedPosition
    } else {
      sessionStorage.setItem('positionY', 0);
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
