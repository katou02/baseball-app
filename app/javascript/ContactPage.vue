<template>
  <div class="contact">
    <form @submit.prevent="sendMail">
      <div class="contact-main text-center pt-2">
        <h2>お問い合わせ</h2><br>
        問い合わせ・要望などを送信できます
        <div class="contact-user-input mt-5">
          <div class="contact-name">
            名前
            <input type="text" placeholder='20文字以内' v-model="name">
            <p v-if="!!errors['name']" class="error" style="color: red;">{{ errors['name'][0]}}</p>
          </div>
          <div class="contact-mail mt-4">
            メールアドレス
            <input type="text" placeholder='30文字以内' v-model="email">
            <p v-if="!!errors['email']" class="error" style="color: red;">{{ errors['email'][0]}}</p>
          </div>
          <div class="contact-message mt-4">
            問い合わせ内容
            <textarea placeholder="1000文字以内" v-model="text"></textarea>
            <p v-if="!!errors['content']" class="error" style="color: red;">{{ errors['content'][0]}}</p>
          </div>
        </div>
      </div>
      <div class="contact-sent mb-5">
        <button type="submit" class="btn btn-warning">送信する</button>
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
  }
}
</script>