<template>
  <div class="average-content">
    <h2 class="pt-5 pb-5">戦力分析の平均評価</h2>
    <div class="search-area mt-5 mb-5">
      <v-text-field type="text" v-model="keyword" label="検索"></v-text-field>
    </div>
    <v-row class="mx-auto">
      <v-col cols="12"  sm="12" md="12" lg="12" v-for=" (e,index) in getLists" :key="e.id">
        <div class="avg-name text-center mt-3">{{e.name}}</div>
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
        <div id="canvas_wrapper" style="width:660px; height:590px;" >
          <canvas class="RaderChart"></canvas>
        </div>
      </v-col>
    </v-row>
    <div class="text-center">
      <paginate
        :v-model="currentPage" 
        :page-count="getPageCount"
        :click-handler="clickCallback"
        :page-range="3"
        :margin-pages="2"
        :prev-text="'＜'"
        :next-text="'＞'"
        :force-page="currentPage"
        :hide-prev-next="true"
        :next-link-class="'page-link'"
        :prev-link-class="'page-link'"
        :container-class="'pagination'"
        :page-link-class="'page-link'">
      </paginate>
    </div>
  </div>
</template>
<script>
import axios from 'axios';
export default {
  data() {
    return {
      keyword: '',
      data: [],
      chart_data: [],
      currentPage: 1,
      parPage: 10
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
    clickCallback(pageNum) {
      this.currentPage = Number(pageNum);
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
  },
  computed: {
    getAverage: function() {
      let averages = [];
      for(let i in this.data) {
        let avg = this.data[i];
        if( avg.name.indexOf(this.keyword) !== -1) {
          averages.push(avg);
        }
      }
      return averages
    },
    getLists: function() {
    let current = this.currentPage * this.parPage;
    let start = current - this.parPage;
     return this.getAverage.slice(start, current);
    // return this.$store.state.tweets.slice(start,current)
    },
    getPageCount: function() {
      return Math.ceil(this.getAverage.length / this.parPage);
    }
  },
  watch: {
    keyword: function(){
      this.currentPage = 1;
    }
  }
}
</script>