<template>
  <div class="room-content">
    <div class="user-in">
      <div class="room-member mr-5 pt-2">
        <router-link :to="{name: 'user-show',params: {id: user.id}}">{{user.nickname}}</router-link>
        <div v-if="image"> 
          <img :src= image class="room-user-icon mt-1 mb-5">
        </div>
        <div v-else>
          <img src="../assets/images/no-image.png" class="room-user-icon mt-1 mb-5">
        </div>
      </div>
    </div>
    <div class="dmMain">
      <div v-for="e in messages" :key="e.id">
        <div v-if="e.user_id == data.current_user.id ">
          <div class="my-messages">
            <div class="my-message mt-5 ml-5">{{e.text}}</div>
          </div>
          <div class="message-time">{{e.time}}</div>
        </div>
        <div v-else>
          <div class="pair-messages">
            <span v-if="image">
              <img :src= image class="room-user-icon">
            </span>
            <span v-else>
              <img src="../assets/images/no-image.png" class="room-user-icon">
            </span>
            <div class="message mt-5 ml-5">{{e.text}}</div>
          </div>
          <div class="message-time-pair">{{e.time}}</div>
        </div>
      </div>
    </div>
    <div class="message-input">
      <form @submit.prevent="createMessage">
        <!--<div  v-if="errors.length != 0">
          <ul v-for="e in errors" :key="e">
            <li><font color="red">{{ e }}</font></li>
          </ul>
        </div>-->
        <div v-if="data.check!=null">
          <div class="message-form">
            <div class="mx-auto d-flex w-50">
              <!-- <textarea v-model="body" type="text" class="message-detail"></textarea> -->
              <v-text-field v-model="text" solo label="メッセージ" clearable></v-text-field>
              <v-btn type="submit" class="message-btn ml-2 info" >
                <i class="fas fa-paper-plane"></i>
              </v-btn>
            </div>
          </div>
        <p v-if="!!errors['text']" style="color: red;" class="text-center">{{ errors['text'][0]}}</p>
        </div>
        <div v-else>
          <h4>フォローするとメッセージが送信できます</h4>
        </div>
      </form>
    </div>
  </div>
</template>
<script>
import axios from 'axios';
export default {
  data() {
    return {
      messages: [],
      image: '',
      user: '',
      data: '',
      text: '',
      errors: '',
      current_user: ''
    }
  },
  mounted() {
    this.fetchUser()
    this.fetchMember()
  },
  methods: {
    fetchUser() {
      axios
        .get('/api/v1/rooms')
        .then(response =>{
          this.current_user = response.data.current_user
          if(!response.data.current_user) {
            this.$router.push({ name: 'top'});
          }
          if(!response.data.current_user) {
            delete localStorage.csrf
            delete localStorage.signedIn
            this.$router.push({ name: 'top'});
          }
        })
    },
    fetchMember() {
      axios
        .get(`/api/v1/rooms/${this.$route.params.id}.json`)
        .then(response =>{
          this.messages = response.data.message
          this.image = response.data.member[0].user.image.url
          this.user = response.data.member[0].user
          this.data = response.data
          var element = document.documentElement;
          var bottom = element.scrollHeight - element.clientHeight;
          window.scroll(0, bottom);
        })
    },
    createMessage() {
      axios
        .post('/api/v1/messages',{text: this.text,room_id: this.$route.params.id})
        .then(response => {
          this.text = "";
          this.fetchMember()
        })
        .catch(error => {
          console.error(error);
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
        });
    }
  }
}
</script>
<style scoped>
.v-btn:not(.v-btn--round).v-size--default {
  height: 45px;
}
</style>