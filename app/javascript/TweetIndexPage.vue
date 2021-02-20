<template>
  <div class="app">
    <v-pagination v-model="currentPage" :length="totalPages" @input="fetchTweets"/>
    <div v-for="e in tweets" :key="e.id">
      <div class="article mt-5">
        <router-link @click.native="reset" :to="`tweets/${e.id}`">
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
        <p ref="hoge">
          {{e.total_pages}}
        </p>
      </div>
    </div>
  </div>
</template>
<script>
import axios from 'axios';

export default {
  data() {
    return {
      tweets: [],
      currentPage: 1,
      tweetsPerPage: 5,
      totalPages: null,
      current_slide: 0,
    }
  },
  mounted() {
    this.fetchTweets()
  },
  methods: {
    reset: function () {
    this.$router.go({path: this.$router.currentRoute.path, force: true})
    },
    fetchTweets() {
      const url = `/api/v1/tweets?page=${this.currentPage}?per=${this.tweetsPerPage}`;
      axios
        .get(url)
        .then(response =>{
        this.tweets = response.data;
        this.totalPages = response.data[0].total_page;
        })
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

</style>