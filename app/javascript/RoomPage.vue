<template>
  <div class="dm-content pt-5">
    <h2>DM一覧</h2>
    <div class="search-area mt-3">
      <v-text-field type="text" v-model="keyword" label="検索"></v-text-field>
    </div>
    <div class="user-list row mx-auto">
      <v-col cols="12"  sm="6" md="3" lg="3" v-for="e in getLists" :key="e.id">
        <router-link :to="{name: 'room-show',params: {id: e.room_id}}">
          {{e.user}}とのDM
          <div class="user-list-image border-bottom">
            <div v-if="e.user_image.url"> 
              <img :src= e.user_image.url class="user-list-icon mt-3">
            </div>
            <div v-else>
              <img src="../assets/images/no-image.png" class="user-list-icon mt-3">
            </div>
          </div>
        </router-link>
      </v-col>
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
        :hide-prev-next="true"
        :force-page="currentPage"
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
      keyword: this.$store.state.keyword_dm,
      currentPage: this.$store.state.currentPage,
      parPage: 10
    }
  },
  mounted() {
    this.fetchRooms()
    if (this.keyword == '') {
    }
    else {
      this.currentPage = 1
    }
  },
  methods: {
    fetchRooms() {
      axios
        .get('/api/v1/rooms')
        .then(response =>{
          this.rooms = response.data.entry;
          if(!response.data.current_user) {
            this.$router.push({ name: 'top'});
          }
          if(!response.data.current_user && this.$store.state.signedIn == true) {
            delete localStorage.csrf
            delete localStorage.signedIn
            this.$router.push({ name: 'top'});
          }
        })
    },
    clickCallback(pageNum) {
      this.currentPage = Number(pageNum);
      this.$store.state.currentPage = Number(pageNum);
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
      this.$store.state.keyword_dm = this.keyword
    }
  }
}
</script>