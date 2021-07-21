import Vue from 'vue';
import Vuetify from "vuetify";
import App from '../app.vue';
import Paginate from 'vuejs-paginate'
import store from './store.js'
Vue.use(Vuetify);
Vue.component('paginate', Paginate)
import VueAxios from 'vue-axios'
import { securedAxiosInstance, plainAxiosInstance } from './axios.js'

const slide = new Vue({
  el: '#slide',
    data: {
      current_slide: 0,
      slides: [
        {img: "/images/81573810.jpeg"},
        {img: "/images/ball.jpg"},
        {img: "/images/thumb_ground.jpg"},
        {img: "/images/thumb_front.jpg"},
        {img: "/images/mykosien.JPG"}
      ],
    },
    mounted() {
      setInterval(() => {
        this.current_slide = this.current_slide < this.slides.length -1 ? this.current_slide +1 : 0
      }, 3000)
    }
  })

  Vue.config.productionTip = false
  Vue.use(VueAxios, {
    secured: securedAxiosInstance,
    plain: plainAxiosInstance
  })

    const mypage= new Vue({
      el: '#radio',
      data: {
        isActive: '1'
      }
    })

    document.addEventListener('DOMContentLoaded', () => {
      const app = new Vue({
        el: "#app",
        store,
        securedAxiosInstance,
        plainAxiosInstance,
        vuetify: new Vuetify(),
        render: h => h(App)
      }).$mount();
      document.body.appendChild(app.$el);
    })
    import * as VueGoogleMaps from 'vue2-google-maps'

    Vue.use(VueGoogleMaps, {
      load: {
        key: process.env.GOOGLE_MAP_API_KEY,
        libraries: "places",
        region: "JP",
        language: "ja",
      },
    });