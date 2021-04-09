<template>
  <div class="main-content">
    <Header></Header>
    <div class="main-content-btn">
      <a :href= "'/forecasts/new'" class="send-btn">投稿する</a>
      <a :href= "'/'" class="return-top">トップページへ戻る</a>
    </div>
    <div class="text-format mt-5 text-primary">
      <div v-for="e in categories" :key="e.id">
        <div v-if="$route.params.id==e.id">
          {{e.category}}
        </div>
      </div>
    </div>
    <p class="text-center h4 mb-3 mt-5">優勝校を予想してみよう</p>
    <div class="champ center-block">
      <i class="fas fa-crown text-warning"></i>
      <router-link :to="{name: 'champion',params: {id: num}}">優勝予想</router-link>
      <i class="fas fa-crown text-warning"></i>
    </div>
    <!-- 大会 -->
    <div class="text-format mt-5 mb-3 text-warning">
      大会別
    </div>
    <div class="title mt-5 ml-5">
      <router-link :to= "'/forecasts'" class="title-child text-white">
        全ての予想一覧
        <i class="fa fa-baseball-ball text-white"></i>
      </router-link>
      <div v-for="e in categories" :key="e.id">
        <div v-if="$route.params.id!=e.id">
          <router-link :to="{name: 'watch_fcs',params: {id: e.id}}" @click.native="fetchForecasts();" class="title-child text-white ml-5">
            <i class="fa fa-baseball-ball text-white"></i>
            {{e.category}}
          </router-link>
        </div>
      </div>
    </div>
    <!--予想  -->
    <div class="forecast-main">
      <div class="text-format pt-5 text-primary">
        みんなの試合予想
      </div>
      <div class="search-area mt-3">
        <input type="text" v-model="keyword" placeholder="検索">
      </div>
      <div v-if="forecasts.length">
        <div v-for="e in getLists" :key="e.id">
          <div class="forecast mt-5">
            <!-- <a :href= "'forecasts/' + e.id"> -->
            <router-link :to="{name: 'forecast-show',params: {id: e.id}}">
              <div class="school-fcs">
                <div class="win-school_fcs">
                  勝利予想
                  <br><br>
                  {{e.win_school}}
                </div>
                <div class="lose-school_fcs">
                  敗退予想
                  <br><br>
                  {{e.lose_school}}
                </div>
              </div>
              <div class="name">
                投稿者
                {{e.nickname}}
              </div>
              <div class="tweets_at">
                {{e.time}}
              </div>
            <!-- </a> -->
            </router-link>
          </div>
        </div>
      </div>
      <div v-else>
        <p class="text-center mt-5">投稿された予想はありません</p>
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
  </div>
</template>
<script>
import axios from 'axios'
import Header from './components/Header.vue'
export default {
  components: {
    Header
  },
  data() {
    return {
      keyword: this.$store.state.keyword_wf,
      forecasts: [],
      currentPage: this.$store.state.currentPage_wf,
      parPage: 10,
      categories: [],
      num: ''
    }
  },
  mounted() {
    this.keyword = this.$store.state.keyword_wf
    this.fetchForecasts()
    this.fetchCategory()
    if (this.keyword == '') {
      this.currentPage = this.$store.state.currentPage_wf
    }
    else {
      this.currentPage = 1
    }
  },
  methods: {
    fetchForecasts() {
      axios
        .get(`/api/v1/tournaments/${this.$route.params.id}/watch_fcs.json`)
        .then(response =>{
        this.forecasts = response.data;
        this.num = this.$route.params.id
        })
    },
    fetchCategory() {
      axios
        .get('/api/v1/tweets/category.json')
        .then(response =>{
          this.categories = response.data;
        })
    },
    clickCallback(pageNum) {
       this.currentPage = Number(pageNum);
       this.$store.state.currentPage_wf = Number(pageNum);
    },
    pageback() {
      this.$nextTick(() => {
          let positionY = sessionStorage.getItem('positionY')
          scrollTo(0, positionY);
          setTimeout(function(){
            scrollTo(0, positionY);
          }, 500);
      })
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
      this.$store.state.keyword_wf = this.keyword
    },
    '$route'(to, from) {
      this.fetchForecasts()
      this.currentPage=1
      this.keyword = ''
    }
  }
}
</script>
<style>
  .pagination {
    justify-content: center;
  }
</style>