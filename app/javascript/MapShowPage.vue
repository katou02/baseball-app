<template>
  <div class="map-info">
    <div class="map-school">
      {{map.school}}
    </div>
    <div class="map-text">
      <p class="text-center pt-1">{{map.address}}</p>
      <div class="mt-4 mb-4" style="white-space:pre-wrap;">
        {{map.text}}
      </div>
    </div>
    <div class="map-image">
      <div v-if="map.image.url">
        <img :src= map.image.url class="map-image_content">
      </div>
      <div v-else>
        <img src="../assets/images/map-no-image.png" class="map-image_content">
      </div>
    </div>
    <div ref="map"></div>
  </div>
</template>
<script>
import axios from 'axios'
export default {
  data() {
    return {
      map: []
    }
  },
  mounted() {
    this.fetchMap()
  },
  methods: {
    fetchMap() {
      axios
        .get(`/api/v1/maps/${this.$route.params.id}.json`)
        .then(response =>{
          this.map = response.data;
        })
    }
  }
}
</script>