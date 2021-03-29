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
        <div v-if="e.user_id == current_user.id ">
          <div class="my-messages">
            <div class="my-message mt-5 ml-5">{{e.body}}</div>
          </div>
        </div>
        <div v-else>
          <div class="messages">
            <div v-if="current_user.image.url">
              <img :src= current_user.image.url class="room-user-icon">
            </div>
            <div v-else>
              <img src="../assets/images/no-image.png" class="user-icon mt-1 mb-5">
            </div>
            <div class="message ml-5">{{e.body}}</div>
          </div>
        </div>
      </div>
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
      current_user: ''
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
          this.current_user = response.data.current_user
        })
    }
  }
}
</script>