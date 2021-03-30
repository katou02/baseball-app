<template>
  <div class="user-content pt-5">
    <h2>DM一覧</h2>
    <div class="search-area mt-3">
      <input type="text" v-model="keyword" placeholder="検索">
    </div>
    <div class="user-list row mx-auto">
      <div v-for="e in getLists" :key="e.id" class="col-xs-12 col-md-6 col-lg-3 mt-3 card">
        <!-- <a :href= "'/rooms/' + e.room_id">{{e.user}}とのDM -->
        <router-link :to="{name: 'roomshow',params: {id: e.room_id}}">
          {{e.user}}とのDM
          <div class="user-list-image border-bottom">
            <div v-if="e.user_image.url"> 
              <img :src= e.user_image.url class="user-icon mt-3">
            </div>
            <div v-else>
              <img src="../assets/images/no-image.png" class="user-icon mt-3">
            </div>
          </div>
        </router-link>
        <!-- </a> -->
      </div>
    </div>
    <div class="text-center">
      <paginate
        :v-model="currentPage" 
        :page-count="getPageCount"
        :click-handler="clickCallback"
        :page-range="3"
        :margin-pages="2"
        :prev-text="'＜'"
        :next-text="'＞'"
        :next-link-class="'page-link'"
        :prev-link-class="'page-link'"
        :container-class="'pagination'"
        :page-link-class="'page-link'">
      </paginate>
    </div>
  </div>
</template>
<script>
import axios from 'axios';
export default {
  data() {
    return {
      rooms: [],
      keyword: '',
      currentPage: 1,
      parPage: 10
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
    },
    clickCallback(pageNum) {
      this.currentPage = Number(pageNum);
    }
  },
  computed: {
    getRooms: function() {
      let rooms = [];
      for(let i in this.rooms) {
        let room = this.rooms[i];
        if( room.user.indexOf(this.keyword) !== -1) {
          rooms.push(room);
        }
      }
      return rooms
    },
    getLists: function() {
      let current = this.currentPage * this.parPage;
      let start = current - this.parPage;
      return this.getRooms.slice(start, current);
    },
    getPageCount: function() {
      return Math.ceil(this.getRooms.length / this.parPage);
    }
  },
  watch: {
    keyword: function(){
      this.currentPage = 1;
      // this.$store.state.keyword = this.keyword
    }
  }
}
</script>