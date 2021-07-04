<template>
  <div class="game-article">
    <div class="data-info">
      <div class="d-flex">
        <div v-if="forecast.user_id==forecast.current_user || forecast.admin==true">
          <!-- <button class="delete-btn" @click="onAlert">記事を削除する</button> -->
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
                <v-btn color="green darken-1" text @click="deleteForecast($route.params.id)">はい</v-btn>
                <v-btn color="green darken-1" text @click="dialog = false">キャンセル</v-btn>
              </v-card-actions>
            </v-card>
          </v-dialog>
          <!-- <router-link :to="{name: 'forecast-edit',params: {id: forecast.id}}" class="edit text-white p-2">記事を編集する</router-link> -->
          <button class="edit text-white p-1" @click="openModal">記事を編集する</button>
        </div>
        <router-link :to="{name: 'forecast'}" class="return-btn text-white pt-1">記事一覧へ戻る</router-link>
      </div>
      <div class="post-user-name">
        <div v-if="forecast.current_user"><h5>投稿者:<router-link :to="{name: 'user-show',params: {id: forecast.user_id}}">{{forecast.nickname}}</router-link></h5></div>
        <div v-else><h5>投稿者:未ログインにより非表示</h5></div>
        <div v-if="user_image"> 
          <img :src= user_image class="user-icon mt-1 mb-5">
        </div>
        <div v-else>
          <img src="../assets/images/no-image.png" class="user-icon mt-1 mb-5">
        </div>
      </div>
      <p class="text-right">{{forecast.time}}</p>
      <div class="game-result mt-5">
        {{forecast.tournament}}
      </div>
      <div class="text-format text-danger">
        <i class="fas fa-fire mt-5 mb-5">試合予想</i>
      </div>
      <div class="data-title mt-5 ml-5">
        勝敗予想
      </div>
      <div class="text-format mt-5">{{forecast.round}}</div>
      <div class="school-fcs">
        <div class="win-school text-danger">
          <p>勝利予想<p>
          <br>
          <div class="win">{{forecast.win_school}}</div>
        </div>
        <div class="lose-school text-info">
          <p>敗退予想<p>
          <br>
          <div class="lose">{{forecast.lose_school}}</div>
        </div>
      </div>
      <div class="data-title mt-5 ml-5">
        考察
      </div>
      <div class="fcs-text ml-5 mt-5">
        <p style="white-space:pre-wrap;">{{forecast.text}}</p>
      </div>
      <div class="data-title mt-5 ml-5">
        勝利確率
      </div>
      <div class="pie mt-5 pb-5">
        <div style="width:60%; height:60%"><canvas id="PieChart"></canvas></div>
      </div>
      <div class="comment-content-common">
        <div class="text-format mt-0 mb-4 text-warning">
          <i class="fa fa-baseball-ball text-warning"></i>
          コメント
        </div>
        <div v-for="e in comment" :key="e.id">
          <div class="comment-user text-center">
            <em class="pr-4">{{e.comment_nickname}}</em>
            {{e.time}}
            <span v-if="forecast.current_user==e.user_id"><button class="comment-delete_button" @click="onAlertComment(e.id)">削除</button></span>
          </div>
          <div class="mt-4 mb-4 text-center" style="white-space:pre-wrap;">{{e.comment}}</div>
        </div>
        <div v-if="forecast.current_user">
          <div class="comment-form">
            <form @submit.prevent="createComment">
            <div  v-if="errors.length != 0">
              <ul v-for="e in errors" :key="e">
                <li><font color="red">{{ e }}</font></li>
              </ul>
            </div>
            <div class="text-center">
              <v-textarea solo v-model="text" type="text" rows="2" cols="30"></v-textarea>
              <p v-if="!!errors['text']" style="color: red;">{{ errors['text'][0]}}</p>
              <v-btn small type="submit" color="info" class="text-center">投稿する</v-btn>
            </div>
            </form>
          </div>
        </div>
      </div>
    </div>
    <modal name="select" height="auto" width="65%" :scrollable="true">
      <div id="modal">
        <Edit @parent-event="fetchForecasts"></Edit>
        <button @click="closeModal">閉じる</button>
      </div>
    </modal>
  </div>
</template>
<script>
import axios from 'axios'
import Edit from './components/ForecastEdit.vue'
export default {
  components: {
    Edit
  },
  data() {
    return {
      forecast: [],
      comment: "",
      text: "",
      errors: "",
      chart_data: '',
      labels: [],
      probability: '',
      user_image: '',
      dialog: false
    }
  },
  mounted() {
    this.fetchForecasts()
    this.fetchComments()
    this.fetchchart()
  },
  methods: {
    fetchForecasts() {
      this.fetchchart()
      this.closeModal()
      axios
        .get(`/api/v1/forecasts/${this.$route.params.id}.json`)
        .then(response =>{
          this.forecast = response.data
          this.user_image = response.data.user_image.url
        })
    },
    deleteForecast(id) {
      axios.delete(`/api/v1/forecasts/${id}`).then(response => {
        this.$router.push({ name: 'forecast' });
      })
    },
    fetchComments() {
      axios
        .get(`/api/v1/forecasts/${this.$route.params.id}/comment_forecasts`)
        .then(response => {
          this.comment = response.data
        })
      this.errors = ''
    },
    createComment: function() {
      axios
        .post(`/api/v1/forecasts/${this.$route.params.id}/comment_forecasts`,{text: this.text})
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
      axios.delete(`/api/v1/forecasts/${id}/comment_forecasts/${id}`).then(response => {
        this.fetchComments();
      })
    },
    fetchchart() {
      axios
        .get(`/api/v1/forecasts/${this.$route.params.id}.json`)
        .then(response =>{
          this.chart_data = response.data.probability
          this.labels = [response.data.win_school,response.data.lose_school]
          this.probability = response.data.probability
          this.chart();
          if(!response.data.current_user && this.$store.state.signedIn == true) {
            delete localStorage.csrf
            delete localStorage.signedIn
            this.$router.go(`/forecasts/${this.$route.params.id}`)
          }
        })
    },
    chart() {
      var ctx = document.getElementById("PieChart");
      window.PieChart = new Chart(ctx, {
        type: 'pie',
        data: {
          labels: this.labels,
          datasets: [{
            backgroundColor: [
              "#FF0000",
              "#33CCFF",
            ],
            data: [this.probability,100-this.probability]
          }]
        },
        options: {
          title: {
            display: true,
            text: '勝利確率'
          }
        }
      });
    },
    // onAlert:function(){
    //   this.$dialog
    //   var rt =confirm(
    //   '削除してもよろしいですか？'
    //   )
    //   if(rt==true) {
    //     this.deleteForecast(this.$route.params.id)
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
    },
    openModal(){
      this.$modal.show('select');
    },
    closeModal(){
      this.$modal.hide('select');
    },
  }
}
</script>