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
          <p v-if="!!errors['title_info']" class="error" style="color: red;">{{ errors['title_info'][0]}}</p>
          <v-textarea v-model="text" type="text" label="本文" outlined></v-textarea>
          <p v-if="!!errors['text']" class="error" style="color: red;">{{ errors['text'][0]}}</p>
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
      grandChildren: [],
      // root_id: '',
      child_id: '',
      school_a_score: '',
      school_b_score: '',
      score: score,
      school_a: '',
      school_b: '',
      title: '',
      text: '',
      errors: ''
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
        this.school_a = response.data.school_a_id;
        this.school_b = response.data.school_b_id;
        this.school_a_score = response.data.school_a_score
        this.school_b_score = response.data.school_b_score
        this.title = response.data.title
        this.text = response.data.text
        this.tournament = response.data.tournament
      })
  },
  methods: {
    editTweet() {
      axios
        .patch(`/api/v1/tweets/${this.$route.params.id}`,{text: this.text,title_info: this.title,school_a_score: this.school_a_score,school_b_score: this.school_b_score,school_a_id: this.school_a,school_b_id: this.school_b})
        .then(response => {
          this.$router.push({ name: 'tweet-show',params: {id: this.$route.params.id}});
        })
        .catch(error => {
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
          console.log(this.errors)
        });
    }
  }
}
</script>