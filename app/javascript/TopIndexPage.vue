<template>
  <div class="top">
    <Header></Header>
    <router-link :to="{name: 'tweet'}">試合記事</router-link>
    <router-link :to="{name: 'analysis'}">戦力分析</router-link>
    <router-link :to="{name: 'forecast'}">試合予想</router-link>
  </div>
</template>
<script>
import Header from './components/Header.vue'
export default {
  components: {
    Header
  }
}
</script>