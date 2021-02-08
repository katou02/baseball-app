<template>
  <div id="app">
    <div v-for="e in tweets" :key="e.id">
      <div class="article mt-5">
        <router-link :to="`tweets/${e.id}`">
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
</template>
<script>
import axios from 'axios';

export default {
  data: function() {
    return {
      tweets: []
    }
  },
  mounted() {
    axios
    .get('/api/v1/tweets.json')
    .then(response => (this.tweets = response.data))
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