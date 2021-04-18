<template>
  <div id="app">
    <router-view></router-view>
  </div>
</template>

<script>
import Vue from 'vue'
import VueRouter from 'vue-router'
import TopIndexPage from './TopIndexPage.vue'
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
import ChampionNewPage from './ChampionNewPage'
import TweetNewPage from './TweetNewPage'
import AnalysisNewPage from './AnalysisNewPage'
import ForecastNewPage from './ForecastNewPage'
import TweetEditPage from './TweetEditPage'
import AnalysisEdit from './AnalysisEdit'
import ForecastEditPage from './ForecastEditPage'
import UserShowPage from './UserShowPage'
import UserEditPage from './UserEditPage'
import FollowingPage from './FollowingPage'
import FollowerPage from './FollowerPage'
import VueStar from 'vue-star'
// import { component } from 'vue/types/umd'

Vue.component('VueStar', VueStar);
Vue.use(VueRouter)

const router = new VueRouter({
  mode: 'history',
  routes: [
    {
      path: '/',
      component: TopIndexPage,
      name: 'top'
    },
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
      path: '/tweets/new',
      component: TweetNewPage,
      name: 'tweet-new'
    },
    {
      path: '/tweets/:id/edit',
      component: TweetEditPage,
      name: 'tweet-edit'
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
      path: '/analyses/new',
      component: AnalysisNewPage,
      name: 'analysis-new'
    },
    {
      path: '/analyses/:id/edit',
      component: AnalysisEdit,
      name: 'analysis-edit'
    },
    {
      path: '/analyses/:id(\\d+)',
      component: AnalysisShowPage,
      name: 'analysis-show'
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
      name: 'forecast-show'
    },
    {
      path: '/forecasts/:id/edit',
      component: ForecastEditPage,
      name: 'forecast-edit'
    },
    {
      path: '/forecasts/new',
      component: ForecastNewPage,
      name: 'forecast-new'
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
      path: '/users/:id',
      component: UserShowPage,
      name: 'user-show'
    },
    {
      path: '/users/:id/edit',
      component: UserEditPage,
      name: 'user-edit'
    },
    {
      path: '/users/:id/following',
      component: FollowingPage,
      name: 'following'
    },
    {
      path: '/users/:id/followers',
      component: FollowerPage,
      name: 'follower'
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
      path: '/champions/:id(\\d+)',
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
      name: 'room-show'
    },
    {
      path: '/tournaments/:id/watch_avg',
      component: Average,
      name: 'average'
    },
    {
      path: '/champions/new',
      component: ChampionNewPage,
      name: 'champion-new'
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
