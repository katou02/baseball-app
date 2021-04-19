<template>
  <div class="map">
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
      <div id="map">
        <GmapMap
        :center="{lat: map.latitude, lng:map.longitude}"
        :zoom="15"
        map-type-id="terrain"
        style="width: 100%; height: 350px"
        >
        <GmapMarker
        :key="index"
        v-for="(m, index) in markers"
        :position="m.position"
        :clickable="true"
        :draggable="true"
        @click="center=m.position"
        />
        </GmapMap>
      </div>
    </div>
  </div>
</template>
<script>
import axios from 'axios'
export default {
  data() {
    return {
      map: [],
      markers: []
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
          this.markers.push({position: { lat:this.map.latitude, lng:this.map.longitude } })
        })
    }
  }
}
</script>