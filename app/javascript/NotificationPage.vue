<template>
  <div class="notification-content">
    <Menu></Menu>
    <div class="notification-title pt-5">
      <i class="fas fa-envelope"></i>
      通知
    </div>
    <div class="notification">
      <div class="mx-auto text-center">
        <div v-for="e in listNotifications" :key="e.id">
          <div v-if="e.visiter_id!=e.visited_id">
            <div class="notification-info mt-5">
              <div v-if="e.visiter_image.url"> 
                <img :src= e.visiter_image.url class="user-icon mt-1 mb-5">
              </div>
              <div v-else>
                <img src="../assets/images/no-image.png" class="user-icon mt-1 mb-5">
              </div>
              <div class="mt-5 ml-5">
              <router-link :to="{name: 'user-show',params: {id: e.visiter_id}}">{{e.visiter}}</router-link>が
              <span v-if="e.action==='follow'">
                あなたをフォローしました
              </span>
              <span v-else-if="e.action==='like'">
                あなたの<router-link :to="{name: 'tweet-show',params: {id: e.tweet}}">投稿</router-link>にいいねをしました
              </span>
              <span v-else-if="e.action==='comment'">
                あなたの<router-link :to="{name: 'tweet-show',params: {id: e.tweet}}">投稿</router-link>にコメントをしました
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
              ({{e.time+"前"}})
              </div>
            </div>
          </div>
        </div>
        <button
          class="list-item-button text-center"
          v-if="(listNotifications.length - count) >= 0"
          type="button"
          @click="isMore"
        >
          もっと見る
        </button>
      </div>
    </div>
  </div>
</template>
<script>
import axios from 'axios';
import Menu from './components/Menu.vue'
export default {
  components: {
    Menu
  },
  data() {
    return {
      notifications: [],
      current_user: '',
      count: 10
    }
  },
  mounted() {
    this.fetchNotifications()
  },
  beforeUpdate() {
    if(this.current_user===9999) {
      this.$router.push({ name: 'top'});
    }
  },
  methods: {
    fetchNotifications() {
      axios
        .get('api/v1/notifications')
        .then(response =>{
          this.notifications = response.data.notification;
          this.current_user = response.data.current_user
        })
    },
    isMore() {
      this.count += 10
    }
  },
  computed: {
    listNotifications() {
      const list = this.notifications
      return list.slice(0, this.count)
    }
  },
  beforeDestroy() {
    axios
      .get('api/v1/notifications')
      .then(response =>{
        this.notifications = response.data.notification;
        this.current_user = response.data.current_user
      })
  }
}
</script>