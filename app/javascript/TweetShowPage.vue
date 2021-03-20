<template>
<div class="game-article">
  <button class="delete-btn" @click="deleteTweet(tweet.id)">削除まんこ</button>
  <div class="data-info">
    <div class="user_name">
      <h5>投稿者:<a :href= "'/users/' + tweet.user_id">{{tweet.nickname}}</a></h5>
       <div v-if="tweet.user_image.url"> 
         <img :src= tweet.user_image.url class="user-icon mt-1 mb-5">
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
    <img :src= tweet.tweet_image.url class="image">
    <!-- いいね -->
    <!-- <div v-if="isLiked" @click="deleteLike()">
      いいねを取り消す {{ count }}
    </div>
    <div v-else @click="registerLike()">
      いいねする {{ count }}
    </div> -->
    <!-- コメント -->
    <div class="comment-content_tweet">
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
</div>
</template>
<script>
import axios from 'axios'
// import { csrfToken } from 'rails-ujs'
// axios.defaults.headers.common['X-CSRF-TOKEN'] = csrfToken()
export default {
  // props: ['userId', 'tweetId'],
  data() {
    return {
      likeList: [] ,
      comment: "",
      text: "",
      tweet: [],
      errors: ''
    }
  },
  mounted() {
    this.fetchTweets()
    this.fetchComments()
  },
  //いいね
  // computed: {
  //   count() {
  //     return this.likeList.length
  //   },
  //   isLiked() {
  //     if (this.likeList.length === 0) { return false }
  //     return Boolean(this.findLikeId())
  //   }
  // },
  // created: function() {
  //   this.fetchLikeByTweetId().then(result => {
  //     this.likeList = result
  //   })
  // },
  //いいね
  methods: {
    fetchTweets() {
      axios
        .get(`/api/v1/tweets/${this.$route.params.id}.json`)
        .then(response =>{
          this.tweet = response.data;
        })
    },
    deleteTweet(id) {
      axios.delete(`/api/v1/tweets/${id}`).then(response => {
        // alert("クンニ")
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
//いいね
    // fetchLikeByTweetId: async function() {
    //     const res = await axios.get(`/api/v1/tweets/${this.$route.params.id}/likes`)
    //   if (res.status !== 200) { process.exit() }
    //   return res.data
    // },
    // registerLike: async function() {
    //     const res = await axios.post(`/api/v1/tweets/${this.$route.params.id}/likes`, { tweet_id: this.$route.params.id})
    //   if (res.status !== 201) { process.exit() }
    //   this.fetchLikeByPostId().then(result => {
    //       this.likeList = result
    //   })
    // },
    // deleteLike: async function() {
    //   const likeId = this.findLikeId()
    //   const res = await axios.delete(`/api/v1/tweets/${this.$route.params.id}/likes/${likeId}`)
    //   if (res.status !== 200) { process.exit() }
    //   this.likeList = this.likeList.filter(n => n.id !== likeId)
    // },
    // findLikeId: function() {
    //     const like = this.likeList.find((like) => {
    //         return (like.user_id === this.userId)
    //   })
    //   if (like) { return like.id }
    // }
  }
}
</script>