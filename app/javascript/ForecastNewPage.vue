<template>
  <div class="contents row mt-2">
    <h2>試合記事の投稿</h2>
    <form @submit.prevent="createForecast">
      <div class="form p-4">
        <div class="select-tournament">
          <label>大会名</label><br>
          <select @change="findChildren" v-model="tournament">
            <option disabled value="">大会を選択</option>
            <option v-for="root in roots" :value="root.id" :key="root.id">{{ root.name }}</option>
          </select>
        </div>
        <div class="win-school mt-3">
          <ul>
            <label>勝利予想</label><br>
            <select @change="findGrandChildren" v-model="win_school">
              <option v-for="child in children" :value="child.id" :key="child.id">{{ child.name }}</option>
            </select>
          </ul>
        </div>
        <div class="lose-school mt-3">
          <ul>
            <label>敗退予想</label><br>
            <select @change="findGrandChildren" v-model="lose_school">
              <option v-for="child in children" :value="child.id" :key="child.id">{{ child.name }}</option>
            </select>
          </ul>
        </div>
        <div class="round mt-3">
          <label>ラウンド</label><br>
          <select v-model="round">
            <option v-for="round in round_list" :value="round.round" :key="round.id">{{ round.round }}</option>
          </select>
        </div>
        <div class="win-rate mt-3">
          <label>勝利予想チームの勝利確率</label><br>
          <select v-model="probability">
            <option v-for="probability in probability_list" :value="probability.probability" :key="probability.id">{{ probability.label }}</option>
          </select>
        </div>
      </div>
      <input v-model="title" type="text" rows="2" cols="30" placeholder="タイトル 30字以内" class="game_title">
      <textarea v-model="text" type="text" rows="2" cols="30" placeholder="本文"></textarea>
      <button type="submit" class="game_record" >投稿する</button>
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
      win_school: '',
      lose_school: '',
      text: '',
      title: '',
      round: '1回戦',
      round_list: [
        {round: '1回戦'},
        {round: '2回戦'},
        {round: '3回戦'},
        {round: '準々決勝'},
        {round: '準決勝'},
        {round: '決勝'}
      ],
      probability: 60,
      probability_list: [
        {probability: 60,label: '60%'},
        {probability: 70,label: '70%'},
        {probability: 80,label: '80%'},
        {probability: 90,label: '90%'},
        {probability: 100,label: '100%'},
      ]
    }
  },
  mounted() {
    axios.get('/api/v1/forecasts/new.json')
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
    createForecast() {
      axios
        .post('/api/v1/forecasts',{text: this.text,title_info: this.title,win_school_id: this.win_school,lose_school_id: this.lose_school,tournament_id: this.tournament,probability: this.probability,round: this.round})
        .then(response => {
          this.$router.push({ name: 'forecast'});
        })
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
                       this.win_school = response.data.children[0].id,
                       this.lose_school = response.data.children[0].id))                
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