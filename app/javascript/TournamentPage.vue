<template>
  <div class="main-content">
    <div class="main-content-btn">
    <router-link :to= "'/tweets'" class="return-top">記事一覧へ戻る</router-link>
    <a :href= "'/tweets/new'" class="send-btn">投稿する</a>
    </div>
    <div class="text-format mt-5 text-primary">
      <div v-for="e in categories" :key="e.id">
        <div v-if="$route.params.id==e.id">
          {{e.category}}
        </div>
      </div>
    </div>
    <div class="text-format mt-5 mb-4 text-warning">
      大会別
    </div>
    <div class="title pb-5 mt-5">
      <div v-for="e in categories" :key="e.id">
        <div v-if="$route.params.id!=e.id">
          <router-link :to="{name: 'tournament',params: {id: e.id}}" @click.native="fetchTweets(); reset()" class="title-child">
            <i class="fa fa-baseball-ball text-white"></i>
            {{e.category}}
          </router-link>
        </div>
      </div>
    </div>
    <div class="tournament-main">
      <div class="text-format pt-5 text-primary">
        みんなの試合記事
      </div>
      <div class="tournament-content pt-5">
        <div class="search-area mt-3">
          <input  type="text" v-model="keyword" placeholder="検索">
        </div>
        <div v-if="tweets.length">
          <div v-for="e in getLists" :key="e.id">
            <div class="article mt-5">
              <router-link :to= "'/tweets/' + e.id">
                <div class="article-title">
                  {{e.school_a}}vs{{e.school_b}}
                </div>
                <div class="article-image">
                  <i class="fa fa-baseball-ball text-white"></i>
                </div>
                <div class="sub-title">
                  {{e.title}}
                </div>
                <div class="name">
                  投稿者 {{e.nickname}}
                </div>
                <div class="tweets_at">
                  {{e.time}}
                </div>
              </router-link>
            </div>
          </div>
        </div>
        <div v-else>
          <p class="text-center mt-5">試合記事はありません</p>
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
            :hide-prev-next="true"
            :next-link-class="'page-link'"
            :prev-link-class="'page-link'"
            :container-class="'pagination'"
            :page-link-class="'page-link'">
          </paginate>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import axios from 'axios'
export default {
  data() {
    return {
      keyword: this.$store.state.keyword_tour,
      tweets: [],
      categories: [],
      currentPage: this.$store.state.currentPage_t,
      parPage: 1,
    }
  },
  mounted() {
    this.fetchTweets()
    this.fetchCategory()
  },
  methods: {
    fetchTweets() {
      axios
        .get(`/api/v1/tournaments/${this.$route.params.id}.json`)
        .then(response =>{
          this.tweets = response.data;
          // this.pageback()
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
       this.$store.state.currentPage_t = Number(pageNum);
    },
    pageback() {
      this.$nextTick(() => {
          let positionY = sessionStorage.getItem('positionY')
          scrollTo(0, positionY);
          setTimeout(function(){
            scrollTo(0, positionY);
          }, 500);
      })
      // this.fetchTweets()
    },
    reset() {
      this.keyword = ''
      this.currentPage = 1
    }
  },
  computed: {
    getTweets: function() {
      let tweets = [];
      for(let i in this.tweets) {
        let tweet = this.tweets[i];
        if( tweet.text.indexOf(this.keyword) !== -1 ||
          tweet.school_a.indexOf(this.keyword) !== -1 ||
          tweet.school_b.indexOf(this.keyword) !== -1 ||
          tweet.title.indexOf(this.keyword) !== -1) 
          {
            tweets.push(tweet);
          }
      }
        return tweets;
    },
     getLists: function() {
       let current = this.currentPage * this.parPage;
       let start = current - this.parPage;
       return this.getTweets.slice(start, current);
     },
     getPageCount: function() {
       return Math.ceil(this.getTweets.length / this.parPage);
     }
  },
  watch: {
    keyword: function(){
      this.currentPage = 1;
      this.$store.state.keyword_tour = this.keyword
    },
    '$route'(to, from) {
      this.fetchTweets()
      this.currentPage=1
    }
  }
}
</script>
<style scoped>
.tournament-main{
  background-image: url("../assets/images/sky.jpg");
   background-size: cover;
   background-color:rgba(255,255,255,0.8);
   background-blend-mode:lighten;
   flex: 1 1 100%;
   min-height: 900px;
}

.search-area {
  background-color: white;
  width: 20%;
  margin: 0 auto;
  border-radius: 10px;
}
</style>