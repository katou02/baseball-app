<template>
  <div class="user-content pt-5">
    <h2>DM一覧</h2>
    <div class="user-list row">
      <div v-for="e in rooms" :key="e.id">
        <div class="col-xs-12 col-md-6 col-lg-3 mt-3 card">
          <a :href= "'/rooms/' + e.room_id">{{e.user}}とのDM
            <div class="user-list-image border-bottom">
              <div v-if="e.user_image.url"> 
                <img :src= e.user_image.url class="user-icon mt-3">
              </div>
              <div v-else>
                <img src="../assets/images/no-image.png" class="user-icon mt-3">
              </div>
            </div>
          </a>
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
      rooms: []
    }
  },
  mounted() {
    this.fetchRooms()
  },
  methods: {
    fetchRooms() {
      axios
        .get('api/v1/rooms')
        .then(response =>{
          this.rooms = response.data;
        })
    }
  }
}
</script>