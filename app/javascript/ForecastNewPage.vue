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
      // this.active()
      return this.root_id = rootValue;
    },
  }
}
</script>