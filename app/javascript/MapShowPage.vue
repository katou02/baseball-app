<template>
  <div class="map">
    <div class="map-info">
      <div class="map-school">
        {{map.school}}のふるさと
      </div>
      <div class="map-adress">
        <p class="text-center pt-1">{{map.address}}</p>
        <div id="map">
          <GmapMap
          :center="{lat: map.latitude, lng:map.longitude}"
          :zoom="15"
          map-type-id="terrain"
          style="width: 100%; height: 300px"
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
      <div class="map-text">
        <div class="mt-4 mb-4 w-100" style="white-space:pre-wrap;">
          {{map.text}}
        </div>
        <div class="map-image">
          <div class="h-100" v-if="image">
            <img :src= image class="map-image_content">
          </div>
          <div class="h-100" v-else>
            <img src="../assets/images/map-no-image.png" class="map-image_content">
          </div>
        </div>
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
      markers: [],
      image: []
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
          this.image = response.data.image.url;
          this.markers.push({position: { lat:this.map.latitude, lng:this.map.longitude } })
        })
    }
  }
}
</script>