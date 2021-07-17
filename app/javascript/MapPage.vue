<template>
  <div class="map-content">
    <Img></Img>
    <div class="text-format mt-5 text-warning">出場校のふるさとを紹介</div>
    <div class="text-format pt-4 text-primary">
      <div v-for="e in categories" :key="e.id">
        <div v-if="$route.query.tournament_id==e.id">
          {{e.category}}
        </div>
      </div>
    </div>
    <div class="text-center">
      <!-- <router-link :to="{name: 'watch_ays',params: {id: $route.query.tournament_id}}" class="ays-avg">戻る</router-link> -->
      <span v-if="current_user!=null">
        <!-- <router-link :to="{name: 'map-new',query: {tournament_id: $route.query.tournament_id}}" class="ays-avg">紹介する</router-link> -->
        <button class="ays-avg" @click="openModal">紹介する</button>
      </span>
    </div>
    <div class="search-area mt-5">
      <v-text-field type="text" v-model="keyword" label="検索"></v-text-field>
    </div>
    <div class="d-flex list">
      <Side></Side>
      <v-row class="ml-5">
        <v-col cols="12"  sm="6" md="6" lg="6" v-for="e in getLists" :key="e.id">
          <div class="article mt-5">
            <router-link :to="{name: 'map-show',params: {id: e.id}}">
              <div class="d-flex h-100">
                <div v-if="e.image.url"><img :src="e.image.url" class="map-icon"></div>
                <div v-else><img src="/images/ball.jpg" class="map-icon"></div>
                <div class="article-heading mx-auto">
                  <div class="sub-title">
                    <v-chip color="light-green" text-color="white" class="font-weight-bold">{{e.school}}のふるさと</v-chip>
                  </div>
                  <div class="name">
                    投稿者:{{e.nickname}}
                    <span v-if="e.user_image.url"><img :src= e.user_image.url class="user-icon2"></span>
                    <span v-else><img src="../assets/images/no-image.png" class="user-icon2"></span><br><br>
                    投稿日:{{e.time}}
                  </div>
                </div>
              </div>
            </router-link>
          </div>
        </v-col>
      </v-row>
    </div>
    <modal name="select" height="auto" width="65%" :scrollable="true">
      <div id="modal">
        <New @parent-event="fetchMaps"></New>
        <button @click="closeModal">閉じる</button>
      </div>
    </modal>
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
import New from './components/MapNew.vue'
import Img from './components/Img.vue'
export default {
  components: {
    Side,
    New,
    Img
  },
  data() {
    return {
      keyword: '',
      maps: [],
      categories: [],
      currentPage: 1,
      parPage: 12,
      current_user: '',
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
      this.closeModal()
      axios
        .get(`api/v1/maps.json?tournament_id=${this.$route.query.tournament_id}`)
        .then(response =>{
          this.maps = response.data;
          this.id = this.$route.query.tournament_id
        }),
      axios
        .get(`/api/v1/maps/new?tournament_id=1`)
        .then(response => {
          this.current_user = response.data.current_user
          if(!response.data.current_user && this.$store.state.signedIn == true) {
            delete localStorage.csrf
            delete localStorage.signedIn
            this.$router.go(`/champions/${this.$route.query.tournament_id}`)
          }
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
    openModal(){
      this.$modal.show('select');
    },
    closeModal(){
      this.$modal.hide('select');
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