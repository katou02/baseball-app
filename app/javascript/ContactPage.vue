<template>
  <div class="contact">
    <form @submit.prevent="sendMail">
      <div class="contact-main text-center pt-2">
        <h2>お問い合わせ</h2><br>
        問い合わせ・要望など
        <div class="contact-user-input mt-5">
          <v-text-field type="text" label='名前' v-model="name"></v-text-field>
          <p v-if="!!errors['name']" style="color: red;">{{ errors['name'][0]}}</p>
          <v-text-field type="text" label='メールアドレス' v-model="email" class="mt-4"></v-text-field>
          <p v-if="!!errors['email']" style="color: red;">{{ errors['email'][0]}}</p>
          <v-textarea placeholder="問い合わせ内容" v-model="text" outlined class="mt-4"></v-textarea>
          <p v-if="!!errors['content']" style="color: red;">{{ errors['content'][0]}}</p>
        </div>
        <v-btn color="warning" type="submit" dark>送信する
        </v-btn>
      </div>
    </form>
  </div>
</template>
<script>
import axios from 'axios'
export default {
  data() {
    return {
      name: null,
      email: null,
      text: null,
      loading: false,
      errors: []
    }
  },
  methods: {
    sendMail() {
      axios
        .post('/api/v1/contacts/check',{name: this.name,email: this.email,content: this.text})
        .then(response => {
          alert('送信完了 お問い合わせありがとうございました')
          this.$router.go({ name: 'contact'})
        })
        .catch(error => {
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
        });
    }
  },
  watch: {
    loader () {
      const l = this.loader
      this[l] = !this[l]

      setTimeout(() => (this[l] = false), 3000)

      this.loader = null
    },
  }
}
</script>