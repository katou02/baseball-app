<template>
  <div class="tweet-comment">
    <form @submit.prevent="createComment">
      <div v-if="errors.length != 0">
        <ul v-for="e in errors" :key="e">
          <li><font color="red">{{ e }}</font></li>
        </ul>
      </div>
      <div class="tweet-comment_form">
        <input v-model="comment.text" type="text">
      </div>
    </form>
  <button type="submit">Commit</button>
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
      errors: ''
    }
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
    }
  }
}
</script>