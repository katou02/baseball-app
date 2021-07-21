<template>
  <div id="app">
    <v-app>
      <Menu v-if="this.$route.path!='/' && this.$route.path!='/notifications'"></Menu>
      <router-view></router-view>
    </v-app>
  </div>
</template>
<script>
import Vue from 'vue'
import VueRouter from 'vue-router'
import TopPage from './TopPage.vue'
import TweetPage from './TweetPage.vue'
import TweetShowPage from './TweetShowPage.vue'
import WatchtwsPage from './WatchtwsPage.vue'
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
import UserShowPage from './UserShowPage'
import FollowingPage from './FollowingPage'
import FollowerPage from './FollowerPage'
import NotificationPage from './NotificationPage'
import ContactPage from './ContactPage'
import "vuetify/dist/vuetify.min.css"
import '@mdi/font/css/materialdesignicons.css'
import VuejsDialog from 'vuejs-dialog';
import Menu from './components/Menu'
import VModal from 'vue-js-modal'

Vue.use(VueRouter)
Vue.use(VuejsDialog);
Vue.use(VModal)

const router = new VueRouter({
  mode: 'history',
  routes: [
    {
      path: '/',
      component: TopPage,
      name: 'top'
    },
    {
      path: '/analyses',
      component: AnalysisPage,
      name: 'analysis'
    },
    {
      path: '/analyses/:id(\\d+)',
      component: AnalysisShowPage,
      name: 'analysis-show'
    },
    {
      path: '/champions/:id(\\d+)',
      component: ChampionPage,
      name: 'champion'
    },
    {
      path: '/contacts',
      component: ContactPage,
      name: 'contact',
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
      path: '/maps',
      component: MapPage,
      name: 'map'
    },
    {
      path: '/maps/:id(\\d+)',
      component: MapShowPage,
      name: 'map-show'
    },
    {
      path: '/notifications',
      component: NotificationPage,
      name: 'notification'
    },
    {
      path: '/rooms',
      component: RoomPage,
      name: 'room'
    },
    {
      path: '/rooms/:id(\\d+)',
      component: RoomShowPage,
      name: 'room-show'
    },
    {
      path: '/tweets',
      component: TweetPage,
      name: 'tweet'
    },
    {
      path: '/tweets/:id(\\d+)',
      component: TweetShowPage,
      name: 'tweet-show'
    },
    {
      path: '/tournaments/:id(\\d+)',
      component: WatchtwsPage,
      name: 'tournament'
    },
    {
      path: '/tournaments/:id(\\d+)/watch_ays',
      component: WatchaysPage,
      name: 'watch_ays'
    },
    {
      path: '/tournaments/:id(\\d+)/watch_fcs',
      component: WatchfcsPage,
      name: 'watch_fcs'
    },
    {
      path: '/tournaments/:id(\\d+)/watch_avg',
      component: Average,
      name: 'average'
    },
    {
      path: '/users',
      component: UserPage,
      name: 'user'
    },
    {
      path: '/users/:id(\\d+)',
      component: UserShowPage,
      name: 'user-show'
    },
    {
      path: '/users/:id(\\d+)/following',
      component: FollowingPage,
      name: 'following'
    },
    {
      path: '/users/:id(\\d+)/followers',
      component: FollowerPage,
      name: 'follower'
    },
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
  router,
  components: {
    Menu
  }
}
</script>

<style scoped>

</style>
