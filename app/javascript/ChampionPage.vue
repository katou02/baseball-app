<template>
  <div class="champion-content">
    <div class="champion-title">
      <i class="fas fa-crown text-warning"></i>
      優勝予想
      <i class="fas fa-crown text-warning"></i>
    </div>
    <router-link :to="{name: 'watch_fcs',params: {id: num}}" class="return-top mx-auto text-white">戻る</router-link>
    <div v-if="current_user!=null">
      <div class="text-center">
        <div class="mt-3" v-if="my_champion">
          {{my_champion.school}}に投票しています<br>
          <button class="delete-btn mt-2" @click="deleteChampion($route.params.id)">投票を取り消す</button>
        </div>
        <div v-else>
          <!-- <router-link :to="{name: 'champion-new',params: {id: $route.params.id},query: {tournament_id: $route.params.id}} " class="btn btn-warning champ-btn text-white">
            優勝予想をする
          </router-link> -->
          <button class="btn btn-warning champ-btn" @click="openModal">優勝予想をする</button>
          <modal name="select" height="auto" width="65%">
            <div id="modal">
              <Champion @parent-event="fetchChampion"></Champion>
              <button @click="closeModal">閉じる</button>
            </div>
          </modal>
        </div>
      </div>
    </div>
    <div class="text-format mt-5 text-primary">
      <div v-for="e in categories" :key="e.id">
        <div v-if="$route.params.id==e.id">
          {{e.category}}
        </div>
      </div>
    </div>
    <div class="text-format mt-5 mb-4 text-warning">
      大会別
    </div>
    <div class="category mt-5 d-md-flex">
      <div v-for="e in categories" :key="e.id">
        <div v-if="$route.params.id!=e.id">
          <router-link :to="{name: 'champion',params: {id: e.id}}" @click.native="DeleteChart(); fetchChampion()" class="title-child text-white ml-5 mt-5">
            <i class="fa fa-baseball-ball text-white"></i> 
            {{e.category}}
          </router-link>
        </div>
      </div>
    </div>
    <div class="bar">
      <div style="width:75%; height:75%;" ><canvas id="myBarChart"></canvas></div>
    </div>
    <p class="description">カーソルをグラフに合わせると投票数を確認できます</p>
  </div>
</template>
<script>
import axios from 'axios';
import Champion from './components/ChampionNew.vue'
export default {
  components: {
    Champion
  },
  data() {
    return {
      schools: [],
      my_champion: [],
      votes: [],
      categories: [],
      current_user: '',
      num: 1
    }
  },
  mounted() {
    this.fetchChampion()
    this.fetchCategory()
  },
  methods: {
    fetchChampion() {
      axios
        .get(`/api/v1/champions/${this.$route.params.id}`)
        .then(response =>{
          this.my_champion = response.data.my_champion
          this.current_user = response.data.current_user
          this.schools = response.data.school
          this.votes = response.data.vote
          this.num = this.$route.params.id
          this.chart()
          if(!response.data.current_user && this.$store.state.signedIn == true) {
            delete localStorage.csrf
            delete localStorage.signedIn
            this.$router.go(`/champions/${this.$route.params.id}`)
          }
        })
    },
    fetchCategory() {
      axios
        .get('/api/v1/tweets/category.json')
        .then(response =>{
          this.categories = response.data;
        })
    },
    deleteChampion(id) {
      axios.delete(`/api/v1/champions/${id}`)
      .then(response => {
        this.DeleteChart()
        this.fetchChampion()
      })
    },
    openModal(){
      this.$modal.show('select');
    },
    closeModal(){
      this.$modal.hide('select');
    },
    DeleteChart() {
      myBarChart.destroy()
    },
    chart() {
      var ctx = document.getElementById("myBarChart");
      window.myBarChart = new Chart(ctx, {
        type: 'horizontalBar',
        data: {
          labels: this.schools,
          datasets: [
            {
              data: this.votes,
              backgroundColor: ["red", "yellow", "lime", "aqua", "orange"]
            }
          ]
        },
        options: {
          title: {
            display: true,
            text: '投票結果',
            fontSize: 20,
            fontColor: '#000'
          },
          legend: {
            display: false
        },
          scales: {
            yAxes: [{
              ticks: {
                callback: function(value, index, values){
                    return  value
                }
              }
            }],
            xAxes: [{
              ticks: {
                suggestedMax: 100,
                suggestedMin: 0,
                stepSize: 5,
              }
            }],
          },
        }
      });
    }
  }
}
</script>