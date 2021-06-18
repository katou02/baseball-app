<template>
  <div class="contents w-50 mx-auto">
    <form @submit.prevent="createChampion">
      <v-card>
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
      </v-card>
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
      current_user: '',
      my_champion: '',
      error: ''
    }
  },
  mounted() {
    this.fetchSchools()
  },
  beforeUpdate() {
    if(this.current_user===null) {
      this.$router.push({ name: 'champion', params: { id: this.$route.query.tournament_id } })
    }
  },
  methods: {
    fetchSchools() {
      axios
        .get(`/api/v1/champions/${this.$route.query.tournament_id}.json`)
        .then(response => {
          this.schools = response.data.select_schools
          this.current_user = response.data.current_user
          this.my_champion = response.data.my_champion
          if(response.data.my_champion || !response.data.current_user) {
            this.$router.push({ name: 'top'});
          }
        })
    },
    createChampion() {
      axios
        .post('/api/v1/champions',{champion_school_id: this.selected,tournament_id: this.$route.query.tournament_id})
        .then(response => {
          this.$router.push({ name: 'champion', params: { id: this.$route.query.tournament_id } });
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