<template>
  <div class="contents row mx-auto mt-5">
    <h3>ふるさとを紹介</h3>
    <form @submit.prevent="createMap">
      <v-select
        v-model="school"
        item-text="name"
        item-value="id"
        :items="schools"
        label="学校を選択"
        outlined>
      </v-select>
      <v-text-field v-model="address" type="text" label="市町村 住所など" class="game_title text-center"></v-text-field>
      <v-textarea v-model="text" type="text" label="紹介" outlined></v-textarea>
      <input v-if="!url" type="file" label="画像" @change="setImage" ref="preview" accept="image/png, image/jpeg, image/bmp">
      <div v-if="url">
        <img :src="url" width="320px" height="300px">
        <button type="submit" @click="deleteImage">削除</button>
      </div>
      <v-btn type="submit" color="info">投稿</v-btn>
    </form>
  </div>
</template>
<script>
import axios from 'axios';
export default {
  data() {
    return {
      address: '',
      text: '',
      schools: [],
      school: '',
      image: '',
      url: '',
      selected: ''
    }
  },
  mounted() {
    this.fetchSchools()
  },
  methods: {
    fetchSchools() {
      axios
      .get(`/api/v1/maps/new?tournament_id=${this.$route.query.tournament_id}`)
      .then(response => {
        this.schools = response.data.school
      })
    },
    setImage(e){
      e.preventDefault();
      this.image = e.target.files[0];
      const file = this.$refs.preview.files[0];
      this.url = URL.createObjectURL(file)
      this.$refs.preview.value = "";
    },
    deleteImage(){
      this.url = '';
      URL.revokeObjectURL(this.url);
      this.image = ''
    },
    createMap() {
      let formData = new FormData();
      formData.append("address", this.address);
      formData.append("text", this.text);
      formData.append("school_id", this.school);
      formData.append("tournament_id", this.$route.query.tournament_id);
      const config = {
        headers: {"content-type": "multipart/form-data",}
      };
      if (this.image !== null) {
        formData.append("image", this.image);
      }
      axios
        .post('/api/v1/maps',formData,config)
        .then(response =>{
          this.$router.push({ name: 'map',query: {tournament_id: this.$route.query.tournament_id}});
        })
    }
  }
}
</script>