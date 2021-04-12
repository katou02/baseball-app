import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)


const store = new Vuex.Store({
  state: {
    currentPage: 1,
    currentPage_t: 1,
    currentPage_wa: 1,
    currentPage_wf: 1,
    currentPage_follow: 1,
    tweets: [],
    keyword: '',
    keyword_follow: '',
    keyword_fcs: '',
    keyword_ays: '',
    keyword_tour: '',
    keyword_wa: '',
    keyword_wf: '',
    keyword_dm: ''
  },
  mutations: {
    increment(state) {
      state.currentPage_t = 1
      state.currentPage_wa = 1
      state.currentPage_follow = 1
      state.currentPage_wf = 1
      state.keyword_tour = ''
      state.keyword_wa = ''
      state.keyword_wf = ''
      state.keyword_follow = ''
    }
  }
})
export default store;