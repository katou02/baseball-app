<template>
  <div class="champion-content">
    <div class="main-content-btn">
      <!-- <a :href= "'/tournaments/' + num + '/watch_fcs'" class="return-top ml-1">予想一覧へ戻る</a> -->
      <router-link :to="{name: 'watch_fcs',params: {id: num}}" class="return-top ml-1">予想一覧へ戻る</router-link>
    </div>
    <div class="champion-title">
      <i class="fas fa-crown text-warning"></i>
      優勝予想
      <i class="fas fa-crown text-warning"></i>
    </div>
    <div class="text-center">
      <a :href= "'/champions/new?tournament_id=' + num" class="btn btn-warning champ-btn">
        優勝予想をする
      </a>
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
    <div class="title pb-5 mt-5">
      <div v-for="e in categories" :key="e.id">
        <div v-if="$route.params.id!=e.id">
          <router-link :to="{name: 'champion',params: {id: e.id}}" @click.native="fetchChampion()" class="title-child text-white">
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
      manko: [],
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