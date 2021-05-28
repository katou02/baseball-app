<template>
  <div class="main-content">
    <!-- <Header></Header> -->
    <div class="main-content-btn">
      <div v-if="current_user">
        <router-link :to="{name: 'analysis-new'}" class="send-btn text-white">投稿する</router-link>
      </div>
      <router-link :to="{name: 'top'}" class="return-top text-white">トップページ</router-link>
    </div>
    <div class="text-format mt-5 text-success">
      戦力分析をみんなで共有してみましょう！
    </div>
    <!-- <div class="text-format mt-5 mb-3 text-warning">
      大会別
    </div>
    <div class="title mt-5 ml-5">
      <router-link :to= "'/analyses'" class="title-child text-white">
        全ての分析
        <i class="fa fa-baseball-ball text-white"></i>
      </router-link>
      <div v-for="e in categories" :key="e.id">
        <div v-if="$route.params.id!=e.id">
          <router-link :to="{name: 'watch_ays',params: {id: e.id}}" @click.native="fetchAnalyses();" class="title-child text-white ml-5">
            <i class="fa fa-baseball-ball text-white"></i>
            {{e.category}}
          </router-link>
        </div>
      </div>
    </div> -->
    <div class="text-format mt-5 text-primary">
      <div v-for="e in categories" :key="e.id">
        <div v-if="$route.params.id==e.id">
          {{e.category}}
        </div>
      </div>
    </div>
    <div class="go-avg text-center mt-5">
      <div class="avg-ays">
        みんなの分析を元にした平均評価<br>
        <router-link :to="{name: 'average',params: {id: $route.params.id}}" class="ays-avg">平均評価を見る</router-link>
        <!-- <a :href= "'/tournaments/' + num +'/watch_avg'" class="ays-avg">平均評価を見る</a> -->
      </div>
      <!-- <div class="homedown">
        甲子園でお馴染みのふるさと紹介<br>
        <router-link :to="{name: 'map',query: {tournament_id: num}}" class="ays-avg">ふるさと紹介</router-link>
      </div> -->
    </div>
    <!-- 大会 -->
    <div class="analysis-main mt-5">
      <div class="text-format pt-5 text-warning">
        みんなの戦力分析
      </div>
      <div class="search-area mt-3">
        <v-text-field type="text" v-model="keyword" label="検索"></v-text-field>
      </div>
      <div class="d-flex">
        <Side></Side>
        <v-row class="ml-5">
          <v-col cols="12"  sm="12" md="12" lg="6" v-for="e in getLists" :key="e.id">
            <div class="analysis mt-5">
              <router-link :to= "'/analyses/' + e.id">
                <div class="d-flex h-100">
                  <div v-if="e.image.url"><img :src="e.image.url" class="article-icon"></div>
                  <div v-else><img src="/images/ball.jpg" class="article-icon"></div>
                  <div class="article-heading mx-auto text-center">
                    <div class="name">
                      投稿者 {{e.nickname}}<br>
                      {{e.time}}
                    </div>
                    <div class="school_ays-name mt-3">
                      {{e.school}}
                    </div>
                    <div class="sub-title mt-3">
                      {{e.title}}
                    </div>
                  </div>
                </div>
              </router-link>
            </div>
          </v-col>
        <div v-if="!analyses.length" class="text-center mt-5">
          <p>投稿された分析はありません</p>
        </div>
        </v-row>
      </div>
      <div class="text-center">
        <paginate
          :v-model="currentPage" 
          :page-count="getPageCount"
          :click-handler="clickCallback"
          :page-range="3"
          :margin-pages="2"
          :force-page="currentPage"
          :prev-text="'＜'"
          :next-text="'＞'"
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
export default {
  components: {
    Header,
    Side
  },
  data() {
    return {
      keyword: this.$store.state.keyword_wa,
      analyses: [],
      currentPage: this.$store.state.currentPage_wa,
      parPage: 10,
      current_user: '',
      categories: [],
      current_slide: 0,
      num: ''
    }
  },
  mounted() {
    this.keyword = this.$store.state.keyword_wa
    this.fetchAnalyses()
    this.fetchCategory()
    if (this.keyword == '') {
      this.currentPage = this.$store.state.currentPage_wa
    }
    else {
      this.currentPage = 1
    }
  },
  methods: {
    fetchAnalyses() {
      axios
        .get(`/api/v1/tournaments/${this.$route.params.id}/watch_ays.json`)
        .then(response =>{
          this.analyses = response.data.analyses;
          this.current_user = response.data.current_user
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
       this.$store.state.currentPage_wa = Number(pageNum);
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
    getAnalyses: function() {
    let analyses = [];
      for(let i in this.analyses) {
          let analysis = this.analyses[i];
          if( analysis.school.indexOf(this.keyword) !== -1 ||
              analysis.title.indexOf(this.keyword) !== -1) {
              analyses.push(analysis);
          }
      }
      return analyses;
    },
    getLists: function() {
      let current = this.currentPage * this.parPage;
      let start = current - this.parPage;
      return this.getAnalyses.slice(start, current);
     },
     getPageCount: function() {
       return Math.ceil(this.getAnalyses.length / this.parPage);
     },
  },
  watch: {
    keyword: function(){
      this.currentPage = 1;
      this.$store.state.keyword_wa = this.keyword
    },
    '$route'(to, from) {
      this.fetchAnalyses()
      this.currentPage = 1
      this.keyword = ''
    }
  }
}
</script>
