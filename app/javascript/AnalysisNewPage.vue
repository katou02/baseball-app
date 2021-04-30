<template>
  <div class="contents row mx-auto mt-2">
    <h2 class="text-primary font-weight-bold">試合分析の投稿</h2>
    <v-divider></v-divider>
    <form @submit.prevent="createAnalysis">
      <div class="select-from">
        <div class="containe_r p-4">
          <div class="select-tournament">
            <label>大会名</label><br>
            <select @change="findChildren" v-model="tournament" class="border">
              <option disabled value="">大会を選択</option>
              <option v-for="root in roots" :value="root.id" :key="root.id">{{ root.name }}</option>
            </select>
          </div>
        </div>
        <p v-if="!!errors['tournament']" style="color: red;">{{ errors['tournament'][0]}}</p>
        <div class="select-school w-25 mx-auto mt-3">
          <ul>
            <label>高校</label><br>
            <!-- <select @change="findGrandChildren" v-model="school">
              <option v-for="child in children" :value="child.id" :key="child.id">{{ child.name }}</option>
            </select> -->
            <v-select
              v-model="school"
              @change="findGrandChildren" 
              item-text="name"
              item-value="id"
              :items="children"
              outlined>
            </v-select>
          </ul>
          <p v-if="!!errors['school']" style="color: red;">{{ errors['school'][0]}}</p>
        </div>
        <br><p>5段階評価</p>
        <div class="select">
          <div class="attack w-25">
            <label>攻撃力</label><br>
            <!-- <select v-model="attack">
              <option v-for="attack in 5" :value="attack" :key="attack.id">{{ attack }}</option>
            </select> -->
            <v-select
              v-model="attack"
              :items="score"
              label="評価を選択"
              solo>
            </v-select>
            <p v-if="!!errors['attack']" style="color: red;">{{ errors['attack'][0]}}</p>
          </div>
          <div class="defensive w-25">
            <label>守備力</label><br>
            <!-- <select v-model="defensive">
              <option v-for="defensive in 5" :value="defensive" :key="defensive.id">{{ defensive }}</option>
            </select> -->
            <v-select
              v-model="defensive"
              :items="score"
              label="評価を選択"
              solo>
            </v-select>
            <p v-if="!!errors['defensive']" style="color: red;">{{ errors['defensive'][0]}}</p>
          </div>
          <div class="pitcher w-25">
            <label>投手力</label><br>
            <!-- <select v-model="pitcher">
              <option v-for="pitcher in 5" :value="pitcher" :key="pitcher.id">{{ pitcher }}</option>
            </select> -->
            <v-select
              v-model="pitcher"
              :items="score"
              label="評価を選択"
              solo>
            </v-select>
            <p v-if="!!errors['pitcher']" style="color: red;">{{ errors['pitcher'][0]}}</p>
          </div>
          <div class="comprehensive w-25">
            <label>総合力</label><br>
            <!-- <select v-model="comprehensive">
              <option v-for="comprehensive in 5" :value="comprehensive" :key="comprehensive.id">{{ comprehensive }}</option>
            </select> -->
            <v-select
              v-model="comprehensive"
              :items="score"
              label="評価を選択"
              solo>
            </v-select>
            <p v-if="!!errors['comprehensive']" style="color: red;">{{ errors['comprehensive'][0]}}</p>
          </div>
          <div class="expectations w-25">
            <label>期待度</label><br>
            <!-- <select v-model="expectation">
              <option v-for="expectation in 5" :value="expectation" :key="expectation.id">{{ expectation }}</option>
            </select> -->
            <v-select
              v-model="expectation"
              :items="score"
              label="評価を選択"
              solo>
            </v-select>
            <p v-if="!!errors['expectations']" style="color: red;">{{ errors['expectations'][0]}}</p>
          </div>
        </div>
         <v-text-field v-model="title" type="text" label="タイトル 30字以内" class="mb-5"></v-text-field>
        <p v-if="!!errors['title']" style="color: red;">{{ errors['title'][0]}}</p>
        <v-textarea v-model="text" type="text" rows="2" cols="30" label="分析内容" class="mt-5" outlined></v-textarea>
        <p v-if="!!errors['text']" style="color: red;">{{ errors['text'][0]}}</p>
        <input type="file" label="画像" @change="setImage" ref="preview" accept="image/png, image/jpeg, image/bmp">
        <div v-if="url">
          <img :src="url" width="320px" height="300px">
          <button type="submit" @click="deleteImage">削除</button>
        </div>
        <v-btn type="submit" color="primary" class="text-white mt-5">投稿する</v-btn>
      </div>
    </form>
  </div>
</template>
<script>
import axios from 'axios';
const maxscore = 6;
const score = [...Array(maxscore).keys()]
export default {
  data: function() {
    return {
      tournament: '',
      roots: [],
      children: [],
      grandChildren: [],
      score: score,
      root_id: '',
      child_id: '',
      school: '',
      attack: '',
      defensive: '',
      pitcher: '',
      comprehensive: '',
      expectation: '',
      image: '',
      title: '',
      text: '',
      url: '',
      errors: ''
    }
  },
  mounted() {
  axios.get('/api/v1/analyses/new.json')
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
    createAnalysis() {
      let formData = new FormData();
      formData.append("title", this.title);
      formData.append("text", this.text);
      formData.append("tournament_id",this.tournament)
      formData.append("school_id",this.school);
      formData.append("attack",this.attack);
      formData.append("defensive",this.defensive);
      formData.append("pitcher",this.pitcher);
      formData.append("comprehensive",this.comprehensive);
      formData.append("expectations",this.expectation);
      const config = {
        headers: {"content-type": "multipart/form-data",}
      };
      if (this.image !== null) {
        formData.append("image", this.image);
      }
      axios
        .post('/api/v1/analyses',formData,config)
        .then(response => {
          this.$router.push({ name: 'analysis'});
        })
        .catch(error => {
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
        });
    },
    active() {
      let school = document.querySelector('ul')
      school.classList.add('active');
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
        axios.get('/api/v1/analyses/new.json', { params: { root_id: this.root_id } }).then(
          response => (this.children = response.data.children,
                       this.school = response.data.children[0].id))
                       
      }
    }
  }
}
</script>
<style scoped>
ul {
  display: none;
}

.active {
  display: block;
}
</style>