<template>
  <div class="map">
    <div class="d-flex mt-1">
      <div v-if="map.user_id==map.current_user">
        <button class="delete-btn p-0" @click="onAlert()">記事を削除する</button>
        <router-link :to="{name: 'map-edit',params: {id: $route.params.id}}" class="edit-article text-white">編集する</router-link>
      </div>
    </div>
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
      image: [],
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
    },
    deleteMap(id) {
      axios.delete(`/api/v1/maps/${id}`).then(response => {
        this.$router.push({ name: 'map',query: {tournament_id: this.map.tournament} });
      })
    },
    onAlert:function(){
      this.$dialog
      var rt =confirm(
      '削除してもよろしいですか？'
      )
      if(rt==true) {
        this.deleteMap(this.$route.params.id)
      }
    },
  }
}
</script>