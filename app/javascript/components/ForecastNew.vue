<template>
  <div class="contents row mx-auto mt-2">
    <h2 class="text-primary font-weight-bold">試合予想の投稿</h2>
    <v-divider></v-divider>
    <form @submit.prevent="createForecast">
    <div class="form p-4">
        <div class="select-tournament w-50 mx-auto">
        <label>大会名</label><br>
        <select @change="findChildren" v-model="tournament" class="border">
            <option disabled value="">大会を選択</option>
            <option v-for="root in roots" :value="root.id" :key="root.id">{{ root.name }}</option>
        </select>
        </div>
        <p v-if="!!errors['tournament']" style="color: red;">{{ errors['tournament'][0]}}</p>
        <div class="d-flex">
        <div class="w-25 mx-auto mt-3">
            <ul>
            <label>勝利予想</label><br>
            <!-- <select @change="findGrandChildren" v-model="win_school">
                <option v-for="child in children" :value="child.id" :key="child.id">{{ child.name }}</option>
            </select> -->
            <v-select
                v-model="win_school"
                item-text="name"
                item-value="id"
                :items="children"
                outlined>
            </v-select>
            </ul>
        </div>
        <div class="w-25 mx-auto mt-3">
            <ul>
            <label>敗退予想</label><br>
            <!-- <select @change="findGrandChildren" v-model="lose_school">
                <option v-for="child in children" :value="child.id" :key="child.id">{{ child.name }}</option>
            </select> -->
            <v-select
                v-model="lose_school"
                item-text="name"
                item-value="id"
                :items="children"
                outlined>
            </v-select>
            </ul>
        </div>
        </div>
        <div class="round w-25 mx-auto mt-3">
        <label>ラウンド</label><br>
        <!-- <select v-model="round">
            <option v-for="round in round_list" :value="round.round" :key="round.id">{{ round.round }}</option>
        </select> -->
            <v-select
            v-model="round"
            item-text="round"
            item-value="round"
            :items="round_list"
            outlined>
            </v-select>
        </div>
        <div class="win-rate w-25 mx-auto mt-3">
        <label>勝利予想チームの勝利確率</label><br>
        <!-- <select v-model="probability">
            <option v-for="probability in probability_list" :value="probability.probability" :key="probability.id">{{ probability.label }}</option>
        </select> -->
        <v-select
            v-model="probability"
            item-text="label"
            item-value="probability"
            :items="probability_list"
            outlined>
        </v-select>
        </div>
    </div>
    <v-textarea v-model="text" type="text" label="本文" outlined></v-textarea>
    <p v-if="!!errors['text']" style="color: red;">{{ errors['text'][0]}}</p>
    <v-btn type="submit" color="info" class="text-white mt-5 mb-5">投稿する</v-btn>
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
      errors: '',
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
  created() {
    if(!localStorage.signedIn) {
      this.$router.replace('/forecasts')
    }
  },
  methods: {
    findChildren: function(event) {
      let rootValue = event.target.value;
      this.active()
      return this.root_id = rootValue;
    },
    createForecast() {
      axios
        .post('/api/v1/forecasts',{text: this.text,title_info: this.title,win_school_id: this.win_school,lose_school_id: this.lose_school,tournament_id: this.tournament,probability: this.probability,round: this.round})
        .then(response => {
          this.$emit('parent-event')
          //this.$router.push({ name: 'forecast'});
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
                       this.win_school = response.data.children[0].id,
                       this.lose_school = response.data.children[0].id))                
      }
    }
  }
}
</script>