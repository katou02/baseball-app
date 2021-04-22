<template>
  <div class="map-content">
    <div class="text-format pt-4 text-primary">
      <div v-for="e in categories" :key="e.id">
        <div v-if="$route.query.tournament_id==e.id">
          {{e.category}}
        </div>
      </div>
    </div>
    <div class="text-center">
      <router-link :to="{name: 'map-new',query: {tournament_id: $route.query.tournament_id}}" class="ays-avg">紹介する</router-link>
      <router-link :to="{name: 'watch_ays',params: {id: $route.query.tournament_id}}" class="ays-avg">戻る</router-link>
    </div>
    <h3 class="pt-4">出場校ふるさとを紹介</h3>
    <div class="text-format mt-5 mb-4 text-warning">
      大会別
    </div>
    <div class="title pb-5 mt-5">
      <div v-for="e in categories" :key="e.id">
        <div v-if="$route.query.tournament_id!=e.id">
          <router-link :to="{name: 'map',query: {tournament_id: e.id}}" @click.native="fetchMaps()" class="title-child text-white">
            <i class="fa fa-baseball-ball text-white"></i> 
            {{e.category}}
          </router-link>
        </div>
      </div>
    </div>
    <div class="search-area">
      <input type="text" v-model="keyword" placeholder="検索">
    </div>
    <div class="map-list row mt-5 mx-auto">
      <div v-for="e in getLists" :key="e.id" class="col-xs-12 col-md-6 col-lg-3 mt-3 mb-5 map-card">
        <router-link :to="{name: 'mapshow',params: {id: e.id}}">
        <!-- <a :href = "'maps/' + e.id" class="user-card"> -->
          <div class="map-name bg-white pt-2">
            {{e.school}}
          </div>
          <div class="map-user pt-5">
            投稿者
            {{e.nickname}}
          </div>
          <div class="map-user_image">
            <div v-if="e.image.url">
              <img :src= e.image.url class="map-user_icon mt-3">
            </div>
            <div v-else>
              <img src="../assets/images/no-image.png" class="map-user_icon mt-3">
            </div>
          </div>
        <!-- </a> -->
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
        :next-link-class="'page-link'"
        :prev-link-class="'page-link'"
        :container-class="'pagination'"
        :page-link-class="'page-link'">
      </paginate>
    </div>
  </div>
</template>
<script>
import axios from 'axios'
export default {
  data() {
    return {
      keyword: '',
      maps: [],
      categories: [],
      currentPage: 1,
      parPage: 10,
      // totalPages: null,
      current_slide: 0,
      id: ''
    }
  },
  mounted() {
    this.fetchMaps()
    this.fetchCategory()
  },
  methods: {
    fetchMaps() {
      axios
        .get(`api/v1/maps.json?tournament_id=${this.$route.query.tournament_id}`)
        .then(response =>{
          this.maps = response.data;
          this.id = this.$route.query.tournament_id
        })
    },
    clickCallback: function (pageNum) {
      this.currentPage = Number(pageNum);
    },
    fetchCategory() {
      axios
        .get('api/v1/tweets/category.json')
        .then(response =>{
          this.categories = response.data;
        })
    },
  },
  computed: {
    getMaps: function() {
    var maps = [];
      for(var i in this.maps) {
          var map = this.maps[i];
          if( map.school.indexOf(this.keyword) !== -1) {
              maps.push(map);
          }
      }
      return maps;
    },
    getLists: function() {
      let current = this.currentPage * this.parPage;
      let start = current - this.parPage;
      return this.getMaps.slice(start, current);
    },

     getPageCount: function() {
       return Math.ceil(this.getMaps.length / this.parPage);
    },
  },
  watch: {
    keyword: function(){
      this.currentPage = 1;
    }
  }
} 
</script>