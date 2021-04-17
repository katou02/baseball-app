<template>
  <div class="contents row">
    <form @submit.prevent="editAnalysis">
      {{tournament}}
      <div class="select-from">
        <div class="select-school mt-3">
          <ul>
            <label>高校</label><br>
            <select v-model="school">
              <option v-for="child in children" :value="child.id" :key="child.id">{{ child.name }}</option>
            </select>
          </ul>
        </div>
        <br><p>5段階評価</p>
        <div class="select">
          <div class="attack">
            <label>攻撃力</label><br>
            <select v-model="attack">
              <option v-for="attack in 5" :value="attack" :key="attack.id">{{ attack }}</option>
            </select>
          </div>
          <div class="defensive">
            <label>守備力</label><br>
            <select v-model="defensive">
              <option v-for="defensive in 5" :value="defensive" :key="defensive.id">{{ defensive }}</option>
            </select>
          </div>
          <div class="pitcher">
            <label>投手力</label><br>
            <select v-model="pitcher">
              <option v-for="pitcher in 5" :value="pitcher" :key="pitcher.id">{{ pitcher }}</option>
            </select>
          </div>
          <div class="comprehensive">
            <label>総合力</label><br>
            <select v-model="comprehensive">
              <option v-for="comprehensive in 5" :value="comprehensive" :key="comprehensive.id">{{ comprehensive }}</option>
            </select>
          </div>
          <div class="expectations">
            <label>期待度</label><br>
            <select v-model="expectation">
              <option v-for="expectation in 5" :value="expectation" :key="expectation.id">{{ expectation }}</option>
            </select>
          </div>
        </div>
        <input v-model="title" type="text" rows="2" cols="30" placeholder="タイトル 30字以内" class="game_title">
        <p v-if="!!errors['title']" class="error" style="color: red;">{{ errors['title'][0]}}</p>
        <textarea v-model="text" type="text" rows="2" cols="30" placeholder="本文"></textarea>
        <p v-if="!!errors['text']" class="error" style="color: red;">{{ errors['text'][0]}}</p>
        <button type="submit" class="game_record" >投稿する</button>
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
      // roots: [],
      children: [],
      grandChildren: [],
      root_id: '',
      child_id: '',
      school: '',
      attack: '',
      defensive: '',
      pitcher: '',
      comprehensive: '',
      expectation: '',
      title: '',
      text: '',
      errors: ''
    }
  },
  mounted() {
    axios
      .get(`/api/v1/analyses/${this.$route.params.id}/edit.json`)
      .then(response =>{
        this.children = response.data;
      })
    axios
      .get(`/api/v1/analyses/${this.$route.params.id}.json`)
      .then(response =>{
        this.school = response.data.school_id;
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
  methods: {
    editAnalysis() {
      axios
        .patch(`/api/v1/analyses/${this.$route.params.id}`,{title: this.title,text: this.text,school_id: this.school,attack: this.attack,defensive: this.defensive,pitcher: this.pitcher,comprehensive: this.comprehensive,expectations: this.expectation})
        .then(response => {
          this.$router.push({ name: 'analysis-show',params: {id: this.$route.params.id}});
        })
        .catch(error => {
          console.error(error);
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
        });
    }
  }
}
</script>