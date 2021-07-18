<template>
  <div class="container">
    <v-btn v-if="(!$vuetify.breakpoint.xs && this.$route.path!='/') || (!$vuetify.breakpoint.xs && this.$route.path=='/') " color="primary" class="gest-btn" @click="signin">
      <v-icon color="white">mdi-login</v-icon>
      ゲストログイン
    </v-btn>
    <v-btn v-if="($vuetify.breakpoint.xs && this.$route.path=='/') || ($vuetify.breakpoint.xs && this.$route.path!='/')" color="primary" class="gest-btn" @click="signin">
      <v-icon color="white">mdi-login</v-icon>
      ゲスト
    </v-btn>
  </div>
</template>

<script>
  //動作は，Signupコンポーネントと同じ。
  export default {
    name: 'Signin',
    data() {
      return {
        email: '',
        password: '',
        error: ''
      }
    },
    methods: {
      signin() {
        this.$http.plain.post('/api/v1/signin', { email: 'gest@gmail.com', password: 'gest2021' })
          .then(response => this.signinSuccessful(response))
          .catch(error => this.signinFailed(error))
      },
      signinSuccessful(response) {
        if (!response.data.csrf) {
          this.signinFailed(response)
          return
        }
        localStorage.csrf = response.data.csrf
        localStorage.signedIn = true
        this.$store.dispatch('doFetchSignedIn')
        this.error = ''
        this.$router.go('/')
      },
      signinFailed(error) {
        this.error = (error.response && error.response.data && error.response.data.error) || ''
        delete localStorage.csrf
        delete localStorage.signedIn
      }
    }
  }
</script>