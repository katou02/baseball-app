<template>
  <div class="map">
    <div class="d-flex mt-1">
      <div v-if="map.user_id==current_user || map.admin==true">
        <v-dialog v-model="dialog" persistent max-width="290">
          <template v-slot:activator="{ on, attrs }">
            <button class="delete-btn text-white" v-bind="attrs" v-on="on">
              削除する
            </button>
          </template>
          <v-card>
            <v-card-title class="headline">本当に削除しますか?</v-card-title>
            <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn color="green darken-1" text @click="deleteMap($route.params.id)">はい</v-btn>
              <v-btn color="green darken-1" text @click="dialog = false">キャンセル</v-btn>
            </v-card-actions>
          </v-card>
        </v-dialog>
        <button class="edit text-white p-1" @click="openModal">編集する</button>
      </div>
      <router-link :to="{name: 'map',query: {tournament_id: map.tournament}}" class="return-btn text-white pt-1">戻る</router-link>
    </div>
    <div class="post-user-name">
      <div v-if="current_user"><h5>投稿者:<router-link :to="{name: 'user-show',params: {id: user}}">{{map.nickname}}</router-link></h5></div>
      <div v-else><h5>投稿者:未ログインにより非表示</h5></div>
      <div v-if="user_image"> 
        <img :src= user_image class="user-icon mt-1 mb-5">
      </div>
      <div v-else>
        <img src="../assets/images/no-image.png" class="user-icon mt-1 mb-5">
      </div>
    </div>
    <p class="text-right">{{map.time}}</p>
    <div class="map-school">
      {{map.school}}高校のふるさと
    </div>
    <div class="map-title ml-5 mb-5">
      {{map.address}}
    </div>
    <div class="map-adress">
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
    <div class="map-title ml-5 mb-5">
      ふるさと紹介
    </div>
    <div class="map-info">
      <div class="map-text">
        <p style="white-space:pre-wrap;" class="ml-5">{{map.text}}</p>
        <img :src= image class="mt-3">
      </div>
    </div>
    <modal name="select" height="auto" width="65%" :scrollable="true">
      <div id="modal">
        <Edit @parent-event="fetchMap"></Edit>
        <button @click="closeModal">閉じる</button>
      </div>
    </modal>
  </div>
</template>
<script>
import axios from 'axios'
import Edit from './components/MapEdit.vue'
export default {
  components: {
    Edit
  },
  data() {
    return {
      map: [],
      markers: [],
      image: [],
      user: '',
      current_user: '',
      user_image: '',
      dialog: false
    }
  },
  mounted() {
    this.fetchMap()
  },
  methods: {
    fetchMap() {
      this.closeModal()
      axios
        .get(`/api/v1/maps/${this.$route.params.id}.json`)
        .then(response =>{
          this.markers = []
          this.map = response.data
          this.image = response.data.image.url
          this.user = response.data.user_id
          this.current_user = response.data.current_user
          this.user_image = response.data.user_image.url
          this.markers.push({position: { lat:this.map.latitude, lng:this.map.longitude } })
          if(!response.data.current_user && this.$store.state.signedIn == true) {
            delete localStorage.csrf
            delete localStorage.signedIn
            this.$router.go(`/maps/${this.$route.params.id}`)
          }
        })
    },
    deleteMap(id) {
      axios.delete(`/api/v1/maps/${id}`).then(response => {
        this.$router.push({ name: 'map',query: {tournament_id: this.map.tournament} });
      })
    },
    openModal(){
      this.$modal.show('select');
    },
    closeModal(){
      this.$modal.hide('select');
    },
    // onAlert:function(){
    //   this.$dialog
    //   var rt =confirm(
    //   '削除してもよろしいですか？'
    //   )
    //   if(rt==true) {
    //     this.deleteMap(this.$route.params.id)
    //   }
    // },
  }
}
</script>