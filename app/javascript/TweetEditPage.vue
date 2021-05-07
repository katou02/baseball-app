<template>
  <div class="contents row mx-auto">
    <v-container>
      <h2 class="text-primary font-weight-bold">試合記事の編集</h2>
      <v-divider></v-divider>
      <form @submit.prevent="editTweet">
        <div class="select-from">
          {{tournament}}
          <div class="containe_r p-4">
            <div class="d-flex">
              <div class="select-school w-25 mx-auto mt-3">
                <!-- <ul> -->
                  <label>高校A</label><br>
                  <v-select
                    v-model="school_a"
                    item-text="name"
                    item-value="id"
                    :items="children"
                    label="高校を選択"
                    outlined>
                  </v-select>
                <!-- </ul> -->
              </div>
              <div class="select-school w-25 mx-auto mt-3">
                <!-- <ul> -->
                  <label>高校B</label><br>
                  <v-select
                    v-model="school_b"
                    item-text="name"
                    item-value="id"
                    :items="children"
                    label="高校を選択"
                    outlined>
                  </v-select>
                <!-- </ul> -->
              </div>
            </div>
            <div class="d-flex">
              <div class="school-a_score w-25 mx-auto mt-3">
                <label>高校A 得点</label><br>
                <v-select
                  v-model="school_a_score"
                  :items="score"
                  solo>
                </v-select>
                <p v-if="!!errors['school_a_score']" style="color: red;">{{ errors['school_a_score'][0]}}</p>
              </div>
              <div class="school-b_score w-25 mx-auto mt-3">
                <label>高校B 得点</label><br>
                <v-select
                  v-model="school_b_score"
                  :items="score"
                  solo>
                </v-select>
              </div>
            </div>
          </div>
          <v-text-field v-model="title" type="text" label="タイトル 30字以内" class="game_title"></v-text-field>
          <p v-if="!!errors['title_info']" style="color: red;">{{ errors['title_info'][0]}}</p>
          <v-textarea v-model="text" type="text" label="本文" outlined></v-textarea>
          <p v-if="!!errors['text']" style="color: red;">{{ errors['text'][0]}}</p>
          <input v-if="!image.url && !url" type="file" label="画像" @change="setImage" ref="preview" accept="image/png, image/jpeg, image/bmp">
          <div v-if="url">
            <img :src="url" width="320px" height="300px">
            <button type="submit" @click="deleteImage">削除</button>
          </div>
          <div v-if="image.url">
            <img :src="image.url" width="320px" height="300px">
            <button type="submit" @click="deleteTweetImage">削除</button>
          </div>
          <v-btn type="submit" color="primary" class="text-white mt-5">編集する</v-btn>
        </div>
      </form>
    </v-container>
  </div>
</template>
<script>
import axios from 'axios';
const maxscore = 51;
const score = [...Array(maxscore).keys()]
export default {
  data: function() {
    return {
      tournament: '',
      children: [],
      data: '',
      child_id: '',
      school_a_score: '',
      school_b_score: '',
      score: score,
      school_a: '',
      school_b: '',
      title: '',
      text: '',
      errors: '',
      image: null,
      url: '',
      n: ''
    }
  },
  mounted() {
    axios
      .get(`/api/v1/tweets/${this.$route.params.id}/edit.json`)
      .then(response =>{
        this.children = response.data;
      })
    axios
      .get(`/api/v1/tweets/${this.$route.params.id}.json`)
      .then(response =>{
        this.data = response.data
        this.school_a = response.data.school_a_id;
        this.school_b = response.data.school_b_id;
        this.school_a_score = response.data.school_a_score
        this.school_b_score = response.data.school_b_score
        this.title = response.data.title
        this.text = response.data.text
        this.tournament = response.data.tournament
        this.image = response.data.tweet_image
      })
  },
  methods: {
    editTweet() {
      let formData = new FormData();
      formData.append("title_info", this.title);
      formData.append("text", this.text);
      formData.append("school_a_score",this.school_a_score);
      formData.append("school_b_score",this.school_b_score);
      formData.append("school_a_id",this.school_a);
      formData.append("school_b_id",this.school_b);
      const config = {
        headers: {"content-type": "multipart/form-data",}
      };
      if (this.image !== null && this.n==1) {
        formData.append("image", this.image);
      }
      axios
        // .patch(`/api/v1/tweets/${this.$route.params.id}`,{text: this.text,title_info: this.title,school_a_score: this.school_a_score,school_b_score: this.school_b_score,school_a_id: this.school_a,school_b_id: this.school_b})
        .patch(`/api/v1/tweets/${this.$route.params.id}`,formData,config)
        .then(response => {
          this.$router.push({ name: 'tweet-show',params: {id: this.$route.params.id}});
        })
        .catch(error => {
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
        });
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
    deleteTweetImage(){
      this.n = 1
      this.image = ''
    }
  }
}
</script>