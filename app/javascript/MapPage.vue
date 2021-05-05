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
    <h3 class="pt-4">出場校のふるさとを紹介</h3>
    <div class="text-format mt-5 mb-4 text-warning">
      大会別
    </div>
    <!--<div class="title pb-5 mt-5">
      <div v-for="e in categories" :key="e.id">
        <div v-if="$route.query.tournament_id!=e.id">
          <router-link :to="{name: 'map',query: {tournament_id: e.id}}" @click.native="fetchMaps()" class="title-child text-white ml-5">
            <i class="fa fa-baseball-ball text-white"></i> 
            {{e.category}}
          </router-link>
        </div>
      </div>
    </div>-->
    <div class="search-area mt-5">
      <v-text-field type="text" v-model="keyword" label="検索"></v-text-field>
    </div>
    <div class="d-flex">
      <Side></Side>
      <v-row>
        <v-col cols="12"  sm="6" md="6" lg="4" v-for="e in getLists" :key="e.id">
          <div class="map-deta mt-5">
            <router-link :to="{name: 'map-show',params: {id: e.id}}">
              <div class="d-flex h-100">
                <div v-if="e.image.url"><img :src="e.image.url" class="article-icon"></div>
                <div v-else><img src="/images/ball.jpg" class="article-icon"></div>
                <div class="article-heading mx-auto bg-white">
                  <div class="name">
                    投稿者
                    {{e.nickname}}<br>
                    {{e.time}}
                  </div>
                  <div class="sub-title">
                    {{e.school}}のふるさと
                  </div>
                  <div class="text-center">
                    <img src="/images/hurusato.jpeg" width="50px" height="40px" >
                  </div>
                </div>
              </div>
            </router-link>
          </div>
        </v-col>
      </v-row>
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
        :next-link-class="'page-link'"
        :prev-link-class="'page-link'"
        :container-class="'pagination'"
        :page-link-class="'page-link'">
      </paginate>
    <div v-if="!maps.length" class="text-center mt-5">
      <p>投稿された紹介がありません</p>
    </div>
    </div>
  </div>
</template>
<script>
import axios from 'axios'
import Side from './components/Side.vue'
export default {
  components: {
    Side
  },
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
    },
    '$route'(to, from) {
      this.fetchMaps()
      this.currentPage=1
      this.keyword = ''
    }
  }
} 
</script>