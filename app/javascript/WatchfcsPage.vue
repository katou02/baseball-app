<template>
  <div class="main-content">
    <!-- <Header></Header> -->
    <div class="main-content-btn">
      <div v-if="current_user">
        <!-- <router-link :to="{name: 'forecast-new'}" class="send-btn text-white">投稿する</router-link> -->
        <button class="send-btn text-white" @click="openModal">投稿する</button>
      </div>
      <router-link :to="{name: 'top'}" class="return-top text-white">トップページ</router-link>
    </div>
    <!-- <div class="text-format mt-5 mb-3 text-warning">
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
    </div> -->
    <div class="text-format mt-5 text-warning">
      試合予想をしてみましょう！
    </div>
    <div class="text-format mt-5 text-primary">
      <div v-for="e in categories" :key="e.id">
        <div v-if="$route.params.id==e.id">
          {{e.category}}
        </div>
      </div>
    </div>
    <Img></Img>
    <div class="forecast-main">
      <div class="text-format pt-5 text-primary">
        みんなの試合予想
      </div>
      <div class="search-area mt-3">
        <v-text-field type="text" v-model="keyword" label="検索"></v-text-field>
      </div>
      <div class="d-md-flex list">
        <Side></Side>
        <v-row class="ml-5">
          <v-col cols="12" sm="12" md="12" lg="6" v-for="e in getLists" :key="e.id">
            <div class="article mt-5">
              <router-link :to="{name: 'forecast-show',params: {id: e.id}}">
                <div class="d-flex h-100">
                  <img src="/images/ball.jpg" class="article-icon">
                  <div class="article-heading mx-auto">
                    <div class="name">
                      投稿者 {{e.nickname}}<br>
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
        <div v-if="!forecasts.length" class="text-center mt-5">
          <p>投稿された予想はありません</p>
        </div>
        </v-row>
      </div>
      <modal name="select" height="auto" width="65%" :scrollable="true">
        <div id="modal">
          <New @parent-event="fetchForecasts"></New>
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
          :force-page="currentPage"
          :hide-prev-next="true"
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
import Side from './components/Side.vue'
import New from './components/ForecastNew.vue'
import Img from './components/Img.vue'
export default {
  components: {
    Header,
    Side,
    New,
    Img
  },
  data() {
    return {
      keyword: this.$store.state.keyword_wf,
      forecasts: [],
      currentPage: this.$store.state.currentPage_wf,
      current_user: '',
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
      this.closeModal()
      axios
        .get(`/api/v1/tournaments/${this.$route.params.id}/watch_fcs.json`)
        .then(response =>{
          this.forecasts = response.data.forecasts;
          this.current_user = response.data.current_user
          this.num = this.$route.params.id
          if(!response.data.current_user && this.$store.state.signedIn == true) {
            delete localStorage.csrf
            delete localStorage.signedIn
            this.$router.go(`/tournaments/${this.$route.params.id}/watch_fcs`)
          }
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
    },
    openModal(){
      this.$modal.show('select');
    },
    closeModal(){
      this.$modal.hide('select');
    },
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