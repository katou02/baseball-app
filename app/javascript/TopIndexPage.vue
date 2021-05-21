<template>
  <div class="top">
    <div class="top-title">
      タイトルが入る
    </div>
    <div class="top-menu-list">
      <router-link :to="{name: 'tweet'}" class="text-white">
        <div class="top-menu">
          <v-icon large color="white">mdi-pencil</v-icon><br>
          試合記事
        </div>
      </router-link>
      <router-link :to="{name: 'analysis'}" class="text-white">
        <div class="top-menu">
          <v-icon large color="white">mdi-magnify</v-icon><br>
          戦力分析
        </div>
      </router-link>
      <router-link :to="{name: 'forecast'}" class="text-white">
        <div class="top-menu">
          <v-icon large color="white">mdi-scale-balance</v-icon><br>
          試合予想
        </div>
      </router-link>
      <router-link :to="{name: 'champion',params: {id: 1}}" class="text-white">
        <div class="top-menu">
          <v-icon large color="white">mdi-crown</v-icon><br>
          優勝予想
        </div>
      </router-link>
      <router-link :to="{name: 'map',query: {tournament_id: 1}}" class="text-white">
        <div class="top-menu">
          <v-icon large color="white">mdi-city</v-icon><br>
          ふるさと
        </div>
      </router-link>
    </div>
  </div>
</template>
<script>
</script>