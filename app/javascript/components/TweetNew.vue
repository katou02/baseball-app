<template>
  <div class="contents row mx-auto">
    <h2 class="text-primary font-weight-bold pt-4">試合記事の投稿</h2>
    <v-divider></v-divider>
    <form @submit.prevent="createTweet">
      <div class="select-from">
        <div class="containe_r p-4">
          <label>大会名</label><br>
          <div class="select-tournament mx-auto">
            <select @change="findChildren" v-model="tournament" class="border">
              <option disabled value="">大会を選択</option>
              <option v-for="root in roots" :value="root.id" :key="root.id">{{ root.name }}</option>
            </select>
          </div>
          <p v-if="!!errors['tournament']" style="color: red;">{{ errors['tournament'][0]}}</p>
          <div class="select-tab-school">
            <div class="select-school w-25 mx-auto mt-3">
              <ul>
                <label>高校A</label><br>
                <v-select
                  v-model="school_a"
                  item-text="name"
                  item-value="id"
                  :items="children"
                  label="高校を選択"
                  outlined>
                </v-select>
              </ul>
            </div>
            <div class="select-school w-25 mx-auto mt-3">
              <ul>
                <label>高校B</label><br>
                <v-select
                  v-model="school_b" 
                  item-text="name"
                  item-value="id"
                  :items="children"
                  label="高校を選択"
                  outlined>
                </v-select>
              </ul>
            </div>
          </div>
          <div class="select-tab-score">
            <div class="school-a_score w-25 mx-auto mt-3">
              <label>高校A 得点</label><br>
              <v-select
                v-model="school_a_score"
                :items="score"
                label="スコア"
                solo>
              </v-select>
              <p v-if="!!errors['school_a_score']" style="color: red;">{{ errors['school_a_score'][0]}}</p>
            </div>
            <div class="school-b_score w-25 mx-auto mt-3">
              <label>高校B 得点</label><br>
              <v-select
                v-model="school_b_score"
                :items="score"
                label="スコア"
                solo>
              </v-select>
              <p v-if="!!errors['school_b_score']" style="color: red;">{{ errors['school_b_score'][0]}}</p>
            </div>
          </div>
          <div class="round w-25 mx-auto mt-3">
            <label>ラウンド</label><br>
            <v-select
              v-model="round"
              item-text="round"
              item-value="round"
              :items="round_list"
              outlined>
            </v-select>
          </div>
        </div>
        <v-text-field v-model="title" type="text" label="タイトル 30字以内" class="mb-5"></v-text-field>
        <p v-if="!!errors['title']" style="color: red;">{{ errors['title'][0]}}</p>
        <v-textarea v-model="text" type="text" label="本文" outlined class="mt-5"></v-textarea>
        <p v-if="!!errors['text']" style="color: red;">{{ errors['text'][0]}}</p>
        <label v-if="!url" class="photo w-25">
          ＋写真を選択
          <input type="file" style="display:none;"  @change="setImage" ref="preview" accept="image/png, image/jpeg, image/bmp">
        </label>
        <div v-if="url">
          <img :src="url"  width="320px" height="300px">
          <v-btn color="error" type="submit" @click="deleteImage" small>削除</v-btn>
        </div>
        <v-btn type="submit" color="info" class="text-white mt-5 mb-5">投稿する</v-btn>
      </div>
    </form>
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
      roots: [],
      children: [],
      grandChildren: [],
      root_id: '',
      child_id: '',
      score: score,
      school_a_score: '',
      school_b_score: '',
      school_a: '',
      school_b: '',
      title: '',
      text: '',
      errors: '',
      image: '',
      url: '',
      round: '1回戦',
      round_list: [
        {round: '1回戦'},
        {round: '2回戦'},
        {round: '3回戦'},
        {round: '準々決勝'},
        {round: '準決勝'},
        {round: '決勝'}
      ],
    }
  },
  mounted() {
    axios.get('/api/v1/tweets/new.json')
    .then(response => (this.roots = response.data.roots,
                       this.children = response.data.children,
                       this.grandChildren = response.data.grandChildren))
  },
  created() {
    if(!localStorage.signedIn) {
      this.$router.replace('/tweets')
    }
  },
  methods: {
    findChildren: function(event) {
      let rootValue = event.target.value;
      this.active()
      return this.root_id = rootValue;
    },
    createTweet() {
      let formData = new FormData();
      formData.append("title", this.title);
      formData.append("text", this.text);
      formData.append("school_a_score",this.school_a_score);
      formData.append("school_b_score",this.school_b_score);
      formData.append("tournament_id",this.tournament);
      formData.append("school_a_id",this.school_a);
      formData.append("school_b_id",this.school_b);
      formData.append("round",this.round);
    const config = {
      headers: {"content-type": "multipart/form-data",}
    };
      if (this.image !== null) {
        formData.append("image", this.image);
      }
      axios
        .post('/api/v1/tweets',formData,config)
        .then(response => {
          this.$emit('parent-event')
        })
        .catch(error => {
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
        });
    },
    active() {
      let school = document.querySelectorAll('ul')
      school[0].classList.add('active');
      school[1].classList.add('active');
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
    }
  },
  watch: {
    root_id: function() {
      if (this.root_id !== "" ) {
        axios.get('/api/v1/tweets/new.json', { params: { root_id: this.root_id } }).then(
          response => (this.children = response.data.children,
                       this.school_a = response.data.children[0].id,
                       this.school_b = response.data.children[0].id))    
      }
    },
  }
}
</script>