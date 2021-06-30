<template>
  <div class="top">
    <Menu></Menu>
    <div class="top-title">
      甲子園.com
    </div>
    <div class="top-menu-list">
      <router-link :to="{name: 'tweet'}" class="text-white">
        <div class="top-menu">
          <v-icon large color="blue">mdi-pencil</v-icon><br>
          試合記事
        </div>
      </router-link>
      <router-link :to="{name: 'analysis'}" class="text-white">
        <div class="top-menu">
          <v-icon large color="blue">mdi-magnify</v-icon><br>
          戦力分析
        </div>
      </router-link>
      <router-link :to="{name: 'forecast'}" class="text-white">
        <div class="top-menu">
          <v-icon large color="blue">mdi-scale-balance</v-icon><br>
          試合予想
        </div>
      </router-link>
      <router-link :to="{name: 'champion',params: {id: 1}}" class="text-white">
        <div class="top-menu">
          <v-icon large color="orange">mdi-crown</v-icon><br>
          優勝予想
        </div>
      </router-link>
      <router-link :to="{name: 'map',query: {tournament_id: 1}}" class="text-white">
        <div class="top-menu">
          <v-icon large color="blue">mdi-city</v-icon><br>
          ふるさと
        </div>
      </router-link>
    </div>
    <modal name="select">
      <div id="modal">
        <Signup></Signup>
        <button @click="closeModal">閉じる</button>
      </div>
    </modal>
  </div>
</template>
<script>
import axios from 'axios';
import Menu from './components/Menu.vue'
import Signup from './components/Signup.vue'

export default {
  name: 'Header',
  components: {
    Menu,
    Signup
  },
  data() {
    return {
      current_user: ''
    }
  },
  mounted() {
    this.signin()
  },
  methods: {
    signin() {
      axios
      .get('/api/v1/tops')
      .then(response =>{
        this.current_user = response.data.current_user
        if(this.current_user === null && this.$store.state.signedIn == true) {
          delete localStorage.csrf
          delete localStorage.signedIn
          this.$router.go('/')
        }
      })
    },
    openModal(){
      this.$modal.show('select');
    },
    closeModal(){
      this.$modal.hide('select');
    },
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