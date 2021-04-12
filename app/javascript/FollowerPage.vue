<template>
  <div class="user-content pt-5">
    <div v-if="users.length">
      <h2>フォロー:{{users[0].count}}人</h2>
    </div>
    <div v-else>
      <h2>フォロー:0人</h2>
    </div>
    <div class="search-area mt-5">
      <input type="text" v-model="keyword" placeholder="検索">
    </div>
    <div class="user-list row">
      <div v-for="e in getLists" :key="e.id" class="col-xs-12 col-md-6 col-lg-3 mt-3 card">
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
    <div class="text-center">
      <paginate
        :v-model="currentPage" 
        :page-count="getPageCount"
        :click-handler="clickCallback"
        :page-range="3"
        :margin-pages="2"
        :prev-text="'＜'"
        :next-text="'＞'"
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
      keyword: this.$store.state.keyword_follower,
      users: [],
      parPage: 16,
      currentPage: this.$store.state.currentPage,
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
    },
    clickCallback(pageNum) {
      this.currentPage = Number(pageNum);
      this.$store.state.currentPage = Number(pageNum);
    },
  },
  computed: {
    getUsers: function() {
      let users = [];
      for(let i in this.users) {
          let user = this.users[i];
          if( user.name.indexOf(this.keyword) !== -1 ) {
              users.push(user);
          }
      }
      return users;
     },
    getLists: function() {
       let current = this.currentPage * this.parPage;
       let start = current - this.parPage;
       return this.getUsers.slice(start, current);
     },
     getPageCount: function() {
       return Math.ceil(this.getUsers.length / this.parPage);
     }
  },
  watch: {
    keyword: function(){
      this.currentPage = 1;
    }
  }
}
</script>