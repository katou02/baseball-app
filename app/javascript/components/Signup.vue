<template>
  <div class="container">
    <div width="400px" class="mx-auto mt-5">
      <!-- <v-card-title> -->
        <h1 class="display-1">
          新規登録
        </h1>
      <!-- </v-card-title> -->
      <!-- <v-card-text> -->
        <v-form class="col" @submit.prevent="signup" lazy-validation>
          <div class="text-red" v-if="error">{{ error }}</div>
          <v-text-field label="ユーザー名" prepend-icon="mdi-user" v-model="name" required="required"/>
          <v-text-field label="メールアドレス" prepend-icon="mdi-email" v-model="email" required="required"/>
          <v-text-field label="パスワード" prepend-icon="mdi-lock" append-icon="mdi-eye-off" v-model="password" required="required"/>
          <v-text-field label="パスワード確認" prepend-icon="mdi-lock" append-icon="mdi-eye-off" v-model="password_confirmation" required="required"/>
          <v-card-actions>
            <v-btn type="submit" color="light-green darken-1" class="white--text">新規登録</v-btn>
            <div><router-link to="/signin" class="btn link-grey">ログインページへ</router-link></div>
          </v-card-actions>
        </v-form>
      <!-- </v-card-text> -->
    </div>
    <button @click="childEvent">閉じる</button>
  </div>
</template>

<script>
  export default {
    name: 'Signup',
    data() {
      return {
        name: '',
        email: '',
        password: '',
        password_confirmation: '',
        error: ''
      }
    },
    created() {
      this.checkSignedIn()
    },
    updated() {
      this.checkSignedIn()
    },
    methods: {
      signup() {
        this.$http.plain.post('/api/v1/signups', { nickname: this.name, email: this.email, password: this.password, password_confirmation: this.password_confirmation })
          .then(response => this.signupSuccessful(response))
          .catch(error => this.signupFailed(error))
      },
      signupSuccessful(response) {
        if (!response.data.csrf) {
          this.signupFailed(response)
          return
        }
        localStorage.csrf = response.data.csrf
        localStorage.signedIn = true
        this.$store.dispatch('doFetchSignedIn')
        this.error = ''
        this.$router.go({name: 'top'})
      },
      signupFailed(error) {
        this.error = (error.response && error.response.data && error.response.data.error) || 'Something went wrong'
        delete localStorage.csrf
        delete localStorage.signedIn
      },
      checkSignedIn() {
        if (localStorage.signedIn) {
          this.$router.replace('/')
        }
      },
      childEvent() {
        this.$emit('parent-event')
      }
    }
  }
</script>