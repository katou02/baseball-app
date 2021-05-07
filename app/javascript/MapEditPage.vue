<template>
  <div class="contents row mx-auto mt-5">
    <h3>ふるさとを紹介</h3>
    <h3>{{name}}</h3>
    <form @submit.prevent="editMap">
      <v-text-field v-model="address" type="text" label="市町村 住所など" class="game_title text-center"></v-text-field>
      <p v-if="!!errors['address']" style="color: red;">{{ errors['address'][0]}}</p>
      <v-textarea v-model="text" type="text" label="紹介" outlined></v-textarea>
      <p v-if="!!errors['text']" style="color: red;">{{ errors['text'][0]}}</p>
      <input v-if="!url && !image.url" type="file" label="画像" @change="setImage" ref="preview" accept="image/png, image/jpeg, image/bmp">
      <div v-if="url">
        <img :src="url" width="320px" height="300px">
        <button type="submit" @click="deleteImage">削除</button>
      </div>
      <div v-if="image.url">
        <img :src="image.url" width="320px" height="300px">
        <button type="submit" @click="deleteMapImage">削除</button>
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
      school: '',
      image: '',
      url: '',
      tournament: '',
      name: '',
      selected: '',
      errors: ''
    }
  },
  mounted() {
    this.fetchSchools()
  },
  methods: {
    editMap() {
      let formData = new FormData();
      formData.append("address", this.address);
      formData.append("text", this.text);
      formData.append("school_id",this.school);
      formData.append("tournament_id",this.tournament);
      const config = {
        headers: {"content-type": "multipart/form-data",}
      };
      if (this.image !== null) {
        formData.append("image", this.image);
      }
      axios
        .patch(`/api/v1/maps/${this.$route.params.id}`,formData,config)
        .then(response => {
          this.$router.push({ name: 'map-show',params: {id: this.$route.params.id}});
        })
        .catch(error => {
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
          console.log(this.errors)
        });
    },
    fetchSchools() {
      axios
      .get(`/api/v1/maps/${this.$route.params.id}.json`)
      .then(response =>{
        this.school = response.data.school_id
        this.address = response.data.address
        this.text = response.data.text
        this.image = response.data.image
        this.name = response.data.school
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
    deleteMapImage(){
      this.image = ''
    }
  }
}
</script>
