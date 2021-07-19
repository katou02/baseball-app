<template>
  <div class="contents row mx-auto mt-5">
    <h2 class="text-primary font-weight-bold">ふるさとを紹介</h2>
    <v-divider></v-divider><br>
    <h4>{{tournament}}</h4>
    <form @submit.prevent="createMap">
      <v-select
        v-model="school"
        item-text="name"
        item-value="id"
        :items="schools"
        label="高校を選択"
        outlined>
      </v-select>
      <p v-if="!!errors['school']" style="color: red;">{{ errors['school'][0]}}</p>
      <v-text-field v-model="address" type="text" label="市町村 住所など" class="game_title text-center"></v-text-field>
      <p v-if="!!errors['address']" style="color: red;">{{ errors['address'][0]}}</p>
      <p v-if="!!errors['latitude']" style="color: red;">{{ errors['latitude'][0]}}</p>
      <v-textarea v-model="text" type="text" label="紹介" outlined></v-textarea>
      <p v-if="!!errors['text']" style="color: red;">{{ errors['text'][0]}}</p>
      <!-- <input v-if="!url" type="file" label="画像" @change="setImage" ref="preview" accept="image/png, image/jpeg, image/bmp"> -->
      <label v-if="!url" class="photo w-25">
        ＋写真を選択
        <input type="file" style="display:none;"  @change="setImage" ref="preview" accept="image/png, image/jpeg, image/bmp">
      </label>
      <div v-if="url">
        <img :src="url" class="w-100" width="320px" height="300px">
        <v-btn color="error" type="submit" @click="deleteImage" small>削除</v-btn>
      </div>
      <v-btn type="submit" color="info" class="mt-5 mb-5">投稿する</v-btn>
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
      tournament: '',
      url: '',
      errors: '',
      selected: ''
    }
  },
  mounted() {
    this.fetchSchools()
  },
  created() {
    if(!localStorage.signedIn) {
      this.$router.push({ name: 'map',query: {tournament_id: this.$route.query.tournament_id}});
    }
  },
  methods: {
    fetchSchools() {
      axios
      .get(`/api/v1/maps/new?tournament_id=${this.$route.query.tournament_id}`)
      .then(response => {
        this.schools = response.data.school
        this.tournament = response.data.tournament
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
          this.$emit('parent-event')
        //   this.$router.push({ name: 'map',query: {tournament_id: this.$route.query.tournament_id}});
        })
        .catch(error => {
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
        });
    }
  }
}
</script>