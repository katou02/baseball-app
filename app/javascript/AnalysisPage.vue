<template>
  <div class="analysis-main">
    <div class="text-format pt-5 text-warning">
      みんなの戦力分析
    </div>
    <div class="search-area mt-3">
      <input type="text" v-model="keyword" placeholder="検索">
    </div>
    <div v-for="e in getLists" :key="e.id">
      <div class="analysis mt-5">
        <a :href= "'analyses/' + e.id">
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
        </a>
      </div>
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
        :next-link-class="'page-link'"
        :prev-link-class="'page-link'"
        :container-class="'pagination'"
        :page-link-class="'page-link'">
      </paginate>
    </div>
  </div>
</template>
<script>
import axios from 'axios';
export default {
  data() {
    return {
      keyword: '',
      analyses: [],
      currentPage: 1,
      parPage: 4,
      current_slide: 0,
    }
  },
  mounted() {
    this.fetchAnayses()
  },
  methods: {
    fetchAnayses() {
      axios
        .get('api/v1/analyses.json')
        .then(response =>{
        this.analyses = response.data;
        })
    },
    clickCallback: function (pageNum) {
       this.currentPage = Number(pageNum);
    }
  },
  computed: {
    getAnalyses: function() {
    var analyses = [];
      for(var i in this.analyses) {
          var analysis = this.analyses[i];
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
     watch: {
       keyword: function(){
         this.currentPage = 1;
       }
     }
  }
}
</script>
<style scoped>
a.page-link {
  background-color: aqua;
}
</style>