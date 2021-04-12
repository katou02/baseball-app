<template>
  <div class="user-content pt-5">
    <div v-if="users.length">
      <h2>フォロー:{{users[0].count}}人</h2>
    </div>
    <div v-else>
      <h2>フォロー:0人</h2>
    </div>
    <div class="user-list row">
      <div v-for="e in users" :key="e.id" class="col-xs-12 col-md-6 col-lg-3 mt-3 card">
        <router-link :to="{name: 'user-show',params: {id: e.id}}">
          <div class="user-list-image pb-3">
            <div v-if="e.image.url">
              <img :src= e.image.url class="user-icon mt-3">
            </div>
            <div v-else>
              <img src="../assets/images/no-image.png" class="user-icon mt-3">
            </div>
          </div>
          <div class="user-list_body">
            <div class="user-list_name pt-1">
              {{e.name}}
            </div>
            <div class="user-list_text mt-5">
              <div v-if="e.text">{{e.text}}</div>
              <div v-else>自己紹介未記入</div>
            </div>
            <div class="user-address mt-5 pb-3">
              <div v-if="e.prefecture">{{e.prefecture}}</div>
              <div v-else>未選択</div>
            </div>
          </div>
        </router-link>
      </div>
    </div>
  </div>
</template>
<script>
import axios from 'axios';
export default {
  data() {
    return {
      users: []
    }
  },
  mounted() {
    this.fetchUser()
  },
  methods: {
    fetchUser() {
      axios
        .get(`/api/v1/users/${this.$route.params.id}/followers.json`)
        .then(response =>{
          this.users = response.data
        })
    }
  }
}
</script>