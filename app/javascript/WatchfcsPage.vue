<template>
  <div class="main-content">
    <div class="main-content-btn">
      <router-link :to= "'/forecasts'" class="return-top">分析一覧へ戻る</router-link>
      <a :href= "'/forecasts/new'" class="send-btn">投稿する</a>
    </div>
    <div class="text-format mt-5 text-success">
      <!-- {{forecasts[0].tournament}} -->
    </div>
    <p class="text-center h4 mb-3 mt-5">優勝校を予想してみよう</p>
    <div class="champ center-block">
      <i class="fas fa-crown text-warning"></i>
      <a :href= "'/champions/' + num">優勝予想</a>
      <i class="fas fa-crown text-warning"></i>
    </div>
    <!-- 大会 -->
    <div class="text-format mt-5 mb-3 text-warning">
      大会別
    </div>
    <div class="title pb-5 mt-5">
      <div v-for="e in categories" :key="e.id">
        <div v-if="$route.params.id!=e.id">
          <router-link :to="{name: 'watch_fcs',params: {id: e.id}}" @click.native="fetchForecasts()" class="title-child">
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
            <router-link :to="{name: 'forecastshow',params: {id: e.id}}">
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
import axios from 'axios';
export default {
  data() {
    return {
      keyword: '',
      forecasts: [],
      currentPage: this.$store.state.currentPage,
      parPage: 10,
      categories: [],
      num: ''
    }
  },
  mounted() {
    this.fetchForecasts()
    this.fetchCategory()
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
        .get('/api/v1/tournaments/category.json')
        .then(response =>{
          this.categories = response.data;
        })
    },
    clickCallback(pageNum) {
       this.currentPage = Number(pageNum);
       this.$store.state.currentPage = Number(pageNum);
    },
    pageback() {
      this.$nextTick(() => {
          var positionY = sessionStorage.getItem('positionY')
          scrollTo(0, positionY);
          setTimeout(function(){
            scrollTo(0, positionY);
          }, 500);
      })
    }
  },
  computed: {
    getForecasts: function() {
      var forecasts = [];
      for(var i in this.forecasts) {
          var forecast = this.forecasts[i];
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
    }
  }
}
</script>
<style>
  .search-area {
    background-color: white;
    width: 20%;
    margin: 0 auto;
    border-radius: 10px;
  }

  .pagination {
    justify-content: center;
  }
</style>