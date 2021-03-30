<template>
  <div class="tweet-comment">
    <div v-for="e in text" :key="e.id">
      {{e.comment}}
    </div>
    <modal name="comment-modal">
      <form @submit.prevent="createComment">
        <div v-if="errors.length != 0">
          <ul v-for="e in errors" :key="e">
            <li><font color="red">{{ e }}</font></li>
          </ul>
        </div>
        <div class="tweet-comment_form">
          <input v-model="comment.text" type="text">
        </div>
      <button type="submit" @click="registerModal">投稿する</button>
      </form>
    </modal>
    <button class="btn btn-primary my-2" @click="showModal(); resetForm()">コメント投稿</button>
  </div>
</template>
<script>
import axios from 'axios'

export default {
  data() {
    return {
      comment: {
        text: ''
      },
      text: [],
      errors: ''
    }
  },
  mounted() {
    this.fetchComments()
  },
  methods: {
    createComment: function() {
      axios
        .post(`/api/v1/tweets/${this.$route.params.id}/comments`,this.comment)
        .then(response => {
          let e = response.data;
        })
        .catch(error => {
          console.error(error);
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
        });
    },
    fetchComments() {
      axios
        .get(`/api/v1/tweets/${this.$route.params.id}/comments.json`)
        .then(response => {
          this.text = response.data
        })
    },
    showModal(){
      this.$modal.show('comment-modal');
    },
    registerModal(){
      this.$modal.hide('comment-modal');
    },
    resetForm(){
      this.comment.text = '';
    },
  }
}
</script>