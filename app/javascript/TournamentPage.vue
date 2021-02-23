<template>
  <div class="aaa">
    <div class="search-area mt-3">
      <input type="text" v-model="keyword" placeholder="検索">
    </div>
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
    <paginate
      :v-model="currentPage" 
      :page-count="getPageCount"
      :click-handler="clickCallback"
      :page-range="3"
      :margin-pages="2"
      :prev-text="'＜'"
      :next-text="'＞'"
      :container-class="'pagination'"
      :page-class="'page-item'">
    </paginate>
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
      parPage: 5,
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