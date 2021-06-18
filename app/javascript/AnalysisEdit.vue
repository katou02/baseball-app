<template>
  <div class="contents row mx-auto mt-2">
    <v-container>
      <h2 class="text-primary font-weight-bold">戦力分析の編集</h2>
      <v-divider></v-divider>
      <form @submit.prevent="editAnalysis">
        {{tournament}}
        <div class="select-from">
          <div class="select-school w-25 mx-auto mt-3">
            <label>学校</label><br>
            <v-select
              v-model="school"
              @change="findGrandChildren" 
              item-text="name"
              item-value="id"
              :items="children"
              outlined>
            </v-select>
            <p v-if="!!errors['school']" style="color: red;">{{ errors['school'][0]}}</p>
          </div>
          <br><p>5段階評価</p>
          <div class="select">
            <div class="attack w-25">
              <label>攻撃力</label><br>
              <v-select
                v-model="attack"
                :items="score"
                solo>
              </v-select>
            </div>
            <div class="defensive w-25">
              <label>守備力</label><br>
              <v-select
                v-model="defensive"
                :items="score"
                solo>
              </v-select>
            </div>
            <div class="pitcher w-25">
              <label>投手力</label><br>
              <v-select
                v-model="pitcher"
                :items="score"
                solo>
              </v-select>
            </div>
            <div class="comprehensive w-25">
              <label>総合力</label><br>
              <v-select
                v-model="comprehensive"
                :items="score"
                solo>
              </v-select>
            </div>
            <div class="expectations w-25">
              <label>期待度</label><br>
              <v-select
                v-model="expectation"
                :items="score"
                solo>
              </v-select>
            </div>
          </div>
          <v-text-field v-model="title" type="text" label="タイトル 30字以内" class="game_title"></v-text-field>
          <p v-if="!!errors['title']" style="color: red;">{{ errors['title'][0]}}</p>
          <v-textarea v-model="text" type="text" label="本文" class="mt-5" outlined></v-textarea>
          <p v-if="!!errors['text']" style="color: red;">{{ errors['text'][0]}}</p>
          <!-- <input v-if="!url && !image.url" type="file" label="画像" @change="setImage" ref="preview" accept="image/png, image/jpeg, image/bmp"> -->
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
            <v-btn color="error" type="submit" @click="deleteForecastImage" small>削除</v-btn>
          </div>
          <v-btn type="submit" color="info" class="text-white mt-5">編集する</v-btn>
        </div>
      </form>
    </v-container>
  </div>
</template>

<script>
import axios from 'axios';
const maxscore = 6;
const array = [...Array(maxscore).keys()]
const score = array.splice(1, 5)
export default {
  data: function() {
    return {
      tournament: '',
      // roots: [],
      children: [],
      grandChildren: [],
      current_user: '',
      root_id: '',
      child_id: '',
      school: '',
      attack: '',
      defensive: '',
      pitcher: '',
      user_id: '',
      comprehensive: '',
      expectation: '',
      title: '',
      image: '',
      text: '',
      score: score,
      errors: '',
      n: ''
    }
  },
  mounted() {
    axios
      .get(`/api/v1/analyses/${this.$route.params.id}/edit.json`)
      .then(response =>{
        this.children = response.data.schools;
        this.current_user = response.data.current_user.id
        this.user_id = response.data.user_id
      })
    axios
      .get(`/api/v1/analyses/${this.$route.params.id}.json`)
      .then(response =>{
        this.school = response.data.school_id;
        this.image = response.data.fcs_image
        this.attack = response.data.attack;
        this.defensive = response.data.defensive
        this.pitcher = response.data.pitcher
        this.comprehensive = response.data.comprehensive
        this.expectation = response.data.expectations
        this.tournament = response.data.tournament
        this.text = response.data.text
        this.title = response.data.title
      })
  },
  beforeUpdate() {
    if(!this.current_user || this.current_user!==this.user_id) {
      this.$router.push({ name: 'analysis-show'});
    }
  },
  methods: {
    editAnalysis() {
      let formData = new FormData();
      formData.append("title", this.title);
      formData.append("text", this.text);
      formData.append("school_id",this.school);
      formData.append("attack",this.attack);
      formData.append("defensive",this.defensive);
      formData.append("pitcher",this.pitcher);
      formData.append("comprehensive",this.comprehensive);
      formData.append("expectations",this.expectation);
      const config = {
        headers: {"content-type": "multipart/form-data",}
      };
      if (this.image !== null && this.n==1) {
        formData.append("image", this.image);
      }
      axios
        .patch(`/api/v1/analyses/${this.$route.params.id}`,formData,config)
        .then(response => {
          this.$router.push({ name: 'analysis-show',params: {id: this.$route.params.id}});
        })
        .catch(error => {
          console.error(error);
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
    deleteForecastImage(){
      this.n = 1
      this.image = ''
    }
  }
}
</script>