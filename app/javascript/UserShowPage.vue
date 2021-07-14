<template>
  <div class="mypage-content pt-2">
    <router-link :to="{name: 'top'}" class="return-top-mypage text-white">トップページ</router-link>
    <router-link :to="{name: 'user'}" class="users-btn text-white">ユーザー一覧</router-link>
    <router-link :to="{name: 'room'}" class="dm-btn text-white">DM</router-link>
    <span v-if="user_id==current_user || user.current_user.admin==true">
      <!-- <router-link :to="{name: 'user-edit',params: {id: $route.params.id}}" class="edit text-white">編集する</router-link> -->
      <button class="edit text-white" @click="openModal">編集する</button>
    </span>
    <p class="text-center">ID:{{user.id}}</p>
    <div class="myname mt-5">
      <h2>{{user.nickname}}</h2>
    </div>
    <!-- フォロー -->
    <div class="stats mb-5">
      <i class="fas fa-user-friends text-info"></i>
      <!-- <router-link :to="{name: 'following',params: {id: $route.params.id}}"> -->
        <strong id="following" class="stat">
          {{follow_count}}
        </strong>
        フォロー
      <!-- </router-link> -->
      <i class="fas fa-user-friends text-info"></i>
      <!-- <router-link :to="{name: 'follower',params: {id: $route.params.id}}"> -->
        <strong id="followers" class="stat">
          {{follower_count}}
        </strong>
        フォロワー
      <!-- </router-link> -->
    </div>
    <!-- フォローボタン -->
    <div v-if="current_user !== user_id">
      <div class="follow_form mt-2">
      <button
          v-if="user.check"
          min-width="135px"
          class="unfollow-btn mx-auto"
          @click="unfollowUser"
        >フォロー中
      </button>
        <button
          v-else
          min-width="135px"
          class="follow-btn"
          @click="followUser"
        >フォロー
        </button>
      </div>
      <div v-if="user.check && user.room == null">
        <form @submit.prevent="createRoom" class="text-center mt-3">
          <v-btn type="submit" class="text-white primary" small>DMをはじめる</v-btn>
        </form>
      </div>
    </div>
    <!-- プロフィール -->
    <div class="myprof mt-5">
      <div class="user-info">
        <div v-if="user_image"> 
          <img :src= user_image class="user-icon mt-1 mb-5">
        </div>
        <div v-else>
          <img src="../assets/images/no-image.png" class="user-icon mt-1 mb-5">
        </div>
      </div>
      <Header></Header>
      <!--<div class="residence">
        <p class="text-primary font-weight-bold">住んでる場所</p>
        <br>{{user.prefecture}}
      </div>
      <div class="text-myname">
        <p class="text-primary font-weight-bold">自己紹介</p>
        <p style="white-space:pre-wrap;">{{user.text}}</p>
      </div>-->
      <!-- 投稿した -->
      <v-tabs v-model="tab" centered>
        <v-tabs-slider color="yellow"></v-tabs-slider>
        <v-tab href="#tab-m">プロフィール</v-tab>
        <v-tab href="#tab-1">投稿した試合記事</v-tab>
        <v-tab href="#tab-2">投稿した戦力分析</v-tab>
        <v-tab href="#tab-3">投稿した試合予想</v-tab>
        <v-tab href="#tab-4">投稿したふるさと紹介</v-tab>
        <v-tab href="#tab-5">いいねした試合記事</v-tab>
        <v-tab href="#tab-6">フォロー</v-tab>
        <v-tab href="#tab-7">フォロワー</v-tab>
      </v-tabs>
      <v-tabs-items v-model="tab" :style="{ background: '#EEFFFF' }" class="d-flex justify-center">
        <v-tab-item value="tab-m">
          <div class="residence">
            <p class="text-primary font-weight-bold">住んでる場所</p>
            <br>{{user.prefecture}}
          </div>
          <div class="text-myname">
            <p class="text-primary font-weight-bold">自己紹介</p>
            <p style="white-space:pre-wrap;">{{user.text}}</p>
          </div>
        </v-tab-item>
        <v-tab-item value="tab-1">
          <v-row>
            <v-col cols="12" sm="6" md="6" lg="6" v-for="e in listTweets" :key="e.id">
              <div class="user-article mt-5">
                <router-link :to="{name: 'tweet-show',params: {id: e.id}}">
                  <div class="d-flex h-100">
                    <div v-if="e.image.url"><img :src="e.image.url" class="article-icon"></div>
                    <div v-else><img src="/images/ball.jpg" class="article-icon"></div>
                    <div class="article-heading mx-auto">
                      <div class="name">
                        投稿者 {{e.nickname}}
                        {{e.time}}
                      </div>
                      <div class="article-title mt-3">
                        <p class="h4">{{e.round}}</p>
                        {{e.school_a}}vs{{e.school_b}}
                      </div>
                      <div v-if="e.title.length<=15" class="sub-title mt-3">
                        {{e.title}}
                      </div>
                      <div v-else class="sub-title mt-3">{{e.title.slice(0,15) + '...'}}</div>
                    </div>
                  </div>
                </router-link>
              </div>
            </v-col>
          </v-row>
          <button
            class="list-item-button"
            v-if="(listTweets.length - count_t) >= 0"
            type="button"
            @click="isMore_t"
          >
            もっと見る
          </button>
        <div v-if="!my_tweets.length" class="no-posts">投稿がありません</div>
        </v-tab-item>
        <v-tab-item value="tab-2">
          <v-row>
            <v-col cols="12"  sm="6" md="6" lg="6" v-for="e in listAnalyses" :key="e.id">
              <div class="user-article mt-5">
                <router-link :to="{name: 'analysis-show',params: {id: e.id}}">
                  <div class="d-flex h-100">
                    <div v-if="e.image.url"><img :src="e.image.url" class="article-icon"></div>
                    <div v-else><img src="/images/ball.jpg" class="article-icon"></div>
                    <div class="article-heading mx-auto">
                      <div class="name">
                        投稿者{{e.nickname}}
                        {{e.time}}
                      </div>
                      <div class="school-ays-name mt-3">
                        {{e.school}}
                      </div>
                      <div v-if="e.title.length <=15" class="sub-title mt-3">
                        {{e.title}}
                      </div>
                      <div v-else class="sub-title mt-3">{{e.title.slice(0,15) + '...'}}</div>
                    </div>
                  </div>
                </router-link>
              </div>
            </v-col>
          </v-row>
          <button
            class="list-item-button"
            v-if="(listAnalyses.length - count_a) >= 0"
            type="button"
            @click="isMore_a"
          >
            もっと見る
          </button>
          <div v-if="!my_analyses.length" class="no-posts">投稿がありません</div>
        </v-tab-item>
        <v-tab-item value="tab-3">
          <v-row>
            <v-col cols="12" sm="6" md="6" lg="6" v-for="e in listForecasts" :key="e.id">
              <div class="user-article mt-5">
                <router-link :to="{name: 'forecast-show',params: {id: e.id}}">
                  <div class="d-flex h-100">
                    <img src="/images/ball.jpg" class="article-icon">
                    <div class="article-heading mx-auto">
                      <div class="name">
                        投稿者{{e.nickname}}
                        {{e.time}}
                      </div>
                      <div class="school-fcs mt-4">
                        <div class="win-school_fcs">
                          勝利予想
                          <br><br>
                          {{e.win_school}}
                        </div>
                        <div class="lose-school_fcs ml-3">
                          敗退予想
                          <br><br>
                          {{e.lose_school}}
                        </div>
                      </div>
                    </div>
                  </div>
                </router-link>
              </div>
            </v-col>
          </v-row>
          <button
            class="list-item-button"
            v-if="(listForecasts.length - count_f) >= 0"
            type="button"
            @click="isMore_f"
          >
            もっと見る
          </button>
          <div v-if="!my_forecasts.length" class="no-posts">投稿がありません</div>
        </v-tab-item>
        <v-tab-item value="tab-4">
          <v-row>
            <v-col cols="12"  sm="6" md="6" lg="6" v-for="e in listMaps" :key="e.id">
              <div class="map-data mt-5">
                <router-link :to="{name: 'map-show',params: {id: e.id}}">
                  <div class="d-flex h-100">
                    <div v-if="e.image.url"><img :src="e.image.url" class="article-icon"></div>
                    <div v-else><img src="/images/ball.jpg" class="article-icon"></div>
                    <div class="article-heading mx-auto bg-white">
                      <div class="name">
                        投稿者
                        {{e.nickname}}<br>
                        {{e.time}}
                      </div>
                      <div class="sub-title">
                        {{e.school}}のふるさと
                      </div>
                      <div class="text-center">
                        <img src="/images/hurusato.jpeg" width="50px" height="40px" >
                      </div>
                    </div>
                  </div>
                </router-link>
              </div>
            </v-col>
          </v-row>
          <button
            class="list-item-button"
            v-if="(listMaps.length - count_m) >= 0"
            type="button"
            @click="isMore_m"
          >
            もっと見る
          </button>
          <div v-if="!my_maps.length" class="no-posts">投稿がありません</div>
        </v-tab-item>
        <v-tab-item value="tab-5">
          <v-row>
            <v-col cols="12" sm="6" md="6" lg="6" v-for="e in listLikes" :key="e.id" class="mx-auto">
              <div class="user-article mt-5">
                <router-link :to="{name: 'tweet-show',params: {id: e.id}}">
                  <div class="d-flex h-100">
                    <div v-if="e.image.url"><img :src="e.image.url" class="article-icon"></div>
                    <div v-else><img src="/images/ball.jpg" class="article-icon"></div>
                    <div class="article-heading mx-auto">
                      <div class="name">
                        投稿者 {{e.nickname}}
                        {{e.time}}
                      </div>
                      <div class="article-title mt-3">
                        <p class="h4">{{e.round}}</p>
                        {{e.school_a}}vs{{e.school_b}}
                      </div>
                      <div v-if="e.title.length <= 15" class="sub-title mt-3">
                        {{e.title}}
                      </div>
                      <div v-else class="sub-title mt-3">{{e.title.slice(0,15) + '...'}}</div>
                    </div>
                  </div>
                </router-link>
              </div>
            </v-col>
          </v-row>
          <button
            class="list-item-button"
            v-if="(listLikes.length - count_l) >= 0"
            type="button"
            @click="isMore_l"
          >
            もっと見る
          </button>
          <div v-if="!my_likes.length" class="no-posts">投稿がありません</div>
        </v-tab-item>

        <v-tab-item value="tab-6">
          <Follow></Follow>
        </v-tab-item>
        <v-tab-item value="tab-7">
          <Follower></Follower>
        </v-tab-item>
      </v-tabs-items>
    </div>
    <modal name="select" height="auto" width="65%" :scrollable="true">
      <div id="modal">
        <Edit @parent-event="fetchUser"></Edit>
        <button @click="closeModal">閉じる</button>
      </div>
    </modal>
  </div>
