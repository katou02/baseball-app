<template>
  <div class="contents row">
    <div class="form p-4">
      <select v-model="selected">
        <option v-for="school in schools" :value="school.name" :key="school.id">
          {{ school.name }}
        </option>
      </select>
    </div>
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
          this.selected = response.data.select_schools[0].name
        })
    }
  }
}
</script>