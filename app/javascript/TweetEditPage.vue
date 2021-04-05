<template>
  <div class="contents row mt-2">
    <h2>試合記事の投稿</h2>
    <form @submit.prevent="createTweet">
      <div class="select-from">
        <div class="containe_r p-4">
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
        <textarea v-model="text" type="text" rows="2" cols="30" placeholder="本文"></textarea>
        <button type="submit" class="game_record" >投稿する</button>
      </div>
    </form>
  </div>
</template>
<script>
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
      a: ''
    }
  },
  mounted() {
    axios
      .get(`/api/v1/tweets/${this.$route.params.id}.json`)
      .then(response =>{
        this.school_a = response.data.school_a;
        this.school_a_score = 3;
      })
  }
}
</script>