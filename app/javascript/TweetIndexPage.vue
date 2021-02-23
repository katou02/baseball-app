<template>
  <div class="article-main">
    <div class="text-format mt-5 text-primary">
      観た試合の感想をみんなに発信してみましょう！
    </div>
    <input type="text" v-model="keyword">
    <div v-for="e in getLists" :key="e.id">
      <div class="article mt-5">
        <a :href= "'tweets/' + e.id">
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
    <!-- <v-pagination v-model="currentPage" :length="totalPages" @input="fetchTweets" /> -->
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
import axios from 'axios';

export default {
  data() {
    return {
      keyword: '',
      tweets: [],
      currentPage: 1,
      parPage: 5,
      // totalPages: null,
      current_slide: 0,
    }
  },
  mounted() {
    this.fetchTweets()
  },
  methods: {
    fetchTweets() {
      // const url = `/api/v1/tweets?page=${this.currentPage}?per=${this.tweetsPerPage}`;
      axios
        // .get(url)
        .get('api/v1/tweets.json')
        .then(response =>{
        this.tweets = response.data;
        // this.totalPages = response.data[0].total_page;
        })
    },
    clickCallback: function (pageNum) {
       this.currentPage = Number(pageNum);
    }
  },
  computed: {
    // filteredTweets() {
    //     var tweets = [];
    //     for(var i in this.tweets) {
    //         var tweet = this.tweets[i];
    //         if( tweet.text.indexOf(this.keyword) !== -1 ||
    //             tweet.school_a.indexOf(this.keyword) !== -1 ||
    //             tweet.school_b.indexOf(this.keyword) !== -1 ||
    //             tweet.title.indexOf(this.keyword) !== -1) {
    //             tweets.push(tweet);
    //         }
    //     }
    //     return tweets;
    // }
     getTweets: function() {
       let self = this;
       return this.tweets.filter(function(tweet){
         return String(tweet.school_a).indexOf(self.keyword) !== -1;
       });
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

.article {
  width: 800px;
  max-width: 100%;
  margin: 0 auto;
  background-color: #68ccf9;
  text-align: center;
  border: solid 1px rgb(255, 255, 255);
  height: auto;
}

.article-title {
  font-size: 25px;
  color: white;
  font-weight: bold;
}

.article-image {
  position: absolute;
  width: 10%;
}

.sub-title {
  padding-top: 20px;
  font-size: 18px;
}

.article-main{
  background-image: url("/images/sky.jpg");
   background-size: cover;
   background-color:rgba(255,255,255,0.8);
   background-blend-mode:lighten;
   flex: 1 1 100%;
}
</style>