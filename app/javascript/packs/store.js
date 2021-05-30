import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'

Vue.use(Vuex)


const store = new Vuex.Store({
  state: {
    currentPage: 1,
    currentPage_fcs: 1,
    currentPage_ays: 1,
    currentPage_t: 1,
    currentPage_wa: 1,
    currentPage_wf: 1,
    currentPage_follow: 1,
    currentPage_follower: 1,
    tweets: [],
    keyword: '',
    keyword_follow: '',
    keyword_follower: '',
    keyword_fcs: '',
    keyword_ays: '',
    keyword_tour: '',
    keyword_wa: '',
    keyword_wf: '',
    keyword_dm: '',
    signedIn: ''
  },
  mutations: {
    increment(state) {
      state.keyword = ''
      state.keyword_fcs = ''
      state.keyword_ays = ''
      state.currentPage_fcs = 1
      state.currentPage_ays = 1
      state.currentPage = 1
      state.currentPage_t = 1
      state.currentPage_wa = 1
      state.currentPage_follow = 1
      state.currentPage_follower = 1
      state.currentPage_wf = 1
      state.keyword_tour = ''
      state.keyword_wa = ''
      state.keyword_wf = ''
      state.keyword_follow = ''
      state.keyword_follower = ''
    },
    fetchSignedIn(state) {
      state.signedIn = !!localStorage.signedIn
    },
  },
  actions: {
    doFetchSignedIn({ commit }) {
      commit('fetchSignedIn')
    }
  }
})
export default store;