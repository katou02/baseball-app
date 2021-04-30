<template>
<div class="game-article">
  <div class="data-info"> 
    <div class="d-flex">
      <div v-if="tweet.user_id==tweet.current_user">
        <button class="delete-btn" @click="deleteTweet(tweet.id)">記事を削除する</button>
        <!-- <a :href= "'/tweets/' + tweet.id + '/edit'" class="edit-article">記事を編集する</a> -->
        <router-link :to="{name: 'tweet-edit',params: {id: tweet.id}}" class="edit-article text-white p-2">記事を編集する</router-link>
      </div>
      <router-link :to="{name: 'tweet'}" class="return-btn text-white">記事一覧へ戻る</router-link>
      <!-- <a :href= "'/tweets'" class="return-btn">記事一覧へ戻る</a> -->
    </div>
    <div class="user_name">
      <h5>投稿者:<a :href= "'/users/' + tweet.user_id">{{tweet.nickname}}</a></h5>
       <div v-if="user_image"> 
         <img :src= user_image class="user-icon mt-1 mb-5">
       </div>
       <div v-else>
        <img src="../assets/images/no-image.png" class="user-icon mt-1 mb-5">
       </div>
    </div>
    <div class="game_result">
      {{tweet.tournament}}<br><br>
      {{tweet.school_a}}
      {{tweet.school_a_score}}
      -
      {{tweet.school_b_score}}
      {{tweet.school_b}}
    </div>

    <div class="sub_title pb-2 mt-5">
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
    <!-- コメント -->
    <div class="comment-content_common">
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
          <div class="tweet-comment_form text-center">
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
export default {
  data() {
    return {
      comment: "",
      text: "",
      tweet: [],
      errors: '',
      user_image: '',
      tweet_image: ''
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
          this.user_image = response.data.user_image.url
          this.tweet_image = response.data.tweet_image.url
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
        // .post(`/api/v1/tweets/${this.$route.params.id}/comments`,this.comment)
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
    }
  }
}
</script>
<style scoped>
.good {
  background-color: #e91e63;
  border-color: #e91e63;
  color: white;
  font-weight: bold;
  border-radius: 5px;
}

.like-count {
  padding: 5px 7px;
  color: #2196f3;
}
</style>