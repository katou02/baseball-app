<template>
  <div class="contents row mx-auto mt-5">
    <h2 class="text-primary font-weight-bold">ふるさとを紹介</h2>
    <v-divider></v-divider>
    <h3>{{name}}</h3>
    <form @submit.prevent="editMap">
      <v-text-field v-model="address" type="text" label="市町村 住所など" class="game_title text-center"></v-text-field>
      <p v-if="!!errors['address']" style="color: red;">{{ errors['address'][0]}}</p>
      <v-textarea v-model="text" type="text" label="紹介" outlined></v-textarea>
      <p v-if="!!errors['text']" style="color: red;">{{ errors['text'][0]}}</p>
      <label v-if="!url && !image.url" class="photo w-25">
        ＋写真を選択
        <input type="file" style="display:none;"  @change="setImage" ref="preview" accept="image/png, image/jpeg, image/bmp">
      </label>
      <div v-if="url">
        <img :src="url" width="320px" height="300px">
        <v-btn color="error" type="submit" @click="deleteImage" small>削除</v-btn>
      </div>
      <div v-if="image.url">
        <img :src="image.url" width="320px" height="300px">
        <v-btn color="error" type="submit" @click="deleteMapImage" small>削除</v-btn>
      </div>
      <v-btn type="submit" color="info" class="mt-5 mb-5">編集する</v-btn>
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
      current_user: '',
      name: '',
      selected: '',
      user: '',
      errors: '',
      n: ''
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
      if (this.image !== null && this.n==1) {
        formData.append("image", this.image);
      }
      axios
        .patch(`/api/v1/maps/${this.$route.params.id}`,formData,config)
        .then(response => {
          this.$emit('parent-event')
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
      axios
        .get(`/api/v1/maps/${this.$route.params.id}/edit.json`)
        .then(response =>{
          this.current_user = response.data.current_user
          this.user = response.data.user
        })
    },
    setImage(e){
      this.n = 1
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
      this.n = 1
      this.image = ''
    }
  }
}
</script>
