<template>
  <div class="sidebar mt-5 w-25">
    <v-container class="side">
      <v-list>
        <v-list-item>
          <v-list-item-title class="title grey--text text--darken-2">
            高校野球ドットコム
          </v-list-item-title>
          <v-divider></v-divider>

          <v-list-item-title>
            <router-link :to="{name: 'analysis'}">
              <v-icon class="mr-4">fa fa-pen-alt</v-icon>試合記事
            </router-link>
          </v-list-item-title>
          <v-list-item-title class="mt-4">
            <router-link :to="{name: 'analysis'}">
              <v-icon class="mr-4">fa fa-search</v-icon>試合分析
            </router-link>
          </v-list-item-title>
          <v-list-item-title class="mt-4">
            <router-link :to="{name: 'forecast'}">
              <v-icon class="mr-4">fa fa-baseball-ball</v-icon>試合予想
            </router-link>
          </v-list-item-title>
        </v-list-item>
      </v-list>
    </v-container>
  </div>
</template>
<style scoped>
  .side {
    position: sticky;
    top: 0;
  }
</style>