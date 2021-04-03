<template>
  <div class="contents row">
  </div>
</template>
<script>
import axios from 'axios'
export default {
  data() {
    return {
      schools: []
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
          alert('tt')
          this.schools = response.data.select_schools
        })
    }
  }
}
</script>