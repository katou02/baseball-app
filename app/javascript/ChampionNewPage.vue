<template>
  <div class="contents w-50 mx-auto">
    <form @submit.prevent="createChampion">
      <v-card>
        <v-card-title><h3>優勝予想に投票！</h3></v-card-title>
        <div class="form mx-auto p-4">
          <!-- <select v-model="selected">
            <option disabled value="">優勝予想を選択</option>
            <option v-for="school in schools" :value="school.id" :key="school.id">
              {{ school.name }}
            </option>
          </select> -->
          <v-select
            v-model="selected"
            item-text="name"
            item-value="id"
            label="優勝予想"
            :items="schools"
            outlined>
          </v-select>
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
      selected: ''
    }
  },
  mounted() {
    this.fetchSchools()
  },
  methods: {
    fetchSchools() {
      axios
        .get(`/api/v1/champions/${this.$route.query.tournament_id}.json`)
        .then(response => {
          this.schools = response.data.select_schools
        })
    },
    createChampion() {
      axios
        .post('/api/v1/champions',{champion_school_id: this.selected,tournament_id: this.$route.query.tournament_id})
        .then(response => {
          this.$router.push({ name: 'champion', params: { id: this.$route.query.tournament_id } });
        })
    }
  }
}
</script>