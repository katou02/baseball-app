<template>
  <div class="champion-content">
    <div class="main-content-btn">
      <!-- <a :href= "'/tournaments/' + num + '/watch_fcs'" class="return-top ml-1">予想一覧へ戻る</a> -->
    </div>
    <div class="champion-title">
      <i class="fas fa-crown text-warning"></i>
      優勝予想
      <i class="fas fa-crown text-warning"></i>
    </div>
    <div class="text-center">
      <router-link :to="{name: 'watch_fcs',params: {id: num}}" class="return-top mx-auto">戻る</router-link>
      <div class="mt-3" v-if="my_champion">
        {{my_champion.school}}に投票しています<br>
        <button class="delete-btn mt-2" @click="deleteChampion($route.params.id)">投票を取り消す</button>
      </div>
      <div v-else>
      <router-link :to="{name: 'champion-new',params: {id: $route.params.id},query: {tournament_id: $route.params.id}} " class="btn btn-warning champ-btn">
        優勝予想をする
      </router-link>
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
    <div class="title mt-5 d-flex">
      <div v-for="e in categories" :key="e.id">
        <div v-if="$route.params.id!=e.id">
          <router-link :to="{name: 'champion',params: {id: e.id}}" @click.native="fetchChampion()" class="title-child text-white ml-5">
            <i class="fa fa-baseball-ball text-white"></i> 
            {{e.category}}
          </router-link>
        </div>
      </div>
    </div>
    <div class="reader">
      <div style="width:75%; height:75%;" ><canvas id="myBarChart"></canvas></div>
    </div>
  </div>
</template>
<script>
import axios from 'axios';
export default {
  data() {
    return {
      schools: [],
      my_champion: [],
      vote: [],
      categories: [],
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
          this.schools = response.data.school
          this.vote = response.data.vote
          this.num = this.$route.params.id
          this.chart()
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
        this.fetchChampion();
      })
    },
    chart() {
      var ctx = document.getElementById("myBarChart");
      var myBarChart = new Chart(ctx, {
        type: 'horizontalBar',
        data: {
          labels: this.schools,
          datasets: [
            {
              data: this.vote,
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
                stepSize: 10,
              }
            }],
          },
        }
      });
    }
  },
  computed: {
    manko() {
      a = this.num + 1
      return a
    }
  }
}
</script>
<style scoped>
  .v-application a {
    color: white;
  }
</style>