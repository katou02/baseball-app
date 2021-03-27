<template>
  <div class="champion-content">
    {{champion}}
    {{manko}}
    {{num}}
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
      vote: []
    }
  },
  mounted() {
    this.fetchChampion()
  },
  methods: {
    fetchChampion() {
      axios
        .get(`/api/v1/champions/${this.$route.params.id}`)
        .then(response =>{
          this.schools = response.data.school
          this.vote = response.data.vote
          this.chart()
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
            text: '上位5チーム',
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
  }
}
</script>