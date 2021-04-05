<template>
  <div class="contents row mt-2">
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
    </div>
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
      lose_school: ''
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