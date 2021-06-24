<template>
  <div class="contents w-100 mx-auto">
    <form @submit.prevent="createChampion">
      <v-card-title><h3>優勝すると思うチームに投票！</h3></v-card-title>
      <div class="form mx-auto p-4">
        <v-select
          v-model="selected"
          item-text="name"
          item-value="id"
          label="優勝予想"
          :items="schools"
          outlined>
        </v-select>
        <p v-if="!!error['champion_school']" style="color: red;">{{ error['champion_school'][0]}}</p>
        <v-btn color="warning" dark type="submit">投票</v-btn>
      </div>
    </form>
  </div>
</template>
<script>
import axios from 'axios'
export default {
  data() {
    return {
      schools: [],
      selected: '',
      my_champion: '',
      error: ''
    }
  },
  mounted() {
    this.fetchSchools()
  },
//   created() {
//     if(!localStorage.signedIn) {
//       this.$router.push({ name: 'champion', params: { id: this.$route.params.id}})
//     }
//   },
  methods: {
    fetchSchools() {
      axios
        .get(`/api/v1/champions/${this.$route.params.id}.json`)
        .then(response => {
          this.schools = response.data.select_schools
          this.my_champion = response.data.my_champion
          if(response.data.my_champion || !response.data.current_user) {
            this.$router.push({ name: 'top'});
          }
        })
    },
    createChampion() {
      axios
        .post('/api/v1/champions',{champion_school_id: this.selected,tournament_id: this.$route.params.id})
        .then(response => {
          myBarChart.destroy()
          this.$emit('parent-event')
        })
        .catch(error => {
          if (error.response.data && error.response.data.errors) {
            this.error = error.response.data.errors;
          }
        });
    }
  }
}
</script>