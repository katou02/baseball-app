<template>
  <div class="container">
    <div width="700px" class="mx-auto mt-5">
      <!-- <v-card-title> -->
        <h1 class="display-1">
          ログイン
        </h1>
      <!-- </v-card-title> -->
      <!-- <v-card-text> -->
        <v-form class="col" @submit.prevent="signin" lazy-validation>
          <div class="text-red" style="color: red;" v-if="error">{{ error }}</div>
          <v-text-field label="メールアドレス" v-model="email" required="required" prepend-icon="mdi-email"/>
          <v-text-field label="パスワード" v-model="password" required="required" prepend-icon="mdi-lock"/>
          <v-card-actions><v-btn type="submit" class="white--text mx-auto" color="light-green darken-1">ログイン</v-btn></v-card-actions>
          <!-- <div><router-link to="/signup" class="btn link-grey">Sign Up</router-link></div> -->
        </v-form>
      <!-- </v-card-text> -->
    </div>
    <button @click="childEvent">閉じる</button>
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
    created() {
      this.checkSignedIn()
    },
    updated() {
      this.checkSignedIn()
    },
    methods: {
      signin() {
        this.$http.plain.post('/api/v1/signin', { email: this.email, password: this.password })
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
        this.$router.go({name: 'top'})
      },
      signinFailed(error) {
        this.error = (error.response && error.response.data && error.response.data.error) || ''
        delete localStorage.csrf
        delete localStorage.signedIn
      },
      checkSignedIn() {
        if (localStorage.signedIn) {
          this.$router.replace('/')
        }
      },
      childEvent() {
        this.$emit('parent-event2')
      }
    }
  }
</script>