<template>
  <div class="contact">
    <div class="contact-main text-center pt-2">
      <h2>お問い合わせ</h2><br>
      問い合わせ・要望などを送信できます
      <form v-on:submit="$router.push('/tweet')">
        <div class="contact-user-input mt-5">
          <div class="contact-name">
            名前
            <input type="text" placeholder='20文字以内' v-model="name">
          </div>
          <div class="contact-mail mt-4">
            メールアドレス
            <input type="text" placeholder='30文字以内' v-model="email">
          </div>
          <div class="contact-message mt-4">
            問い合わせ内容
            <textarea placeholder="1000文字以内" v-model="text"></textarea>
          </div>
        </div>
      </form>
    </div>
    <div class="contact-sent mb-5">
      <router-link :to="{name: 'contact-check',params: {name: this.name,email: this.email,text: this.text}}" class="btn btn-warning">確認する</router-link>
    </div>
  </div>
</template>
<script>
export default {
  data() {
    return {
      name: '',
      email: '',
      text: ''
    }
  }
}
</script>