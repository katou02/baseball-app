<template>
  <div class="top">
    <Menu></Menu>
    <div class="top-title">
      タイトルが入る
    </div>
    <div class="top-menu-list">
      <router-link :to="{name: 'tweet'}" class="text-white">
        <div class="top-menu">
          <v-icon large color="white">mdi-pencil</v-icon><br>
          試合記事
        </div>
      </router-link>
      <router-link :to="{name: 'analysis'}" class="text-white">
        <div class="top-menu">
          <v-icon large color="white">mdi-magnify</v-icon><br>
          戦力分析
        </div>
      </router-link>
      <router-link :to="{name: 'forecast'}" class="text-white">
        <div class="top-menu">
          <v-icon large color="white">mdi-scale-balance</v-icon><br>
          試合予想
        </div>
      </router-link>
      <router-link :to="{name: 'champion',params: {id: 1}}" class="text-white">
        <div class="top-menu">
          <v-icon large color="white">mdi-crown</v-icon><br>
          優勝予想
        </div>
      </router-link>
      <router-link :to="{name: 'map',query: {tournament_id: 1}}" class="text-white">
        <div class="top-menu">
          <v-icon large color="white">mdi-city</v-icon><br>
          ふるさと
        </div>
      </router-link>
    </div>
           <!-- <li><router-link to="/signup" v-if="!signedIn">Sign up</router-link></li>
           <li><router-link to="/signin" v-if="!signedIn">Sign in</router-link></li>
           <li><a href="/" v-if="signedIn" @click="signOut">Sign out</a></li> -->
  </div>
</template>
<script>
// import { mapState } from 'vuex'
import Menu from './components/Menu.vue'

export default {
  name: 'Header',
  components: {
    Menu
  }
  // computed: mapState([
  //   'signedIn'
  // ]),
  // mounted: function() {
  //   this.$store.dispatch('doFetchSignedIn')
  // },
  // methods: {
  //   setError(error, text) {
  //     this.error = (error.response && error.response.data && error.response.data.error) || text
  //   },
  //   signOut() {
  //     this.$http.secured.delete(`/api/v1/signin`)
  //       .then(response => {
  //         delete localStorage.csrf
  //         delete localStorage.signedIn
  //       })
  //       .catch(error => this.setError(error, 'Cannot sign out'))
  //   }
  // }
}
</script>