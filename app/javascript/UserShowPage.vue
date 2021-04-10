<template>
  <div class="mypage-content pt-3">
    <a :href= "'/'" class="return-top">トップページへ戻る</a>
    <router-link :to="{name: 'user'}" class="users-btn">ユーザー一覧</router-link>
    <p class="text-center">{{user.id}}</p>

    <div class="myname mt-5">
      <h2>{{user.nickname}}さんのプロフィール</h2>
    </div>
    <div class="myprof">
      <div class="user-info">
        <div v-if="user.image.url"> 
          <img :src= user.image.url class="user-icon mt-1 mb-5">
        </div>
        <div v-else>
          <img src="../assets/images/no-image.png" class="user-icon mt-1 mb-5">
        </div>
      </div>
      <div class="residence">
        <p class="text-primary font-weight-bold">住んでる場所</p>
        <br>{{user.prefecture}}
      </div>
      <div class="text-myname">
        <p class="text-primary font-weight-bold">自己紹介</p>
        <p style="white-space:pre-wrap;">{{user.text}}</p>
      </div>
    </div>
  </div>
</template>
<script>
import axios from 'axios'
export default {
  data() {
    return {
      tab: null,
      user: [],
      tabs: ['投稿した試合記事','投稿した戦力分析','投稿した試合予想','いいねした試合記事'],
       text: 'Lorem ipsum dolor sit amet'
    }
  },
  mounted() {
    this.fetchUser()
  },
  methods: {
    fetchUser() {
      axios
        .get(`/api/v1/users/${this.$route.params.id}.json`)
        .then(response =>{
          this.user = response.data
        })
    }
  }
}
</script>