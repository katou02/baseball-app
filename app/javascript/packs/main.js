import Vue from 'vue';
import Vuetify from "vuetify";
import "vuetify/dist/vuetify.min.css";
import App from '../app.vue';
Vue.use(Vuetify);

document.addEventListener('DOMContentLoaded', () => {
  // const el = document.body.appendChild(document.createElement('tweet'))
  const app = new Vue({
    // el,
    vuetify: new Vuetify(),
    render: h => h(App)
  }).$mount();
  document.body.appendChild(app.$el);
})
