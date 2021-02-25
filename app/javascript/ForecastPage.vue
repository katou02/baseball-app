<template>
  <div class="forecast-main">
    <div class="text-format pt-5 text-primary">
      みんなの試合記事
    </div>
    <div class="search-area mt-3">
      <input type="text" v-model="keyword" placeholder="検索">
    </div>
    <div v-for="e in getLists" :key="e.id">
      <div class="forecast mt-5">
        <a :href= "'forecasts/' + e.id">
          <div class="school-fcs">
            <div class="win-school_fs">
              勝利予想
              <br><br>
              {{e.win_school}}
            </div>
            <div class="lose-school_fs">
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
        </a>
      </div>
    </div>
    <paginate
      :v-model="currentPage" 
      :page-count="getPageCount"
      :click-handler="clickCallback"
      :page-range="3"
      :margin-pages="2"
      :prev-text="'＜'"
      :next-text="'＞'"
      :container-class="'pagination'"
      :page-class="'page-item'">
    </paginate>
  </div>
</template>
<script>
import axios from 'axios';
export default {
  data() {
    return {
      keyword: '',
      forecasts: [],
      currentPage: 1,
      parPage: 10,
      // totalPages: null,
      current_slide: 0,
    }
  },
  mounted() {
    this.fetchForecasts()
  },
  methods: {
    fetchForecasts() {
      axios
        .get('api/v1/forecasts.json')
        .then(response =>{
        this.forecasts = response.data;
        })
    },
    clickCallback: function (pageNum) {
        this.currentPage = Number(pageNum);
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