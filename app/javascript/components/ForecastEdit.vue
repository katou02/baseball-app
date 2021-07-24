<template>
  <div class="contents row mx-auto mt-2">
    <h2 class="text-primary font-weight-bold">試合予想の編集</h2>
    <v-divider></v-divider>
    <form @submit.prevent="editForecast">
      {{tournament}}
      <div class="form p-4">
        <div class="select-school-fcs-edit">
          <div class="select-fcs-school-edit w-25 mx-auto mt-3">
            <label>勝利予想</label><br>
            <v-select
            v-model="win_school"
            item-text="name"
            item-value="id"
            :items="children"
            outlined>
            </v-select>
          </div>
          <div class="select-fcs-school-edit w-25 mx-auto mt-3">
            <label>敗退予想</label><br>
            <v-select
            v-model="lose_school"
            item-text="name"
            item-value="id"
            :items="children"
            outlined>
            </v-select>
          </div>
        </div>
        <div class="round w-25 mx-auto mt-3">
          <label>ラウンド</label><br>
          <v-select
          v-model="round"
          item-text="round"
          item-value="round"
          :items="round_list"
          outlined>
          </v-select>
        </div>
        <div class="win-rate mx-auto mt-3">
          <label>勝利予想チームの勝利確率</label><br>
          <v-select
          v-model="probability"
          item-text="label"
          item-value="probability"
          :items="probability_list"
          outlined>
          </v-select>
        </div>
      </div>
      <v-textarea v-model="text" type="text" rows="2" cols="30" label="本文" outlined></v-textarea>
      <p v-if="!!errors['text']" style="color: red;">{{ errors['text'][0]}}</p>
      <v-btn type="submit" color="info" class="text-white mt-5 mb-5">編集する</v-btn>
    </form>
  </div>
</template>
<script>
import axios from 'axios';
export default {
  data: function() {
    return {
      tournament: '',
      children: [],
      grandChildren: [],
      current_user: '',
      root_id: '',
      child_id: '',
      user_id: '',
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
        this.children = response.data.schools;
        this.current_user = response.data.current_user.id
        this.user_id = response.data.user_id
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
  beforeUpdate() {
    if(!this.current_user || this.current_user!==this.user_id) {
      this.$router.push({ name: 'forecast-show'});
    }
  },
  methods: {
    editForecast() {
      axios
        .patch(`/api/v1/forecasts/${this.$route.params.id}`,{text: this.text,win_school_id: this.win_school,lose_school_id: this.lose_school,probability: this.probability,round: this.round})
        .then(response => {
          PieChart.destroy()
          this.$emit('parent-event')
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