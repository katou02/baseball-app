<template>
  <div class="analysis-show_content">
    <div class="data-info pb-5">
      <div class="d-flex">
        <div v-if="analysis.user_id==analysis.current_user || analysis.admin==true">
          <!-- <button class="delete-btn" @click="onAlert()">記事を削除する</button> -->
          <v-dialog v-model="dialog" persistent max-width="290">
            <template v-slot:activator="{ on, attrs }">
              <button class="delete-btn text-white" v-bind="attrs" v-on="on">
                記事を削除する
              </button>
            </template>
            <v-card>
              <v-card-title class="headline">本当に削除しますか?</v-card-title>
              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn color="green darken-1" text @click="deleteAnalysis($route.params.id)">はい</v-btn>
                <v-btn color="green darken-1" text @click="dialog = false">キャンセル</v-btn>
              </v-card-actions>
            </v-card>
          </v-dialog>
          <router-link :to="{name: 'analysis-edit',params: {id: analysis.id}}" class="edit text-white p-2">記事を編集する</router-link>
        </div>
        <router-link :to="{name: 'analysis'}" class="return-btn text-white">記事一覧へ戻る</router-link>
      </div>
      <div class="user_name">
        <h5>投稿者:<router-link :to="{name: 'user-show',params: {id: analysis.user_id}}">{{analysis.nickname}}</router-link></h5>
        <div v-if="user_image"> 
          <img :src= user_image class="user-icon mt-1 mb-5">
        </div>
        <div v-else>
          <img src="../assets/images/no-image.png" class="user-icon mt-1 mb-5">
        </div>
      </div>
      <p class="text-right">{{analysis.time}}</p>
      <div class="content-fcs_show">
        <div class="game_result mt-5">
          {{analysis.tournament}}
        </div>
        <div class="school_name-ays">
          {{analysis.school}}
        </div>
        <div class="sub_title text-white mt-5">
          <i class="fa fa-baseball-ball"></i>
          {{analysis.title}}
        </div>
        <div class="data-title ml-5">
          <i class="fas fa-search">分析詳細</i>
        </div>
        <div class="ays-text mt-5 ml-5">
          <p style="white-space:pre-wrap;">{{analysis.text}}</p>
        </div>
        <div class="data-title ml-5">
          戦力
        </div>
        <div class="select_main-show mt-5">    
          <p class="font">攻撃力</p>
          <div class="attack_i">{{analysis.attack}}</div>
          <p class="font">守備力</p>
          <div class="defensive_i">{{analysis.defensive}}</div>
          <p class="font">投手力</p>
          <div class="pitcher_i">{{analysis.pitcher}}</div>
          <p class="font">総合力</p>
          <div class="comprehensive_i">{{analysis.comprehensive}}</div>
          <p class="font">期待度</p>
          <div class="expectations_i">{{analysis.expectations}}</div>
        </div>
      </div>
       <div class="reader">
         <div style="width:70%; height:70%;" ><canvas id="myChart"></canvas></div>
       </div>
    </div>
    <div class="comment-content_common">
      <div class="text-format mt-0 mb-4 text-warning">
        <i class="fa fa-baseball-ball text-warning"></i>
        コメント
      </div>
      <div v-for="e in comment" :key="e.id">
        <div class="comment-user text-center">
          <em class="pr-4">{{e.comment_nickname}}</em>
          {{e.time}}
          <span v-if="analysis.current_user==e.user_id"><button class="comment-delete_button" @click="onAlertComment(e.id)">削除</button></span>
        </div>
        <div class="mt-4 mb-4 text-center" style="white-space:pre-wrap;">{{e.comment}}</div>
      </div>
      <div v-if="analysis.current_user">
        <div class="comment-form">
          <form @submit.prevent="createComment">
            <div  v-if="errors.length != 0">
              <ul v-for="e in errors" :key="e">
                <li><font color="red">{{ e }}</font></li>
              </ul>
            </div>
            <div class="text-center">
              <v-textarea solo v-model="text" type="text" rows="2" cols="30"></v-textarea>
              <v-btn small type="submit" color="info" class="text-center">投稿する</v-btn>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
import { Radar } from 'vue-chartjs'
export default {
  extends: Radar,
  data() {
    return {
      analysis: [],
      comment: "",
      text: "",
      errors: '',
      chart_data: [],
      user_image: '',
      dialog: false,
    }
  },
  mounted() {
    this.fetchAnalysis()
    this.fetchComments()
    this.fetchchart()
  },
  methods: {
    fetchAnalysis() {
      axios
        .get(`/api/v1/analyses/${this.$route.params.id}.json`)
        .then(response =>{
          this.analysis = response.data;
          this.user_image = response.data.user_image.url
        })
    },
    fetchComments() {
      axios
        .get(`/api/v1/analyses/${this.$route.params.id}/comment_analyses`)
        .then(response => {
          this.comment = response.data
        })
    },
    deleteAnalysis(id) {
      axios.delete(`/api/v1/analyses/${id}`).then(response => {
        this.$router.push({ name: 'analysis' });
      })
    },
   createComment: function() {
      axios
        .post(`/api/v1/analyses/${this.$route.params.id}/comment_analyses`,{text: this.text})
        .then(response => {
          this.text = "";
          this.fetchComments()
        })
        .catch(error => {
          console.error(error);
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
        });
    },
    deleteComment(id) {
      axios.delete(`/api/v1/analyses/${id}/comment_analyses/${id}`).then(response => {
        this.fetchComments();
      })
    },
    fetchchart() {
      axios
        .get(`/api/v1/analyses/${this.$route.params.id}.json`)
        .then(response =>{
          this.chart_data = [response.data.attack,response.data.defensive,response.data.pitcher,response.data.comprehensive,response.data.expectations]
          this.chart();
        })
    },
    chart() {
      var ctx = document.getElementById('myChart')
      var myChart = new Chart(ctx, {
        type: 'radar',
        data: {
          labels: ["攻撃力","守備力","投手力","総合力","期待度"],
          datasets: [{
            label: '戦力',
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
    },
    // onAlert:function(){
    //   this.$dialog
    //   var rt =confirm(
    //   '削除してもよろしいですか？'
    //   )
    //   if(rt==true) {
    //     this.deleteAnalysis(this.$route.params.id)
    //   }
    // },
    onAlertComment(id){
      this.$dialog
      var rt =confirm(
      '削除してもよろしいですか？'
      )
      if(rt==true) {
        this.deleteComment(id)
      }
    }
  }
}
</script>