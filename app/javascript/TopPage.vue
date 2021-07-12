<template>
  <div class="top">
    <Menu @parent-event="openModal" @parent-event2="openModal2"></Menu>
    <div class="top-title">
      甲子園ドットコム
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
    <modal height="auto" name="select">
      <div id="modal">
        <Signup @parent-event="closeModal"></Signup>
      </div>
    </modal>
    <modal height="auto" name="select2">
      <div id="modal">
        <Signin @parent-event2="closeModal2"></Signin>
      </div>
    </modal>
  </div>
</template>
<script>
import axios from 'axios';
import Menu from './components/Menu.vue'
import Signup from './components/Signup.vue'
import Signin from './components/Signin.vue'

export default {
  name: 'Header',
  components: {
    Menu,
    Signup,
    Signin
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
    openModal2(){
      this.$modal.show('select2');
    },
    closeModal2(){
      this.$modal.hide('select2');
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