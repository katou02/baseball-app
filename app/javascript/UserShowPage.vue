<template>
  <div class="mypage-content pt-3">
    <a :href= "'/'" class="return-top">トップページへ戻る</a>
    <router-link :to="{name: 'user'}" class="users-btn">ユーザー一覧</router-link>
    <p class="text-center">{{user.id}}</p>
    <div class="myname mt-5">
      <h2>{{user.nickname}}さんのプロフィール</h2>
    </div>
    <!-- フォロー -->
    <div class="stats mb-5">
      <i class="fas fa-user-friends text-info"></i>
      <strong id="following" class="stat">
        {{follow_count}}
      </strong>
      フォロー
      <i class="fas fa-user-friends text-info"></i>
      <strong id="followers" class="stat">
        {{follower_count}}
      </strong>
      フォロワー
    </div>
    <!-- フォローボタン -->
    <div class="follow_form mt-2">
     <v-btn
        v-if="follow"
        min-width="135px"
        class="unfollow-btn mx-auto"
        @click="unfollowUser"
      >フォロー中
     </v-btn>
      <v-btn
        v-else
        min-width="135px"
        class="follow-btn"
        @click="followUser"
      >フォロー
      </v-btn>
    </div>
    <!-- プロフィール -->
    <div class="myprof">
      <div class="user-info">
        <div v-if="user.image.url"> 
          <img :src= user.image.url class="user-icon mt-1 mb-5">
        </div>
        <div v-else>
          <img src="../assets/images/no-image.png" class="user-icon mt-1 mb-5">
        </div>
      </div>
      <div class="residence">
        <p class="text-primary font-weight-bold">住んでる場所</p>
        <br>{{user.prefecture}}
      </div>
      <div class="text-myname">
        <p class="text-primary font-weight-bold">自己紹介</p>
        <p style="white-space:pre-wrap;">{{user.text}}</p>
      </div>
      <!-- 投稿した -->
      <v-tabs>
        <v-tab href="#tab-1">投稿した試合記事</v-tab>
        <v-tab href="#tab-2">投稿した戦力分析</v-tab>
        <v-tab href="#tab-3">投稿した試合予想</v-tab>
        <v-tab-item value="tab-1" transition="slide-fade">
          <div class="my-post-list">
            <div v-for="e in my_tweets" :key="e.id">
              <router-link :to="{name: 'tweetshow',params: {id: e.id}}">
                <div class="my-article mt-5">
                  <div class="article-title">
                    {{e.school_a}}vs{{e.school_b}}
                  </div>
                  <div class="article-image">
                    <i class="fa fa-baseball-ball text-white"></i>
                  </div>
                  <div class="sub-title">
                    {{e.title_info}}
                  </div>
                  <div class="name">
                    <span>投稿者</span>
                    {{e.nickname}}
                  </div>
                  <div class="tweets_at">
                    {{e.time}}
                  </div>
                </div>
              </router-link>
            </div>
          </div>
        </v-tab-item>
        <v-tab-item value="tab-2">
          <transition>
          <div class="my-post-list">
            <div v-for="e in my_analyses" :key="e.id">
              <router-link :to="{name: 'analysis-show',params: {id: e.id}}">
                <div class="my-analysis mt-5">
                  <div class="school_ays-name">
                    {{e.school}}
                  </div>
                  <div class="analysis-image">
                    <i class="fa fa-search"></i>
                  </div>
                  <div class="title_ays text-center">
                    {{e.title}}
                  </div>
                  <div class="name">
                    <span>投稿者</span>
                    {{e.nickname}}
                  </div>
                  <div class="analyses_at">
                    {{e.time}}
                  </div>
                </div>
              </router-link>
            </div>
          </div>
          </transition>
        </v-tab-item>
        <v-tab-item value="tab-3" transition="fade-transition">
          <div class="my-post-list">
            <div v-for="e in my_forecasts" :key="e.id">
              <router-link :to="{name: 'forecast-show',params: {id: e.id}}">
                <div class="my-forecast mt-5">
                  <div class="school-fcs">
                    <div class="fcs-icon">
                      <i class="fa fa-balance-scale text-white"></i>
                    </div>
                    <div class="win-school_fcs">
                      勝利予想<br>
                      {{e.win_school}}
                    </div>
                    <div class="lose-school_fcs">
                      敗退予想<br>
                      {{e.lose_school}}
                    </div>
                  </div>
                  <div class="name">
                    <span>投稿者</span>
                    {{e.nickname}}
                  </div>
                  <div class="tweets_at">
                    {{e.time}}
                  </div>
                </div>
              </router-link>
            </div>
          </div>
        </v-tab-item>
      </v-tabs>
    </div>
  </div>
</template>
<script>
import axios from 'axios'
export default {
  data() {
    return {
      tab: null,
      user: [],
      my_tweets: [],
      my_analyses: [],
      my_forecasts: [],
      follow_count: [],
      follower_count: [],
      follow: false,
    }
  },
  mounted() {
    this.fetchUser()
  },
  methods: {
    fetchUser() {
      axios
        .get(`/api/v1/users/${this.$route.params.id}.json`)
        .then(response =>{
          this.user = response.data
          this.my_tweets = response.data.tweet
          this.my_analyses = response.data.analysis
          this.my_forecasts = response.data.forecast
          this.follow_count = response.data.follow_count
          this.follower_count = response.data.follower_count
        })
    },
    followUser() {
      axios
        .post('/api/v1/relationships', {following_id: this.user.id})
        .then(res =>{
          this.follow = true
          this.fetchUser()
        })
    },
    unfollowUser() {
      axios
        .delete(`/api/v1/relationships/${this.$route.params.id}`,{params: {id: this.$route.params.id}})
        .then(res =>{
          this.follow = false
          this.fetchUser()
        })
    }
  }
}
</script>
<style scoped>
.follow_form {
  text-align: center;
}
.v-leave-active {
  position: absolute;
}
.v-enter {
  transform: translateX(-100%);
}
.v-leave-to {
  transform: translateX(100%);
}
</style>