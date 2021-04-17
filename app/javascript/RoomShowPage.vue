<template>
  <div class="room-content">
    <div class="user-in">
      <div class="room-member mr-5 pt-2">
      <a :href= "'/users/' + id">{{member.user.nickname}}</a>
        <div v-if="member.user.image.url"> 
         <img :src= member.user.image.url class="room-user-icon mt-1 mb-5">
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
            <div class="my-message mt-5 ml-5">{{e.body}}</div>
          </div>
        </div>
        <div v-else>
          <div class="messages">
            <div v-if="data.current_user.image.url">
              <img :src= data.current_user.image.url class="room-user-icon">
            </div>
            <div v-else>
              <img src="../assets/images/no-image.png" class="user-icon mt-1 mb-5">
            </div>
            <div class="message ml-5">{{e.body}}</div>
          </div>
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
            <div class="mx-auto d-flex w-50 pb-2">
              <textarea v-model="body" type="text" class="message-detail"></textarea>
              <button type="submit" class="message-btn ml-2" >
                <i class="fas fa-paper-plane"></i>
              </button>
            </div>
          </div>
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
      member: '',
      id: '',
      data: '',
      body: '',
      check: '',
      errors: ''
    }
  },
  mounted() {
    this.fetchMember()
  },
  methods: {
    fetchMember() {
      axios
        .get(`/api/v1/rooms/${this.$route.params.id}.json`)
        .then(response =>{
          this.messages = response.data.message
          this.member = response.data.member[0]
          this.id = response.data.member[0].user.id
          this.data = response.data
          // this.check = response
        })
    },
    createMessage() {
      axios
        .post('/api/v1/messages',{body: this.body,room_id: this.$route.params.id})
        .then(response => {
          this.body = "";
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