<template>
<div class="main-content">
  <Header></Header>
  <div class="main-content-btn">
    <!-- <a :href= "'/analyses/new'" class="send-btn">投稿する</a> -->
    <router-link :to="{name: 'analysis-new'}" class="send-btn">投稿する</router-link>
    <a :href= "'/'" class="return-top">トップページへ戻る</a>
  </div>
  <div class="text-format mt-5 text-success">
    戦力分析をみんなで共有してみましょう！
  </div>
  <div class="text-format mt-5 mb-4 text-warning">
    大会別
  </div>
  <div class="title mt-5">
    <div v-for="e in categories" :key="e.id">
      <!-- <a :href= "'/tournaments/' + e.id + '/watch_ays'" class="title-child text-white"> -->
      <router-link :to="{name: 'watch_ays',params: {id: e.id}}" class="title-child text-white ml-5">
        <i class="fa fa-baseball-ball text-white"></i> 
        {{e.category}}
      <!-- </a> -->
      </router-link>
    </div>
  </div>
  <div class="analysis-main">
    <div class="text-format pt-5 text-warning">
      みんなの戦力分析
    </div>
    <div class="search-area mt-3">
      <input type="text" v-model="keyword" placeholder="検索">
    </div>
    <div class="d-flex">
      <Side></Side>
      <v-row>
        <v-col cols="12"  sm="12" md="12" lg="6" v-for="e in getLists" :key="e.id">
          <div class="article mt-5">
            <router-link :to="{name: 'analysis-show',params: {id: e.id}}">
              <div class="d-flex h-100">
                <div v-if="e.image.url"><img :src="e.image.url" class="article-icon"></div>
                <div v-else><img src="/images/ball.jpg" class="article-icon"></div>
                <div class="article-heading mx-auto">
                  <div class="name">
                    投稿者{{e.nickname}}
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
import Header from './components/Header.vue'
import Side from './components/Side.vue'
export default {
  components: {
    Header,
    Side
  },
  data() {
    return {
      keyword: this.$store.state.keyword_ays,
      analyses: [],
      categories: [],
      currentPage: this.$store.state.currentPage,
      parPage: 10,
      current_slide: 0,
    }
  },
  mounted() {
    this.fetchAnayses()
    this.fetchCategory()
    if (this.keyword == '') {
    }
    else {
      this.currentPage = 1
    }
  },
  methods: {
    fetchAnayses() {
      axios
        .get('api/v1/analyses.json')
        .then(response =>{
        this.analyses = response.data;
        })
    },
    fetchCategory() {
      axios
        .get('api/v1/tweets/category.json')
        .then(response =>{
          this.categories = response.data;
        })
    },
    clickCallback: function (pageNum) {
       this.currentPage = Number(pageNum);
       this.$store.state.currentPage = Number(pageNum);
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
     }
  },
  watch: {
    keyword: function(){
      this.currentPage = 1;
      this.$store.state.keyword_ays = this.keyword
    }
  },
  beforeDestroy() {
    this.$store.commit('increment')
  },
}
</script>
<style scoped>
a.page-link {
  background-color: aqua;
}
</style>