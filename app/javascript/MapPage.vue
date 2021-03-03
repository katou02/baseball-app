<template>
  <div class="map-contenta">
    <div class="map-list row">
      <div v-for="e in maps" :key="e.id" class="col-xs-12 col-md-6 col-lg-3 mt-3 mb-5 map-card">
        <a :href = "'maps/' + e.id" class="user-card">
          <div class="map-name bg-white pt-2">
            {{e.school_name}}
          </div>
          <div class="map-user pt-5">
            {{e.nickname}}
          </div>
          <div class="map-user_image">
            <div v-if="e.image.url">
              <img :src= e.image.url class="map-user_icon mt-3">
            </div>
            <div v-else>
              <img src="../assets/images/no-image.png" class="map-user_icon mt-3">
            </div>
          </div>
        </a>
      </div>
    </div>
  </div>
</template>
<script>
import axios from 'axios'
export default {
  data() {
    return {
      maps: []
    }
  },
  mounted() {
    this.fetchMaps()
  },
  methods: {
    fetchMaps() {
      axios
        .get(`api/v1/maps.json?tournament_id=${this.$route.query.tournament_id}`)
        .then(response =>{
          this.maps = response.data;
        })
    }
  }
}
</script>