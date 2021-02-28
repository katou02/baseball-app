<template>
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
            <a :href= "'/tweets/' + e.id">
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
            </a>
          </div>
        </div>
      </div>
      <div v-else>
        <p class="text-center mt-5">試合記事はありません</p>
      </div>
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
import axios from 'axios'
export default {
  data() {
    return {
      keyword: '',
      tweets: [],
      currentPage: 1,
      parPage: 10,
    }
  },
  mounted() {
    this.fetchTweets()
  },
  methods: {
    fetchTweets() {
      axios
        .get(`/api/v1/tournaments/${this.$route.params.id}.json`)
        .then(response =>{
          this.tweets = response.data;
        })
    },
    clickCallback: function (pageNum) {
       this.currentPage = Number(pageNum);
    },
  },
  computed: {
    getTweets: function() {
      var tweets = [];
      for(var i in this.tweets) {
        var tweet = this.tweets[i];
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