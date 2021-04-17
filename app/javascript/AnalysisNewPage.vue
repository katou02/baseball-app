<template>
  <div class="contents row mt-2">
    <router-link :to="{name: 'analysis'}" class="return-btn">戻る</router-link>
    <h2>予想の投稿</h2>
    <form @submit.prevent="createAnalysis">
      <div class="select-from">
        <div class="containe_r p-4">
          <div class="select-tournament">
            <label>大会名</label><br>
            <select @change="findChildren" v-model="tournament">
              <option disabled value="">大会を選択</option>
              <option v-for="root in roots" :value="root.id" :key="root.id">{{ root.name }}</option>
            </select>
          </div>
        </div>
        <p v-if="!!errors['tournament']" class="error" style="color: red;">{{ errors['tournament'][0]}}</p>
        <div class="select-school mt-3">
          <ul>
            <label>高校</label><br>
            <select @change="findGrandChildren" v-model="school">
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
      roots: [],
      children: [],
      grandChildren: [],
      root_id: '',
      child_id: '',
      school: '',
      attack: '1',
      defensive: '1',
      pitcher: '1',
      comprehensive: '1',
      expectation: '1',
      title: '',
      text: '',
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
      axios
        .post('/api/v1/analyses',{title: this.title,text: this.text,tournament_id: this.tournament,school_id: this.school,attack: this.attack,defensive: this.defensive,pitcher: this.pitcher,comprehensive: this.comprehensive,expectations: this.expectation})
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