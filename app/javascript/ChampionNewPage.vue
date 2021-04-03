<template>
  <div class="contents row">
   <form @submit.prevent="createChampion">
    <div class="form p-4">
      <select v-model="selected">
        <option disabled value="">優勝予想を選択</option>
        <option v-for="school in schools" :value="school.id" :key="school.id">
          {{ school.name }}
        </option>
      </select>
      <button type="submit">投票</button>
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