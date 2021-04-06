<template>
  <div class="contents row mt-2">
    <h2>試合記事の投稿</h2>
    <form @submit.prevent="createTweet">
      <div class="select-from">
        <div class="containe_r p-4">
          <div class="select-tournament">
            <label>大会名</label><br>
            <select @change="findChildren" v-model="tournament">
              <option disabled value="">大会を選択</option>
              <option v-for="root in roots" :value="root.id" :key="root.id">{{ root.name }}</option>
            </select>
          </div>
          <p v-if="!!errors['tournament']" class="error" style="color: red;">{{ errors['tournament'][0]}}</p>
          <div class="select-school mt-3">
            <ul>
              <label>高校A</label><br>
              <select @change="findGrandChildren" v-model="school_a">
                <option v-for="child in children" :value="child.id" :key="child.id">{{ child.name }}</option>
             </select>
            </ul>
          </div>
          <div class="select-school mt-3">
            <ul>
              <label>高校B</label><br>
              <select @change="findGrandChildren" v-model="school_b">
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
        <input type="file" label="画像" accept="image/png, image/jpeg, image/bmp">
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
      school_a_score: '1',
      school_b_score: '1',
      school_a: '',
      school_b: '',
      title: '',
      text: '',
      errors: '',
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
      axios
        .post('/api/v1/tweets',{text: this.text,title_info: this.title,school_a_score: this.school_a_score,school_b_score: this.school_b_score,tournament_id: this.tournament,school_a_id: this.school_a,school_b_id: this.school_b})
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
<style scoped>
ul {
  display: none;
}

.active {
  display: block;
}
</style>