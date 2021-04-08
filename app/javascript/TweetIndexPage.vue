<template>
  <div class="main-content">
    <Header></Header>
    <!--<div id="slide">
      <div class="header">
        <transition name="fade">
        <div class="slider-inner" :key="idx" v-for="(slide, idx) in slides" v-if="current_slide == idx">
          <img class="slide-img" v-bind:src="slides[idx].img" :key="slides[idx].img">
        </div>
        </transition>
      </div>
    </div>-->
    <div class="main-content-btn">
      <a :href= "'/tweets/new'" class="send-btn">投稿する</a>
      <a :href= "'/'" class="return-top">トップページへ戻る</a>
    </div>
    <div class="text-format mt-5 text-primary">
      観た試合の感想をみんなに発信してみましょう！
    </div>
    <div class="text-format mt-5 mb-4 text-warning">
      大会別
    </div>
    <div class="title mt-5">
      <div v-for="e in categories" :key="e.id">
        <router-link :to="{name: 'tournament',params: {id: e.id}}"  class="title-child text-white ml-5">
          <i class="fa fa-baseball-ball text-white"></i> 
          {{e.category}}
        </router-link>
      </div>
    </div>
    <div class="article-main">
      <div class="text-format pt-5 text-primary">
        みんなの試合記事
      </div>
      <div class="search-area mt-3">
        <input type="text" v-model="keyword" placeholder="検索">
      </div>
      <div v-for="e in getLists" :key="e.id">
        <div class="article mt-5">
          <router-link :to="{name: 'tweetshow',params: {id: e.id}}">
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

export default {
  components: {
    Header
  },
  data() {
    return {
      keyword: this.$store.state.keyword,
      tweets: [],
      categories: [],
      currentPage: this.$store.state.currentPage,
      parPage: 10,
      // current_slide: 0,
      // slides: [
      //   {img: "/images/81573810.jpeg"},
      //   {img: "/images/ball.jpg"},
      //   {img: "/images/thumb_ground.jpg"},
      //   {img: "/images/thumb_front.jpg"},
      //   {img: "/images/mykosien.JPG"}
      // ],
    }
  },
  mounted() {
    // setInterval(() => {
    //     this.current_slide = this.current_slide < this.slides.length -1 ? this.current_slide +1 : 0
    //   }, 3000)
    this.fetchTweets()
    this.fetchCategory()
    if (this.keyword == '') {
    }
    else {
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
  beforeDestroy() {
    this.$store.commit('increment')
  },
}
</script>