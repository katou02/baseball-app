import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)


const store = new Vuex.Store({
  state: {
    currentPage: 1,
    currentPage_t: 1,
    currentPage_wa: 1,
    currentPage_wf: 1,
    tweets: [],
    keyword: '',
    keyword_fcs: '',
    keyword_ays: '',
    keyword_tour: '',
    keyword_wa: '',
    keyword_wf: ''
  },
  mutations: {
    increment(state) {
      state.currentPage = 1
    }
  }
})
export default store;