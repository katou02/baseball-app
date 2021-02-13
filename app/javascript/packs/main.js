import Vue from 'vue'
import Vuetify from "vuetify";
import "vuetify/dist/vuetify.min.css";
import App from '../app.vue';

Vue.use(Vuetify);
const vuetify = new Vuetify();

document.addEventListener('DOMContentLoaded', () => {
  const el = document.body.appendChild(document.createElement('tweet'))
  const app = new Vue({
    el,
    vuetify,
    render: h => h(App)
  })
})
