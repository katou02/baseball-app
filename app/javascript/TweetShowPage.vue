<template>
<div class="game-article">
  <div class="data-info"> 
    <div class="d-flex">
      <div v-if="tweet.user_id==tweet.current_user || tweet.admin==true">
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
              <v-btn color="green darken-1" text @click="deleteTweet($route.params.id)">はい</v-btn>
              <v-btn color="green darken-1" text @click="dialog = false">キャンセル</v-btn>
            </v-card-actions>
          </v-card>
        </v-dialog>
        <router-link :to="{name: 'tweet-edit',params: {id: tweet.id}}" class="edit text-white p-2">記事を編集する</router-link>
      </div>
      <router-link :to="{name: 'tweet'}" class="return-btn text-white">記事一覧へ戻る</router-link>
    </div>
    <div class="post-user-name">
      <div v-if="tweet.current_user"><h5>投稿者:<router-link :to="{name: 'user-show',params: {id: user}}">{{tweet.nickname}}</router-link></h5></div>
      <div v-else><h5>投稿者:未ログインにより非表示</h5></div>
      <div v-if="user_image"> 
        <img :src= user_image class="user-icon mt-1 mb-5">
      </div>
      <div v-else>
      <img src="../assets/images/no-image.png" class="user-icon mt-1 mb-5">
      </div>
    </div>
    <p class="text-right">{{tweet.time}}</p>
    <div class="game-result">
      {{tweet.tournament}}<br><br>
      {{tweet.round}}<br>
      {{tweet.school_a}}
      {{tweet.school_a_score}}
      -
      {{tweet.school_b_score}}
      {{tweet.school_b}}
    </div>

    <div class="show-title pb-2 mt-5">
      <i class="fa fa-baseball-ball text-white"></i>
      {{tweet.title}}
    </div>

    <div class="text-format mt-5 text-info">
      <i class="fas fa-pen text-info"></i>
      試合評・感想<br><br>
    </div>
    <div class=show-text>
       <p style="white-space:pre-wrap;">{{tweet.text}}</p>
    </div>
    <img :src= tweet_image class="image">
    <!-- いいね -->
    <div v-if="tweet.current_user">
      <div v-if="tweet.like">
        <div class="d-flex align-center ml-2">
          <button class="good" @click="deleteLike()">
            <i class="fas fa-heart" style="color:white;"></i>
            いいね取り消し
          </button> 
          <span class="like-count">{{tweet.like_count}}</span>
        </div>
      </div>
      <div v-else>
        <div class="d-flex align-center ml-2">
          <button class="good" @click="registerLike()">
            <i class="fas fa-heart" style="color:white;"></i>
            いいね！
          </button> 
          <span class="like-count">{{tweet.like_count}}</span>
        </div>
      </div>
    </div>
      <!-- コメント -->
    <div class="comment-content-common">
      <div class="text-format mt-0 mb-4 text-warning">
        <i class="fa fa-baseball-ball text-warning"></i>
        コメント
      </div>
      <div v-for="e in comment" :key="e.id">
        <div class="comment-user">
          <em class="pr-4">{{e.comment_nickname}}</em>
          {{e.time}}
          <span v-if="tweet.current_user==e.user_id"><button class="comment-delete_button" @click="onAlertComment(e.id)">削除</button></span>
        </div>
        <div class="mt-4 mb-4 text-center" style="white-space:pre-wrap;">{{e.comment}}</div>
      </div>
      <div v-if="tweet.current_user">
        <div class="comment-form">
          <form @submit.prevent="createComment">
            <!-- <div  v-if="errors.length != 0">
              <ul v-for="e in errors" :key="e">
                <li><font color="red">{{ e }}</font></li>
              </ul>
            </div> -->
            <div class="tweet-comment_form text-center">
              <v-textarea solo v-model="text" type="text"></v-textarea>
              <v-btn small type="submit" color="info" class="text-center">投稿する</v-btn>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</div>
</template>
<script>
import axios from 'axios'
export default {
  data() {
    return {
      comment: "",
      text: "",
      tweet: [],
      user: '',
      errors: '',
      user_image: '',
      tweet_image: '',
      dialog: false,
    }
  },
  mounted() {
    this.fetchTweets()
    this.fetchComments()
  },
  methods: {
    fetchTweets() {
      axios
        .get(`/api/v1/tweets/${this.$route.params.id}.json`)
        .then(response =>{
          this.tweet = response.data
          this.user = response.data.user_id
          this.user_image = response.data.user_image.url
          this.tweet_image = response.data.tweet_image.url
          if(!response.data.current_user && this.$store.state.signedIn == true) {
            delete localStorage.csrf
            delete localStorage.signedIn
            this.$router.go(`/tweets/${this.$route.params.id}`)
          }
        })
    },
    deleteTweet(id) {
      axios.delete(`/api/v1/tweets/${id}`).then(response => {
        this.$router.push({ name: 'tweet' });
      })
    },
    //コメント
    fetchComments() {
      axios
        .get(`/api/v1/tweets/${this.$route.params.id}/comments`)
        .then(response => {
          this.comment = response.data
        })
    },
    createComment: function() {
      axios
        .post(`/api/v1/tweets/${this.$route.params.id}/comments`,{text: this.text})
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
      axios.delete(`/api/v1/tweets/${id}/comments/${id}`).then(response => {
        this.fetchComments();
      })
    },
    registerLike() {
      axios
        .post(`/api/v1/tweets/${this.$route.params.id}/likes`)
        .then(response =>{
          this.fetchTweets()
          this.fetchComments()
        })
    },
    deleteLike() {
      axios
        .delete(`/api/v1/tweets/${this.$route.params.id}/likes/${this.tweet.like.id}`)
        .then(response =>{
          this.fetchTweets()
          this.fetchComments()
        })
    },
    onAlertComment(id){
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