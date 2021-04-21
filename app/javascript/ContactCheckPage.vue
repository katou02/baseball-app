<template>
  <div class="contact">
    <form @submit.prevent="sendMail">
      <div class="contact-main text-center pt-2">
        <h2>内容確認</h2>
        <div class="contact-check mt-5">
          <div class="contact-check-name mt-2">
            <!-- 名前 -->
            {{name}}
          </div>
          <div class="contact-check-mail mt-5">
            <!-- メールアドレス -->
            {{email}}
          </div>
          <div class="contact-check-message mt-4">
            <!-- 内容 -->
            {{text}}
          </div>
        </div>
      </div>
      <div class="contact-sent mt-5">
        <button type="submit" class="btn btn-warning">送信する</button>
      </div>
    </form>
  </div>
</template>
<script>
import axios from 'axios';
export default {
  props: ['name','email','text'],
  data() {
    return {
      sender: this.name,
      mail: this.email,
      content: this.text
    }
  },
  methods: {
    sendMail() {
      axios
        .post('/api/v1/contacts/check',{name: this.sender,email: this.mail,content: this.content})
        .then(response => {
          alert('送信完了 お問い合わせありがとうございました')
          this.$router.push({ name: 'contact'})
        })
    }
  }
}
</script>