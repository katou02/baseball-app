<template>
  <div class="game-article">
    <div class="data-info">
      <div class="user_name">
        <h5>投稿者:<a :href= "'/users/' + forecast.user_id">{{forecast.nickname}}</a></h5>
        <div v-if="forecast.user_image.url"> 
          <img :src= forecast.user_image.url class="user-icon mt-1 mb-5">
        </div>
        <div v-else>
          <img src="../assets/images/no-image.png" class="user-icon mt-1 mb-5">
        </div>
      </div>
      <div class="text-format text-danger">
        {{forecast.tournament}}<br>
        <i class="fas fa-fire mt-5 mb-5">試合予想</i>
      </div>
      <div class="data-title mt-5 ml-5">
        勝敗予想
      </div>
      <div class="text-format mt-5">{{forecast.round}}</div>
      <div class="school-fcs">
        <div class="win-school text-danger">
          <p>勝利予想<p>
          <br>
          <div class="win">{{forecast.win_school}}</div>
        </div>
        <div class="lose-school text-info">
          <p>敗退予想<p>
          <br>
          <div class="lose">{{forecast.lose_school}}</div>
        </div>
      </div>
      <div class="data-title mt-5 ml-5">
        考察
      </div>
      <div class="fcs-text ml-5 mt-5">
        <p style="white-space:pre-wrap;">{{forecast.text}}</p>
      </div>
      <div class="data-title mt-5 ml-5">
        勝利確率
      </div>
      <div class="comment-content_tweet">
        <div class="text-format mt-0 mb-4 text-warning">
          <i class="fa fa-baseball-ball text-warning"></i>
          コメント
        </div>
        <div v-for="e in comment" :key="e.id">
          <div class="comment-user text-center">
            <em class="pr-4">{{e.comment_nickname}}</em>
            {{e.time}}
            <button class="comment-delete_button" @click="deleteComment(e.id)">削除</button><br>
          </div>
          <div class="mt-4 mb-4 text-center" style="white-space:pre-wrap;">{{e.comment}}</div>
        </div>
        <div class="comment-form">
          <form @submit.prevent="createComment">
          <div  v-if="errors.length != 0">
            <ul v-for="e in errors" :key="e">
              <li><font color="red">{{ e }}</font></li>
            </ul>
          </div>
          <div class="tweet-comment_form">
            <textarea v-model="text" type="text" rows="2" cols="30"></textarea>
          </div>
          <button type="submit" class="game_record" >投稿する</button>
          </form>
        </div>
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
      forecast: [],
      comment: "",
      text: "",
      errors: ""
    }
  },
  mounted() {
    this.fetchForecasts()
    this.fetchComments()
  },
  methods: {
    fetchForecasts() {
      axios
        .get(`/api/v1/forecasts/${this.$route.params.id}.json`)
        .then(response =>{
          this.forecast = response.data
        })
    },
    fetchComments() {
      axios
        .get(`/api/v1/forecasts/${this.$route.params.id}/comment_forecasts`)
        .then(response => {
          this.comment = response.data
        })
    },
    createComment: function() {
      axios
        .post(`/api/v1/forecasts/${this.$route.params.id}/comment_forecasts`,{text: this.text})
        .then(response => {
          this.text = "";
          this.fetchComments()
        })
        .catch(error => {
          console.error(error);
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
        });
    },
  }
}
</script>