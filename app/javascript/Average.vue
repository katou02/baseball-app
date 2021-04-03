<template>
  <div class="average-content">
    <h3>戦力分析の平均評価</h3>
    <div v-for=" (e,index) in data" :key="e.id">
      <div class="avg-name text-center">{{e.name}}</div>
      <div class="data-title mt-3 ml-5">
        戦力
      </div>
      <div class="average">
        <p class="avg-font">攻撃力<p>
        <div class="avg-attack">{{Math.floor(e.attack_num)}}</div>
        <p class="avg-font">守備力<p>
        <div class="avg-defense">{{Math.floor(e.defense_num)}}</div>
        <p class="avg-font">投手力<p>
        <div class="avg-pitch">{{Math.floor(e.pitch_num)}}</div>
        <p class="avg-font">総合力<p>
        <div class="avg-total">{{Math.floor(e.total_num)}}</div>
        <p class="avg-font">期待度</p>
        <div class="avg-expec">{{Math.floor(e.expectations_num)}}</div>
      </div>
      {{fetchchart(index)}}
      <div style="width:900px; height:500px;" >
        <canvas class="RaderChart"></canvas>
      </div>
    </div>
  </div>
</template>
<script>
import axios from 'axios';
export default {
  data() {
    return {
      data: [],
      chart_data: [],
    }
  },
  mounted() {
    this.fetchDeta()
    // this.fetchchart()
  },
  methods: {
    fetchDeta() {
      // let aa = document.getElementsByClassName('avg-attack')
      axios
        .get(`/api/v1/tournaments/${this.$route.params.id}/watch_avg`)
        .then(response => {
          this.data = response.data.avgs
        })
    },
    fetchchart(num) {
      axios
        .get(`/api/v1/tournaments/${this.$route.params.id}/watch_avg`)
        .then(response =>{
          // alert(num)
          this.chart_data = [Math.floor(response.data.avgs[num].attack_num),Math.floor(response.data.avgs[num].defense_num),Math.floor(response.data.avgs[num].pitch_num),Math.floor(response.data.avgs[num].total_num),Math.floor(response.data.avgs[num].expectations_num)]
          this.chart(num);
        })
    },
    chart(index) {
      for (let num = 0; num <= 1; num++) {
        let ctx = document.getElementsByClassName("RaderChart")[index];
        let myChart = new Chart(ctx, {
          type: 'radar',
          data: {
            labels: ["攻撃力","守備力","投手力","総合力","期待度"],
            datasets: [{
              label: '戦力',
              // data: this.chart_data,
              // data: [attack,attack,attack,attack,attack],
              data: this.chart_data,
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
}
</script>