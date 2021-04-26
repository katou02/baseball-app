<template>
  <div class="slide mr-5">
    <v-card class="mx-auto" width="300">
      <v-list>
        <v-list-item>
          <v-list-item-icon>
            <v-icon>mdi-home</v-icon>
          </v-list-item-icon>
          <v-list-item-title>Home</v-list-item-title>
        </v-list-item>

        <v-list-group :value="false" prepend-icon="mdi-pencil">
          <template v-slot:activator>
            <v-list-item-title>試合記事</v-list-item-title>
          </template>

          <v-list-item>
            <v-list-item-title>
              <router-link :to="{name: 'tweet'}">
                <v-icon>mdi-pencil</v-icon>全ての記事
              </router-link>
            </v-list-item-title>
          </v-list-item>

          <v-list-item>
            <v-list-item-title>
              <router-link :to="{name: 'tournament',params: {id: 1}}">
                <v-icon>mdi-pencil</v-icon>第99回全国高校野球選手権
              </router-link>
            </v-list-item-title>
          </v-list-item>

          <v-list-item>
            <v-list-item-title>
              <router-link :to="{name: 'tournament',params: {id: 51}}">
                <v-icon>mdi-pencil</v-icon>第100回全国高校野球選手権
              </router-link>
            </v-list-item-title>
          </v-list-item>

          <v-list-item>
            <v-list-item-title>
              <router-link :to="{name: 'tournament',params: {id: 108}}">
                <v-icon>mdi-pencil</v-icon>2020年甲子園高校野球交流試合
              </router-link>
            </v-list-item-title>
          </v-list-item>

          <v-list-item>
            <v-list-item-title>
              <router-link :to="{name: 'tournament',params: {id: 141}}">
                <v-icon>mdi-pencil</v-icon>第93回選抜高校野球大会
              </router-link>
            </v-list-item-title>
          </v-list-item>
        </v-list-group>

        <v-list-group :value="false" prepend-icon="mdi-magnify">
          <template v-slot:activator>
            <v-list-item-title>戦力分析</v-list-item-title>
          </template>

          <v-list-item>
            <v-list-item-title>
              <router-link :to="{name: 'analysis'}">
                <v-icon>mdi-magnify</v-icon>全ての戦力分析
              </router-link>
            </v-list-item-title>
          </v-list-item>

          <v-list-item>
            <v-list-item-title>
              <router-link :to="{name: 'watch_ays',params: {id: 1}}">
                <v-icon>mdi-magnify</v-icon>第99回全国高校野球選手権
              </router-link>
            </v-list-item-title>
          </v-list-item>

          <v-list-item>
            <v-list-item-title>
              <router-link :to="{name: 'watch_ays',params: {id: 51}}">
                <v-icon>mdi-magnify</v-icon>第100回全国高校野球選手権
              </router-link>
            </v-list-item-title>
          </v-list-item>

          <v-list-item>
            <v-list-item-title>
              <router-link :to="{name: 'watch_ays',params: {id: 108}}">
                <v-icon>mdi-magnify</v-icon>2020年甲子園高校野球交流試合
              </router-link>
            </v-list-item-title>
          </v-list-item>

          <v-list-item>
            <v-list-item-title>
              <router-link :to="{name: 'watch_ays',params: {id: 141}}">
                <v-icon>mdi-magnify</v-icon>第93回選抜高校野球大会
              </router-link>
            </v-list-item-title>
          </v-list-item>
        </v-list-group>

        <v-list-group :value="false" prepend-icon="mdi-scale-balance">
          <template v-slot:activator>
            <v-list-item-title>試合予想</v-list-item-title>
          </template>

          <v-list-item>
            <v-list-item-title>
              <router-link :to="{name: 'forecast'}">
                <v-icon>mdi-scale-balance</v-icon>全ての試合予想
              </router-link>
            </v-list-item-title>
          </v-list-item>

          <v-list-item>
            <v-list-item-title>
              <router-link :to="{name: 'watch_fcs',params: {id: 1}}">
                <v-icon>mdi-scale-balance</v-icon>第99回全国高校野球選手権
              </router-link>
            </v-list-item-title>
          </v-list-item>

          <v-list-item>
            <v-list-item-title>
              <router-link :to="{name: 'watch_fcs',params: {id: 51}}">
                <v-icon>mdi-scale-balance</v-icon>第100回全国高校野球選手権
              </router-link>
            </v-list-item-title>
          </v-list-item>

          <v-list-item>
            <v-list-item-title>
              <router-link :to="{name: 'watch_fcs',params: {id: 108}}">
                <v-icon>mdi-scale-balance</v-icon>2020年甲子園高校野球交流試合
              </router-link>
            </v-list-item-title>
          </v-list-item>

          <v-list-item>
            <v-list-item-title>
              <router-link :to="{name: 'watch_fcs',params: {id: 141}}">
                <v-icon>mdi-scale-balance</v-icon>第93回選抜高校野球大会
              </router-link>
            </v-list-item-title>
          </v-list-item>
        </v-list-group>

        <v-list-group :value="false" prepend-icon="mdi-crown">
          <template v-slot:activator>
            <v-list-item-title>優勝予想</v-list-item-title>
          </template>

          <v-list-item>
            <v-list-item-title>
              <router-link :to="{name: 'champion',params: {id: 1}}">
                <v-icon>mdi-crown</v-icon>第99回全国高校野球選手権
              </router-link>
            </v-list-item-title>
          </v-list-item>

          <v-list-item>
            <v-list-item-title>
              <router-link :to="{name: 'champion',params: {id: 51}}">
                <v-icon>mdi-crown</v-icon>第100回全国高校野球選手権
              </router-link>
            </v-list-item-title>
          </v-list-item>

          <v-list-item>
            <v-list-item-title>
              <router-link :to="{name: 'champion',params: {id: 108}}">
                <v-icon>mdi-crown</v-icon>2020年甲子園高校野球交流試合
              </router-link>
            </v-list-item-title>
          </v-list-item>

          <v-list-item>
            <v-list-item-title>
              <router-link :to="{name: 'champion',params: {id: 141}}">
                <v-icon>mdi-crown</v-icon>第93回選抜高校野球大会
              </router-link>
            </v-list-item-title>
          </v-list-item>
        </v-list-group>

        <v-list-group :value="false" prepend-icon="mdi-city">
          <template v-slot:activator>
            <v-list-item-title>ふるさと紹介</v-list-item-title>
          </template>

          <v-list-item>
            <v-list-item-title>
              <router-link :to="{name: 'map',query: {tournament_id: 1}}">
                <v-icon>mdi-city</v-icon>第99回全国高校野球選手権
              </router-link>
            </v-list-item-title>
          </v-list-item>

          <v-list-item>
            <v-list-item-title>
              <router-link :to="{name: 'map',query: {tournament_id: 51}}">
                <v-icon>mdi-city</v-icon>第100回全国高校野球選手権
              </router-link>
            </v-list-item-title>
          </v-list-item>

          <v-list-item>
            <v-list-item-title>
              <router-link :to="{name: 'map',query: {tournament_id: 108}}">
                <v-icon>mdi-city</v-icon>2020年甲子園高校野球交流試合
              </router-link>
            </v-list-item-title>
          </v-list-item>

          <v-list-item>
            <v-list-item-title>
              <router-link :to="{name: 'map',query: {tournament_id: 141}}">
                <v-icon>mdi-city</v-icon>第93回選抜高校野球大会
              </router-link>
            </v-list-item-title>
          </v-list-item>
        </v-list-group>
      </v-list>
    </v-card>
  </div>
</template>