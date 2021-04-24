<template>
  <div class="main-content">
    <Header></Header>
    <div class="main-content-btn">
      <!-- <a :href= "'/forecasts/new'" class="send-btn">投稿する</a> -->
      <router-link :to="{name: 'forecast-new'}" class="send-btn">投稿する</router-link>
      <a :href= "'/'" class="return-top">トップページへ戻る</a>
    </div>
    <div class="text-format mt-5 text-warning">
      試合予想をしてみましょう！<br><br>
      大会別
    </div>
    <div class="title mt-5">
      <div v-for="e in categories" :key="e.id">
        <router-link :to="{name: 'watch_fcs',params: {id: e.id}}"  class="title-child text-white ml-5">
          <i class="fa fa-baseball-ball text-white"></i> 
          {{e.category}}
        </router-link>
      </div>
    </div>
    <div class="forecast-main">
      <div class="text-format pt-5 text-primary">
        みんなの試合予想
      </div>
      <div class="search-area mt-3">
        <input type="text" v-model="keyword" placeholder="検索">
      </div>
      <!-- 記事 -->
      <div class="d-flex">
        <Side></Side>
        <v-row>
          <v-col cols="12"  sm="12" md="12" lg="6"   v-for="e in getLists" :key="e.id">
            <div class="forecast mt-5">
              <router-link :to="{name: 'forecast-show',params: {id: e.id}}">
                <div class="d-flex h-100">
                  <img src="/images/ball.jpg" class="article-icon">
                  <div class="article-heading mx-auto">
                    <div class="name">
                      投稿者{{e.nickname}}
                      {{e.time}}
                    </div>
                    <div class="school-fcs mt-4">
                      <div class="win-school_fcs">
                        勝利予想
                        <br><br>
                        {{e.win_school}}
                      </div>
                      <div class="lose-school_fcs ml-3">
                        敗退予想
                        <br><br>
                        {{e.lose_school}}
                      </div>
                    </div>
                  </div>
                </div>
              </router-link>
            </div>
          </v-col>
        </v-row>
      </div>
      <div v-if="forecasts.length">
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
      <div v-else class="text-center mt-5">
        <p>投稿された予想はありません</p>
      </div>
    </div>
  </div>
</template>
<script>
import axios from 'axios'
import Header from './components/Header.vue'
import Side from './components/Side.vue'
export default {
  components: {
    Header,
    Side
  },
  data() {
    return {
      keyword: this.$store.state.keyword_fcs,
      forecasts: [],
      currentPage: this.$store.state.currentPage,
      parPage: 10,
      categories: [],
      current_slide: 0,
    }
  },
  mounted() {
    setInterval(() => {
        this.current_slide = this.current_slide < this.slides.length -1 ? this.current_slide +1 : 0
      }, 3000)
    this.fetchForecasts()
    this.fetchCategory()
    if (this.keyword == '') {
    }
    else {
      this.currentPage = 1
    }
  },
  methods: {
    fetchForecasts() {
      axios
        .get('api/v1/forecasts.json')
        .then(response =>{
        this.forecasts = response.data;
        })
    },
    fetchCategory() {
      axios
        .get('api/v1/tweets/category.json')
        .then(response =>{
          this.categories = response.data;
        })
    },
    clickCallback(pageNum) {
       this.currentPage = Number(pageNum);
       this.$store.state.currentPage = Number(pageNum);
       console.log(this.$store.state.currentPage)
    },
    pageback() {
      this.$nextTick(() => {
          let positionY = sessionStorage.getItem('positionY')
          scrollTo(0, positionY);
          setTimeout(function(){
            scrollTo(0, positionY);
          }, 500);
      })
    },
    reset() {
      return {
        currentPage: 1
      }
    }
  },
  computed: {
    getForecasts: function() {
      let forecasts = [];
      for(let i in this.forecasts) {
          let forecast = this.forecasts[i];
          if( forecast.round.indexOf(this.keyword) !== -1 ||
              forecast.win_school.indexOf(this.keyword) !== -1 ||
              forecast.lose_school.indexOf(this.keyword) !== -1 ) {
              forecasts.push(forecast);
          }
      }
      return forecasts;
     },
     getLists: function() {
       let current = this.currentPage * this.parPage;
       let start = current - this.parPage;
       return this.getForecasts.slice(start, current);
     },
     getPageCount: function() {
       return Math.ceil(this.getForecasts.length / this.parPage);
     }
  },
  watch: {
    keyword: function(){
      this.currentPage = 1;
      this.$store.state.keyword_fcs = this.keyword
    }
  },
  beforeDestroy() {
    this.$store.commit('increment')
  },
}
</script>