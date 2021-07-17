<template>
  <div class="main-content">
    <!-- <Header></Header> -->
    <div class="main-content-btn">
      <div v-if="current_user">
        <!-- <router-link :to="{name: 'analysis-new'}" class="send-btn text-white">投稿する</router-link> -->
        <button class="send-btn text-white" @click="openModal">投稿する</button>
      </div>
      <router-link :to="{name: 'top'}" class="return-top text-white">トップページ</router-link>
    </div>
    <div class="text-format mt-5 text-warning">
      戦力分析をみんなで共有してみましょう！
    </div>
    <Img></Img>
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
      </div>
    </div>
    <!-- 大会 -->
    <div class="analysis-main mt-5">
      <div class="text-format pt-5 text-primary">
        みんなの戦力分析
      </div>
      <div class="search-area mt-3">
        <v-text-field type="text" v-model="keyword" label="検索"></v-text-field>
      </div>
      <div class="d-md-flex list mt-5">
        <Side></Side>
        <v-row class="ml-5">
          <v-col cols="12"  sm="12" md="12" lg="6" v-for="e in getLists" :key="e.id">
            <div class="article mt-5">
              <router-link :to= "'/analyses/' + e.id">
                <div class="d-flex h-100">
                  <div v-if="e.image.url"><img :src="e.image.url" class="article-icon"></div>
                  <div v-else><img src="/images/ball.jpg" class="article-icon"></div>
                  <div class="article-heading mx-auto text-center">
                    <div class="post-time">
                      投稿:{{e.time}}
                    </div>
                    <div class="school-ays-name mt-3">
                      <v-card color="light-green">
                        <div class="text-white">{{e.school}}</div>
                      </v-card>
                    </div>
                    <div v-if="e.title.length <=15" class="sub-title-ays mt-3">
                      {{e.title}}
                    </div>
                    <div v-else class="sub-title mt-3">{{e.title.slice(0,15) + '...'}}</div>
                    <div class="name">
                      投稿者:{{e.nickname}}
                      <span v-if="e.user_image.url"><img :src= e.user_image.url class="user-icon2"></span>
                      <span v-else><img src="../assets/images/no-image.png" class="user-icon2"></span>
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
      <modal name="select" height="auto" width="65%" :scrollable="true">
        <div id="modal">
          <New @parent-event="fetchAnalyses"></New>
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
import New from './components/AnalysisNew.vue'
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
      this.closeModal()
      axios
        .get(`/api/v1/tournaments/${this.$route.params.id}/watch_ays.json`)
        .then(response =>{
          this.analyses = response.data.analyses;
          this.current_user = response.data.current_user
          this.num = this.$route.params.id
          if(!response.data.current_user && this.$store.state.signedIn == true) {
            delete localStorage.csrf
            delete localStorage.signedIn
            this.$router.go(`/tournaments/${this.$route.params.id}/watch_ays`)
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
    },
    openModal(){
      this.$modal.show('select');
    },
    closeModal(){
      this.$modal.hide('select');
    },
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
