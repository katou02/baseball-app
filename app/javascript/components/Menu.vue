<template>
  <div class="menu-content">
    <v-app-bar>
      <div class="d-flex">
        <v-icon color="blue lighten-1">mdi-baseball</v-icon>
        <v-toolbar-title class="text-h4 font-weight-bold logo">高校野球</v-toolbar-title>
      </div>
      <router-link :to="{name: 'notification'}">
        <v-icon color="blue lighten-1">mdi-bell</v-icon>
        通知
      </router-link>
      <router-link :to="{name: 'user-show',params: {id: current_user}}">
        <v-icon color="blue lighten-1">mdi-account</v-icon>
        マイページ
      </router-link>
      <router-link :to="{name: 'contact'}">
        <v-icon color="blue lighten-1">mdi-email</v-icon>
        お問い合わせ
      </router-link>
    </v-app-bar>
  </div>
</template>
<script>
import axios from 'axios'
export default {
  data() {
    return {
      current_user: ''
    }
  },
  mounted() {
    this.fetchUser()
  },
  methods: {
    fetchUser() {
      axios
        .get(`/api/v1/users.json`)
        .then(response =>{
          this.current_user = response.data[0].current_user
        })
    }
  }
}
</script>
