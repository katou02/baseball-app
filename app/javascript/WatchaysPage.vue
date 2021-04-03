<template>
<div class="main-content">
  <div class="main-content-btn">
    <router-link :to= "'/analyses'" class="return-top">分析一覧へ戻る</router-link>
    <a :href= "'/analyses/new'" class="send-btn">投稿する</a>
  </div>
  <div class="text-format mt-5 text-primary">
    <div v-for="e in categories" :key="e.id">
      <div v-if="$route.params.id==e.id">
        {{e.category}}
      </div>
    </div>
  </div>
  <div class="go-avg text-center mt-4">
    <div class="avg-ays">
      みんなの分析を元にした平均評価を見る<br>
      <router-link :to="{name: 'average',params: {id: $route.params.id}}" class="ays-avg">平均評価を見る</router-link>
      <!-- <a :href= "'/tournaments/' + num +'/watch_avg'" class="ays-avg">平均評価を見る</a> -->
    </div>
    <div class="homedown">
      甲子園でお馴染みのふるさと紹介<br>
      <router-link :to="{name: 'map',query: {tournament_id: num}}" class="ays-avg">ふるさと</router-link>
      <a :href= "'/maps?tournament_id=' + num" class="ays-avg">ふるさと紹介</a>
    </div>
  </div>
  <!-- 大会 -->
  <div class="text-format mt-5 mb-3 text-warning">
    大会別
  </div>
  <div class="title mt-5">
    <div v-for="e in categories" :key="e.id">
      <div v-if="$route.params.id!=e.id">
        <router-link :to="{name: 'watch_ays',params: {id: e.id}}" @click.native="fetchAnalyses();" class="title-child ml-5">
          <i class="fa fa-baseball-ball text-white"></i>
          {{e.category}}
        </router-link>
      </div>
    </div>
  </div>
  <div class="analysis-main">
    <div class="text-format pt-5 text-warning">
      みんなの戦力分析
    </div>
    <div class="search-area mt-3">
      <input type="text" v-model="keyword" placeholder="検索">
    </div>
    <div v-for="e in getLists" :key="e.id">
      <div class="analysis mt-5">
        <router-link :to= "'/analyses/' + e.id">
          <div class="school_ays-name">
            {{e.school}}
          </div>
          <div class="analysis-image">
            <i class="fa fa-search"></i>
          </div>
          <div class="sub-title text-center">
            {{e.title}}
          </div>
          <div class="name">
            <span>投稿者</span>
            {{e.nickname}}
          </div>
          <div class="analyses_at">
            {{e.time}}
          </div>
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
        :force-page="currentPage"
        :prev-text="'＜'"
        :next-text="'＞'"
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
export default {
  data() {
    return {
      keyword: this.$store.state.keyword_wa,
      analyses: [],
      currentPage: this.$store.state.currentPage_wa,
      parPage: 10,
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
          this.analyses = response.data;
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