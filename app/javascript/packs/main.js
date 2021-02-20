import Vue from 'vue';
import Vuetify from "vuetify";
import "vuetify/dist/vuetify.min.css";
import App from '../app.vue';
Vue.use(Vuetify);


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

  document.addEventListener('DOMContentLoaded', () => {
    const app = new Vue({
      el: "#app",
      vuetify: new Vuetify(),
      render: h => h(App)
    }).$mount();
    document.body.appendChild(app.$el);
})
