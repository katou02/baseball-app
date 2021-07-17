<template>
  <div class="main-content">
    <div class="main-content-btn">
      <div v-if="current_user">
        <!-- <router-link :to="{name: 'tweet-new'}" class="send-btn text-white">投稿する</router-link> -->
        <button class="send-btn text-white" @click="openModal">投稿する</button>
      </div>
      <router-link :to="{name: 'top'}" class="return-top text-white">トップページ</router-link>
    </div>
    <div class="text-format mt-5 text-warning">
      観た試合の感想をみんなに発信してみましょう！
    </div>
    <div class="article-main">
      <div class="text-format pt-5 text-primary">
        みんなの試合記事
      </div>
      <div class="search-area mt-3 mb-5">
        <v-text-field type="text" v-model="keyword" label="検索"></v-text-field>
      </div>
      <!-- 記事 -->
      <Img></Img>
      <div class="d-md-flex list mt-5">
        <Side></Side>
        <v-row class="ml-5">
          <v-col cols="12"  sm="12" md="12" lg="6" v-for="e in getLists" :key="e.id">
            <div class="article mt-5">
              <router-link :to="{name: 'tweet-show',params: {id: e.id}}">
                <div class="d-flex h-100">
                  <div v-if="e.image.url"><img :src="e.image.url" class="article-icon"></div>
                  <div v-else><img src="/images/ball.jpg" class="article-icon"></div>
                  <div class="article-heading mx-auto">
                    <div class="article-round">
                      <v-chip color="light-green" text-color="white">{{e.round}}</v-chip>
                    </div>
                    <div class="article-title">
                      {{e.school_a}}vs{{e.school_b}}
                    </div>
                    <div v-if="e.title.length<=15" class="sub-title">
                      {{e.title}}
                    </div>
                    <div v-else class="sub-title">{{e.title.slice(0,15) + '...'}}</div>
                    <div class="name">
                      投稿者:{{e.nickname}}
                      <span v-if="e.user_image.url"><img :src= e.user_image.url class="user-icon2"></span>
                      <span v-else><img src="../assets/images/no-image.png" class="user-icon2"></span>
                      投稿日:{{e.time}}
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
      <modal name="select" height="auto" width="65%" :scrollable="true">
        <div id="modal">
          <New @parent-event="fetchTweets"></New>
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
import axios from 'axios';
import Header from './components/Header.vue'
import Side from './components/Side.vue'
import New from './components/TweetNew.vue'
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
      keyword: this.$store.state.keyword,
      tweets: [],
      categories: [],
      current_user: '',
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
      this.closeModal()
      axios
        .get('api/v1/tweets.json')
        .then(response =>{
          this.tweets = response.data.tweets;
          this.current_user = response.data.current_user
          if(!response.data.current_user && this.$store.state.signedIn == true) {
            delete localStorage.csrf
            delete localStorage.signedIn
            this.$router.go('/tweets')
          }
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
    },
    openModal(){
      this.$modal.show('select');
    },
    closeModal(){
      this.$modal.hide('select');
    },
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
  }
}
</script>