import Vue from 'vue'
import App from '../app.vue'

document.addEventListener('DOMContentLoaded', () => {
  const el = document.body.appendChild(document.createElement('tweet'))
  const app = new Vue({
    el,
    render: h => h(App)
  })
})
