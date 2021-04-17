<template>
  <div class="contents row mt-2">
    <router-link :to="{name: 'forecast'}" class="return-btn">戻る</router-link>
    <h2>試合記事の投稿</h2>
    <form @submit.prevent="editForecast">
      <div class="form p-4">
        <div class="win-school mt-3">
          <ul>
            <label>勝利予想</label><br>
            <select v-model="win_school">
              <option v-for="child in children" :value="child.id" :key="child.id">{{ child.name }}</option>
            </select>
          </ul>
        </div>
        <div class="lose-school mt-3">
          <ul>
            <label>敗退予想</label><br>
            <select v-model="lose_school">
              <option v-for="child in children" :value="child.id" :key="child.id">{{ child.name }}</option>
            </select>
          </ul>
        </div>
        <div class="round mt-3">
          <label>ラウンド</label><br>
          <select v-model="round">
            <option v-for="round in round_list" :value="round.round" :key="round.id">{{ round.round }}</option>
          </select>
        </div>
        <div class="win-rate mt-3">
          <label>勝利予想チームの勝利確率</label><br>
          <select v-model="probability">
            <option v-for="probability in probability_list" :value="probability.probability" :key="probability.id">{{ probability.label }}</option>
          </select>
        </div>
      </div>
      <textarea v-model="text" type="text" rows="2" cols="30" placeholder="本文"></textarea>
      <p v-if="!!errors['text']" class="error" style="color: red;">{{ errors['text'][0]}}</p>
      <button type="submit" class="game_record" >投稿する</button>
    </form>
  </div>
</template>
<script>
import axios from 'axios';
export default {
  data: function() {
    return {
      tournament: '',
      // roots: [],
      children: [],
      grandChildren: [],
      root_id: '',
      child_id: '',
      win_school: '',
      lose_school: '',
      text: '',
      title: '',
      round: '',
      errors: '',
      round_list: [
        {round: '1回戦'},
        {round: '2回戦'},
        {round: '3回戦'},
        {round: '準々決勝'},
        {round: '準決勝'},
        {round: '決勝'}
      ],
      probability: '',
      probability_list: [
        {probability: 60,label: '60%'},
        {probability: 70,label: '70%'},
        {probability: 80,label: '80%'},
        {probability: 90,label: '90%'},
        {probability: 100,label: '100%'},
      ]
    }
  },
  mounted() {
    axios
      .get(`/api/v1/forecasts/${this.$route.params.id}/edit.json`)
      .then(response =>{
        this.children = response.data;
      })
    axios
      .get(`/api/v1/forecasts/${this.$route.params.id}.json`)
      .then(response =>{
        this.win_school = response.data.win_school_id
        this.lose_school = response.data.lose_school_id
        this.text = response.data.text
        this.tournament = response.data.tournament
        this.probability = response.data.probability
        this.round = response.data.round
      })
  },
  methods: {
    editForecast() {
      axios
        .patch(`/api/v1/forecasts/${this.$route.params.id}`,{text: this.text,win_school_id: this.win_school,lose_school_id: this.lose_school,probability: this.probability,round: this.round})
        .then(response => {
          this.$router.push({ name: 'forecast-show',params: {id: this.$route.params.id}});
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