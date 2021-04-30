<template>
  <div class="contents row mx-auto">
    <v-container>
      <h2 class="text-primary font-weight-bold">試合記事の投稿</h2>
      <v-divider></v-divider>
      <form @submit.prevent="createTweet">
        <div class="select-from">
          <div class="containe_r p-4">
            <label>大会名</label><br>
            <div class="select-tournament w-50 mx-auto">
              <select @change="findChildren" v-model="tournament" class="border">
                <option disabled value="">大会を選択</option>
                <option v-for="root in roots" :value="root.id" :key="root.id">{{ root.name }}</option>
              </select>
            </div>
            <p v-if="!!errors['tournament']" style="color: red;">{{ errors['tournament'][0]}}</p>
            <div class="d-flex">
              <div class="select-school w-25 mx-auto mt-3">
                <ul>
                  <label>高校A</label><br>
                  <!-- <select @change="findGrandChildren" v-model="school_a">
                    <option v-for="child in children" :value="child.id" :key="child.id">{{ child.name }}</option>
                  </select> -->
                  <v-select
                    v-model="school_a"
                    @change="findGrandChildren" 
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
                  <!-- <select @change="findGrandChildren" v-model="school_b">
                    <option v-for="child in children" :value="child.id" :key="child.id">{{ child.name }}</option>
                  </select> -->
                  <v-select
                    v-model="school_b"
                    @change="findGrandChildren" 
                    item-text="name"
                    item-value="id"
                    :items="children"
                    label="高校を選択"
                    outlined>
                  </v-select>
                </ul>
              </div>
            </div>
            <div class="d-flex">
              <div class="school-a_score w-25 mx-auto mt-3">
                <label>高校A 得点</label><br>
                <!-- <select v-model="school_a_score">
                  <option v-for="school_a_score in 50" :value="school_a_score" :key="school_a_score.id">{{ school_a_score }}</option>
                </select> -->
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
                <!-- <select v-model="school_b_score">
                  <option v-for="school_b_score in 50" :value="school_b_score" :key="school_b_score.id">{{ school_b_score }}</option>
                </select> -->
                <v-select
                  v-model="school_b_score"
                  :items="score"
                  label="スコア"
                  solo>
                </v-select>
              </div>
            </div>
            <p v-if="!!errors['school_b_score']" style="color: red;">{{ errors['school_b_score'][0]}}</p>
          </div>
          <v-text-field v-model="title" type="text" label="タイトル 30字以内" class="mb-5"></v-text-field>
          <p v-if="!!errors['title_info']" style="color: red;">{{ errors['title_info'][0]}}</p>
          <v-textarea v-model="text" type="text" label="本文" outlined class="mt-5"></v-textarea>
          <p v-if="!!errors['text']" style="color: red;">{{ errors['text'][0]}}</p>
          <input type="file" label="画像" @change="setImage" ref="preview" accept="image/png, image/jpeg, image/bmp">
          <div v-if="url">
            <img :src="url" width="320px" height="300px">
            <button type="submit" @click="deleteImage">削除</button>
          </div>
          <v-btn type="submit" color="primary" class="text-white mt-5">投稿する</v-btn>
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
      url: ''
    }
  },
  mounted() {
    axios.get('/api/v1/tweets/new.json')
    .then(response => (this.roots = response.data.roots,
                       this.children = response.data.children,
                       this.grandChildren = response.data.grandChildren))
  },
  methods: {
    findChildren: function(event) {
      let rootValue = event.target.value;
      this.active()
      return this.root_id = rootValue;
    },
    findGrandChildren: function(event) {
      let childValue = event.target.value;
      return this.child_id = childValue;
    },
    createTweet() {
      let formData = new FormData();
      formData.append("title_info", this.title);
      formData.append("text", this.text);
      formData.append("school_a_score",this.school_a_score);
      formData.append("school_b_score",this.school_b_score);
      formData.append("tournament_id",this.tournament);
      formData.append("school_a_id",this.school_a);
      formData.append("school_b_id",this.school_b);
    const config = {
      headers: {"content-type": "multipart/form-data",}
    };
      if (this.image !== null) {
        formData.append("image", this.image);
      }
      axios
        // .post('/api/v1/tweets',{image: this.image,text: this.text,title_info: this.title,school_a_score: this.school_a_score,school_b_score: this.school_b_score,tournament_id: this.tournament,school_a_id: this.school_a,school_b_id: this.school_b})
        .post('/api/v1/tweets',formData,config)
        .then(response => {
          this.$router.push({ name: 'tweet'});
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
    // child_id: function() {
    //   if (this.child_id !== "" ) {
    //     axios.get('/api/v1/tweets/new.json', { params: { root_id: this.root_id, child_id: this.child_id } }).then(response => (this.grandChildren = response.data.grandChildren))
    //   }
    // }
  }
}
</script>