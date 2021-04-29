<template>
  <div class="contents row mx-auto mt-2">
    <h2 class="text-primary font-weight-bold">戦力分析の編集</h2>
    <v-divider></v-divider>
    <form @submit.prevent="editAnalysis">
      {{tournament}}
      <div class="select-from">
        <div class="select-school w-25 mx-auto mt-3">
          <ul>
            <label>学校</label><br>
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
        <v-textarea v-model="text" type="text" label="本文"></v-textarea>
        <v-btn type="submit" color="primary" class="text-white mt-5">編集する</v-btn>
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
      score: score,
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