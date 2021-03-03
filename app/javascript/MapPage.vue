<template>
  <div class="map-contenta">
    <div class="search-area">
      <input type="text" v-model="keyword" placeholder="検索">
    </div>
    <div class="map-list row mt-5 mx-auto">
      <div v-for="e in getLists" :key="e.id" class="col-xs-12 col-md-6 col-lg-3 mt-3 mb-5 map-card">
        <a :href = "'maps/' + e.id" class="user-card">
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
        </a>
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
      currentPage: 1,
      parPage: 10,
      // totalPages: null,
      current_slide: 0,
    }
  },
  mounted() {
    this.fetchMaps()
  },
  methods: {
    fetchMaps() {
      axios
        .get(`api/v1/maps.json?tournament_id=${this.$route.query.tournament_id}`)
        .then(response =>{
          this.maps = response.data;
        })
    },
    clickCallback: function (pageNum) {
      this.currentPage = Number(pageNum);
    }
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