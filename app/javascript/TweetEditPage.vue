<template>
  <div class="contents row mt-2">
    <h2>試合記事の編集</h2>
    <form @submit.prevent="editTweet">
      <div class="select-from">
        {{tournament}}
        <div class="containe_r p-4">
          <div class="select-school mt-3">
            <ul>
              <label>高校A</label><br>
              <select v-model="school_a">
                <option v-for="child in children" :value="child.id" :key="child.id">{{ child.name }}</option>
             </select>
            </ul>
          </div>
          <div class="select-school mt-3">
            <ul>
              <label>高校B</label><br>
              <select v-model="school_b">
                <option v-for="child in children" :value="child.id" :key="child.id">{{ child.name }}</option>
              </select>
            </ul>
          </div>
          <div class="school-a_score mt-3">
            <label>高校A 得点</label><br>
            <select v-model="school_a_score">
              <option v-for="school_a_score in 50" :value="school_a_score" :key="school_a_score.id">{{ school_a_score }}</option>
            </select>
          </div>
          <div class="school-b_score mt-3">
            <label>高校B 得点</label><br>
            <select v-model="school_b_score">
              <option v-for="school_b_score in 50" :value="school_b_score" :key="school_b_score.id">{{ school_b_score }}</option>
            </select>
          </div>
        </div>
        <input v-model="title" type="text" rows="2" cols="30" placeholder="タイトル 30字以内" class="game_title">
        <p v-if="!!errors['title_info']" class="error" style="color: red;">{{ errors['title_info'][0]}}</p>
        <textarea v-model="text" type="text" rows="2" cols="30" placeholder="本文"></textarea>
        <p v-if="!!errors['text']" class="error" style="color: red;">{{ errors['text'][0]}}</p>
        <button type="submit" class="game_record" >編集する</button>
      </div>
    </form>
  </div>
</template>
<script>
import axios from 'axios';
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