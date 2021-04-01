<template>
  <div class="average-content">
    <h3>戦力分析の平均評価</h3>
    <div v-for=" e in data" :key="e.id">
      <div class="avg-name text-center">{{e.name}}</div>
      <div class="data-title mt-3 ml-5">
        戦力
      </div>
      <div class="average">
        <p class="avg-font">攻撃力<p>
        <div ref="ma" class="avg-attack">{{e.attack_num}}</div>
        <p class="avg-font">守備力<p>
        <div class="avg-defense">{{e.defense_num}}</div>
        <p class="avg-font">投手力<p>
        <div class="avg-pitch">{{e.pitch_num}}</div>
        <p class="avg-font">総合力<p>
        <div class="avg-total">{{e.total_num}}</div>
        <p class="avg-font">期待度</p>
        <div class="avg-expec">{{e.expectations_num}}</div>
      </div>
      <div style="width:900px; height:500px;" >
        <canvas id="RaderChart"></canvas>
      </div>
      <!-- {{fetchchart()}} -->
    </div>
  </div>
</template>
<script>
import axios from 'axios';
export default {
  data() {
    return {
      data: [],
      chart_data: []
    }
  },
  mounted() {
    this.fetchDeta()
    this.fetchchart()
  },
  methods: {
    fetchDeta() {
      axios
        .get(`/api/v1/tournaments/${this.$route.params.id}/watch_avg`)
        .then(response => {
          this.data = response.data.avgs
        })
    },
    fetchchart() {
      let attack = this.$refs.ma.textContent
      axios
        .get(`/api/v1/tournaments/${this.$route.params.id}/watch_avg`)
        .then(response =>{
          this.chart_data = [attack,attack,attack,attack,attack]
          // this.chart_data = [1,1,1,1,1]
          this.chart();
        })
    },
    chart() {
      // var attack = document.getElementsByClassName("avg-attack").textContent;
      var ctx = document.getElementById('RaderChart')
      var myChart = new Chart(ctx, {
        type: 'radar',
        data: {
          labels: ["攻撃力","守備力","投手力","総合力","期待度"],
          datasets: [{
            label: '戦力',
            data: this.chart_data,
            // data: [attack,attack,attack,attack,attack],
            // data: [1,1,1,1,1],
            backgroundColor: 'RGBA(225,95,150, 0.5)',
            borderColor: 'RGBA(225,95,150, 1)',
            borderWidth: 1,
            pointBackgroundColor: 'RGB(46,106,177)'
          }],
        },
        options: {
          title: {
            display: true,
          },
          layout: {
            padding: {
              left: 10,
            }
          },
          scale: {
            ticks: {
              suggestedMin: 0,
              suggestedMax: 5,
              stepSize: 1,
              callback: function(value,index,values){
                return value
              }
            }
          }
        }
      })
    }
  }
}
</script>