<template>
  <div class="top-header d-flex align-items-center">
    <!-- <v-app-bar> -->
      <div class="d-flex">
        <v-icon color="blue lighten-1">mdi-baseball</v-icon>
        <router-link :to="{name: 'top'}">
          <v-toolbar-title class="text-h4 font-weight-bold logo">甲子園.com</v-toolbar-title>
        </router-link>
      </div>
      <router-link :to="{name: 'notification'}" v-if="signedIn">
        <v-icon color="blue lighten-1">mdi-bell</v-icon>
        通知
        <span class="fa fa-circle fa-xs" style="color: gold;" v-if="notifications.length>0 && signedIn">
          新着あり
        </span>
      </router-link>
      <router-link :to="{name: 'user-show',params: {id: current_user}}" v-if="signedIn">
        <v-icon color="blue lighten-1">mdi-account</v-icon>
        マイページ
      </router-link>
      <!-- <router-link to="/signup" v-if="!signedIn">
        <v-icon color="blue lighten-1">mdi-account-plus</v-icon>
        新規登録
      </router-link>
      <router-link to="/signin" v-if="!signedIn">
        <v-icon color="blue lighten-1">mdi-login</v-icon>
        ログイン
      </router-link> -->
      <a href="/" v-if="signedIn" @click="signOut">
        <v-icon color="blue lighten-1">mdi-logout</v-icon>
        ログアウト
      </a>
      <v-btn color="primary" @click="childEvent" v-if="!signedIn && this.$route.path=='/'">
        <v-icon color="white">mdi-account-plus</v-icon>
        新規登録
      </v-btn>
      <v-btn color="primary" @click="childEvent2" v-if="!signedIn && this.$route.path=='/'">
        <v-icon color="white">mdi-login</v-icon>
        ログイン
      </v-btn>
      <div v-if="!signedIn">
        <Gest></Gest>
      </div>
      <router-link :to="{name: 'contact'}">
        <v-icon color="blue lighten-1">mdi-email</v-icon>
        お問い合わせ
      </router-link>
    <!-- </v-app-bar> -->
  </div>
</template>
<script>
import axios from 'axios'
import { mapState } from 'vuex'
import Gest from './Gest.vue'

export default {
  components: {
    Gest
  },
  data() {
    return {
      current_user: '',
      notifications: []
    }
  },
  mounted() {
    this.fetchUser()
    this.fetchNotification()
    this.$store.dispatch('doFetchSignedIn')
  },
  computed: mapState([
    'signedIn'
  ]),
  methods: {
    fetchUser() {
      axios
        .get('/api/v1/users.json')
        .then(response =>{
          this.current_user = response.data.current_user
        })
    },
    fetchNotification() {
      axios
        .get('/api/v1/tops')
        .then(response =>{
          this.notifications = response.data.unchecked
        })
    },
    setError(error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },
    signOut() {
      this.$http.secured.delete('/api/v1/signin')
        .then(response => {
          delete localStorage.csrf
          delete localStorage.signedIn
        })
        .catch(error => this.setError(error, 'Cannot sign out'))
    },
    childEvent() {
      this.$emit('parent-event','parent-event2')
    },
    childEvent2() {
      this.$emit('parent-event2')
    }
  }
}
</script>
