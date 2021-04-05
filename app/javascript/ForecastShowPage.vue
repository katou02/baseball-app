<template>
  <div class="game-article">
    <div class="data-info">
      <div class="d-flex">
        <div v-if="forecast.user_id==forecast.current_user">
          <button class="delete-btn" @click="deleteForecast(forecast.id)">記事を削除する</button>
          <!-- <a :href= "'/forecasts/' + forecast.id + '/edit'" class="edit-article">記事を編集する</a> -->
          <router-link :to="{name: 'forecast-edit',params: {id: forecast.id}}" class="edit-article">記事を編集する</router-link>
        </div>
        <!-- <a :href= "'/tweets'" class="return-btn">記事一覧へ戻る</a> -->
        <router-link :to="{name: 'forecast'}" class="return-btn">記事一覧へ戻る</router-link>
      </div>
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
      <div class="pie mt-5 pb-5">
        <div style="width:60%; height:60%"><canvas id="PieChart"></canvas></div>
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
      errors: "",
      chart_data: '',
      labels: [],
      probability: ''
    }
  },
  mounted() {
    this.fetchForecasts()
    this.fetchComments()
    this.fetchchart()
  },
  methods: {
    fetchForecasts() {
      axios
        .get(`/api/v1/forecasts/${this.$route.params.id}.json`)
        .then(response =>{
          this.forecast = response.data
        })
    },
    deleteForecast(id) {
      axios.delete(`/api/v1/forecasts/${id}`).then(response => {
        this.$router.push({ name: 'forecast' });
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
    deleteComment(id) {
      axios.delete(`/api/v1/forecasts/${id}/comment_forecasts/${id}`).then(response => {
        this.fetchComments();
      })
    },
    fetchchart() {
      axios
        .get(`/api/v1/forecasts/${this.$route.params.id}.json`)
        .then(response =>{
          this.chart_data = response.data.probability
          this.labels = [response.data.win_school,response.data.lose_school]
          this.probability = response.data.probability
          this.chart();
        })
    },
    chart() {
      var ctx = document.getElementById("PieChart");
      var PieChart = new Chart(ctx, {
        type: 'pie',
        data: {
          labels: this.labels,
          datasets: [{
            backgroundColor: [
              "#FF0000",
              "#33CCFF",
            ],
            data: [this.probability,100-this.probability]
          }]
        },
        options: {
          title: {
            display: true,
            text: '勝利確率'
          }
        }
      });
    }
  }
}
</script>