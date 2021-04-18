<template>
  <div class="user-view">
    <div class="notification-info">
      <div v-for="e in notifications" :key="e.id">
        <router-link :to="{name: 'user-show',params: {id: e.visiter_id}}">{{e.visiter}}</router-link>が
        <span v-if="e.action==='follow'">
          あなたをフォローしました
        </span>
        <span v-else-if="e.action==='like'">
          あなたの<router-link :to="{name: 'tweetshow',params: {id: e.tweet}}">投稿</router-link>にいいねをしました
        </span>
        <span v-else-if="e.action==='comment'">
          あなたの<router-link :to="{name: 'tweetshow',params: {id: e.tweet}}">投稿</router-link>にコメントをしました
        </span>
        <span v-else-if="e.action==='comment_analysis'">
          あなたの<router-link :to="{name: 'analysis-show',params: {id: e.analysis}}">投稿</router-link>にコメントをしました
        </span>
        <span v-else-if="e.action==='comment_forecast'">
          あなたの<router-link :to="{name: 'forecast-show',params: {id: e.forecast}}">投稿</router-link>にコメントをしました
        </span>
        <span v-else-if="e.action==='dm'">
          あなたに<router-link :to="{name: 'room-show',params: {id: e.room}}">メッセージ</router-link>を送りました
        </span>
        {{e.time+"前"}}
      </div>
    </div>
  </div>
</template>
<script>
import axios from 'axios';
export default {
  data() {
    return {
      notifications: []
    }
  },
  mounted() {
    this.fetchNotifications()
  },
  methods: {
    fetchNotifications() {
      axios
        .get('api/v1/notifications')
        .then(response =>{
          this.notifications = response.data.notification;
        })
    }
  }
}
</script>