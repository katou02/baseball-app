<template>
  <div class="main-content">
    <!-- <Header></Header> -->
    <div class="main-content-btn">
      <div v-if="tweets.current_user">
        <router-link :to="{name: 'tweet-new'}" class="send-btn text-white">投稿する</router-link>
      </div>
      <router-link :to="{name: 'top'}" class="return-top text-white">トップページ</router-link>
    </div>
    <div class="text-format mt-5 text-primary">
      観た試合の感想をみんなに発信してみましょう！
    </div>
    <!-- <div class="text-format mt-5 mb-4 text-warning">
      大会別
    </div>
    <div class="title mt-5">
      <div v-for="e in categories" :key="e.id">
        <router-link :to="{name: 'tournament',params: {id: e.id}}"  class="title-child text-white ml-5">
          <i class="fa fa-baseball-ball text-white"></i> 
          {{e.category}}
        </router-link>
      </div>
    </div> -->
    <div class="article-main">
      <div class="text-format pt-5 text-primary">
        みんなの試合記事
      </div>
      <div class="search-area mt-3">
        <v-text-field type="text" v-model="keyword" label="検索"></v-text-field>
      </div>
      <!-- 記事 -->
      <div class="d-flex">
        <Side></Side>
        <v-row class="ml-5">
          <v-col cols="12"  sm="12" md="12" lg="6" v-for="e in getLists" :key="e.id">
            <div class="article mt-5">
              <router-link :to="{name: 'tweet-show',params: {id: e.id}}">
                <div class="d-flex h-100">
                  <div v-if="e.image.url"><img :src="e.image.url" class="article-icon"></div>
                  <div v-else><img src="/images/ball.jpg" class="article-icon"></div>
                  <div class="article-heading mx-auto">
                    <div class="name">
                      投稿者 {{e.nickname}}<br>
                      {{e.time}}
                    </div>
                    <div class="article-title mt-3">
                      {{e.school_a}}vs{{e.school_b}}
                    </div>
                    <div class="sub-title">
                      {{e.title}}
                    </div>
                  </div>
                </div>
              </router-link>
            </div>
          </v-col>
        <div v-if="!tweets.length" class="text-center mt-5">
          <p>投稿された試合記事がありません</p>
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
      keyword: this.$store.state.keyword,
      tweets: [],
      categories: [],
      currentPage: this.$store.state.currentPage,
      parPage: 10,
    }
  },
  mounted() {
    this.fetchTweets()
    this.fetchCategory()
    if (this.keyword !== '') {
      this.currentPage = 1
    }
  },
  methods: {
    fetchTweets() {
      axios
        .get('api/v1/tweets.json')
        .then(response =>{
          this.tweets = response.data;
          this.pageback()
        })
    },
    fetchCategory() {
      axios
        .get('api/v1/tweets/category.json')
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
          let positionY = sessionStorage.getItem('positionY')
          scrollTo(0, positionY);
          setTimeout(function(){
            scrollTo(0, positionY);
          }, 500);
      })
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
            tweet.title.indexOf(this.keyword) !== -1) {
            tweets.push(tweet);
          }
        }
        this.$store.state.tweets = tweets
        // return tweets
        return this.$store.state.tweets 
     },
     getLists: function() {
       let current = this.currentPage * this.parPage;
       let start = current - this.parPage;
      //  return this.getTweets.slice(start, current);
       return this.$store.state.tweets.slice(start,current)
     },
     getPageCount: function() {
       return Math.ceil(this.getTweets.length / this.parPage);
     }
  },
  watch: {
    keyword: function(){
      this.currentPage = 1;
      this.$store.state.keyword = this.keyword
    }
  },
  // beforeDestroy() {
  //   this.$store.commit('increment')
  // },
}
</script>
<style scoped>
  /* .v-application a {
    color: white;
  } */
</style>