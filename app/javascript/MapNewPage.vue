<template>
  <div class="contents row mt-2">
    <div class="containe_r p-4">
      <form @submit.prevent="createMap">
        <input v-model="address" type="text" placeholder="市町村 住所など" class="game_title text-center">
        <textarea v-model="text" type="text" placeholder="紹介"></textarea>
        <label>学校選択</label><br>
        <select v-model="school">
          <option v-for="school in schools" :value="school.id" :key="school.id">
            {{ school.name }}
          </option>
        </select><br>
        <input type="file" label="画像" @change="setImage" ref="preview" accept="image/png, image/jpeg, image/bmp">
        <button type="submit">投稿</button>
      </form>
    </div>
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