</template>
<script>
import axios from 'axios'
import Follow from './FollowingPage.vue'
import Follower from './FollowerPage.vue'
import Header from './components/Header.vue'
import Edit from './components/UserEdit.vue'
export default {
  components: {
    Header,
    Follow,
    Follower,
    Edit
  },
  data() {
    return {
      tab: null,
      user: [],
      user_id: '',
      current_user: [],
      my_tweets: [],
      my_analyses: [],
      my_forecasts: [],
      my_maps: [],
      my_likes: [],
      follow_count: [],
      follower_count: [],
      count_t: 10,
      count_a: 10,
      count_f: 10,
      count_l: 10,
      count_m: 10,
      user_image: ''
    }
  },
  mounted() {
    this.fetchUser()
  },
  computed: {
    listTweets() {
      const list = this.my_tweets
      return list.slice(0, this.count_t)
    },
    listAnalyses() {
      const list = this.my_analyses
      return list.slice(0, this.count_a)
    },
    listForecasts() {
      const list = this.my_forecasts
      return list.slice(0, this.count_f)
    },
    listMaps() {
      const list = this.my_maps
      return list.slice(0,this.count_m)
    },
    listLikes() {
      const list = this.my_likes
      return list.slice(0, this.count_l)
    },
    
  },
  methods: {
    fetchUser() {
      this.closeModal()
      axios
        .get('/api/v1/users')
        .then(response =>{
          if(!response.data.current_user) {
            delete localStorage.csrf
            delete localStorage.signedIn
            this.$router.push({ name: 'top'});
          }
        })
      axios
        .get(`/api/v1/users/${this.$route.params.id}.json`)
        .then(response =>{
          this.user = response.data
          this.current_user = response.data.current_user.id
          this.user_id = response.data.id
          this.my_likes = response.data.likes
          this.my_tweets = response.data.tweet
          this.my_analyses = response.data.analysis
          this.my_forecasts = response.data.forecast
          this.my_maps = response.data.map
          this.follow_count = response.data.follow_count
          this.follower_count = response.data.follower_count
          this.user_image = response.data.image.url
        })
    },
    followUser() {
      axios
        .post('/api/v1/relationships', {following_id: this.user.id})
        .then(res =>{
          this.fetchUser()
        })
    },
    unfollowUser() {
      axios
        .delete(`/api/v1/relationships/${this.$route.params.id}`,{params: {id: this.$route.params.id}})
        .then(res =>{
          this.fetchUser()
        })
    },
    createRoom() {
      axios
        .post('/api/v1/rooms',{user_id: this.user.id})
        .then(res => {
          this.fetchUser()
          this.$router.push({name: 'room'})
        })
    },
    isMore_t() {
      this.count_t += 10
    },
    isMore_a() {
      this.count_a += 10
    },
    isMore_f() {
      this.count_f += 10
    },
    isMore_l() {
      this.count_l += 10
    },
    isMore_m() {
      this.count_m += 10
    },
    openModal(){
      this.$modal.show('select');
    },
    closeModal(){
      this.$modal.hide('select');
    },
  },
  watch: {
    '$route'(to, from) {
      // this.fetchUser()
      this.$router.go({name: 'user-show', params: {id: 1}})
    }
  }
}
</script>