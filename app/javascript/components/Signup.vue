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
          <v-text-field label="ユーザー名(10文字以内)" prepend-icon="mdi-user" v-model="name" required="required"/>
          <p v-if="!!errors['nickname']" style="color: red;">{{ errors['nickname'][0]}}</p>
          <v-text-field label="メールアドレス" prepend-icon="mdi-email" v-model="email" required="required"/>
          <p v-if="!!errors['email']" style="color: red;">{{ errors['email'][0]}}</p>
          <v-text-field label="パスワード" :type="'password'" prepend-icon="mdi-lock" append-icon="mdi-eye-off" v-model="password" required="required"/>
          <p v-if="!!errors['password']" style="color: red;">{{ errors['password'][0]}}</p>
          <v-text-field label="パスワード確認" :type="'password'" prepend-icon="mdi-lock" append-icon="mdi-eye-off" v-model="password_confirmation" required="required"/>
          <p v-if="!!errors['password_confirmation']" style="color: red;">{{ errors['password_confirmation'][0]}}</p>
          <v-card-actions>
            <v-btn type="submit" color="light-green darken-1" class="white--text mx-auto">新規登録</v-btn>
            <!-- <div><router-link to="/signin" class="btn link-grey">ログインページへ</router-link></div> -->
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
        errors: ''
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
          // .catch(error => this.signupFailed(error))
        .catch(error => {
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
        });
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