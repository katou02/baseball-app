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
    </div>
  </div>
</template>
<script>
import axios from 'axios'
export default {
  data() {
    return {
      forecast: []
    }
  },
  mounted() {
    this.fetchForecasts()
  },
  methods: {
    fetchForecasts() {
      axios
        .get(`/api/v1/forecasts/${this.$route.params.id}.json`)
        .then(response =>{
          this.forecast = response.data
        })
    }
  }
}
</script>