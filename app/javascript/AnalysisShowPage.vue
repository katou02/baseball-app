<template>
  <div class="analysis-show_content">
    <div class="data-info pb-5">
      <div class="d-flex">
        <div v-if="analysis.user_id==analysis.current_user">
          <button class="delete-btn" @click="deleteAnalysis(analysis.id)">記事を削除する</button>
          <a :href= "'/analyses/' + analysis.id + '/edit'" class="edit-article">記事を編集する</a>
        </div>
        <router-link :to="{name: 'analysis'}" class="return-btn">記事一覧へ戻る</router-link>
      </div>
      <div class="user_name">
        <h5>投稿者:<a :href= "'/users/' + analysis.user_id">{{analysis.nickname}}</a></h5>
        <div v-if="analysis.user_image.url"> 
          <img :src= analysis.user_image.url class="user-icon mt-1 mb-5">
        </div>
        <div v-else>
          <img src="../assets/images/no-image.png" class="user-icon mt-1 mb-5">
        </div>
      </div>

      <div class="content-fcs_show">
        <div class="game_result mt-5">
          {{analysis.tournament}}
        </div>
        <div class="text-format mt-1 text-info">
          <i class="fas fa-search mt-5">分析内容</i>
        </div>
        <div class="sub_title text-white mt-5">
          <i class="fa fa-baseball-ball"></i>
          {{analysis.title}}
        </div>
        <div class="school_name-ays">
          {{analysis.school}}
        </div>
        <div class="data-title mt-5 ml-5">
          分析詳細
        </div>
        <div class="ays-text mt-5 ml-5">
          <p style="white-space:pre-wrap;">{{analysis.text}}</p>
        </div>
        <div class="data-title mt-5 ml-5">
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
    <div class="comment-content">
      <div class="text-format mt-0 mb-4 text-warning">
        <i class="fa fa-baseball-ball text-warning"></i>
        コメント
      </div>
      <div v-for="e in comment" :key="e.id">
        <div class="comment-user text-center">
          <em class="pr-4">{{e.comment_nickname}}</em>
          {{e.time}}
          <button class="comment-delete_button" @click="deleteComment(e.id)">削除</button><br>
        </div>
        <div class="mt-4 mb-4 text-center" style="white-space:pre-wrap;">{{e.comment}}</div>
      </div>
      <div class="comment-form">
        <form @submit.prevent="createComment">
          <div  v-if="errors.length != 0">
            <ul v-for="e in errors" :key="e">
              <li><font color="red">{{ e }}</font></li>
            </ul>
          </div>
          <div class="tweet-comment_form">
            <!-- <textarea v-model="comment.text" type="text" rows="2" cols="30"></textarea> -->
            <textarea v-model="text" type="text" rows="2" cols="30"></textarea>
          </div>
        <button type="submit" class="game_record" >投稿する</button>
        </form>
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
      chart_data: []
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
    }
  }
}
</script>