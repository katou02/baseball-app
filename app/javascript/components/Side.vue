<template>
  <div class="slide mr-5">
    <v-card class="mx-auto" width="300">
      <v-list>
        <v-list-group :value="false" prepend-icon="mdi-pencil">
          <template v-slot:activator>
            <v-list-item-title>試合記事</v-list-item-title>
          </template>

          <v-list-item>
            <v-list-item-title>
              <router-link @click.native="reset()" :to="{name: 'tweet'}">
                <v-icon>mdi-pencil</v-icon>全ての記事
              </router-link>
            </v-list-item-title>
          </v-list-item>

          <v-list-item>
            <v-list-item-title>
              <router-link :to="{name: 'tournament',params: {id: 1}}">
                <v-icon>mdi-pencil</v-icon>第91回選抜高校野球大会
              </router-link>
            </v-list-item-title>
          </v-list-item>

          <v-list-item>
            <v-list-item-title>
              <router-link :to="{name: 'tournament',params: {id: 117}}">
                <v-icon>mdi-pencil</v-icon>第93回選抜高校野球大会
              </router-link>
            </v-list-item-title>
          </v-list-item>

          <v-list-item>
            <v-list-item-title>
              <router-link :to="{name: 'tournament',params: {id: 34}}">
                <v-icon>mdi-pencil</v-icon>第101回全国高校野球選手権大会
              </router-link>
            </v-list-item-title>
          </v-list-item>

          <v-list-item>
            <v-list-item-title>
              <router-link :to="{name: 'tournament',params: {id: 84}}">
                <v-icon>mdi-pencil</v-icon>2020年甲子園高校野球交流試合
              </router-link>
            </v-list-item-title>
          </v-list-item>

          <v-list-item>
            <v-list-item-title>
              <router-link :to="{name: 'tournament',params: {id: 150}}">
                <v-icon>mdi-pencil</v-icon>第103回全国高校野球選手権大会
              </router-link>
            </v-list-item-title>
          </v-list-item>

          <v-list-item>
            <v-list-item-title>
              <router-link :to="{name: 'tournament',params: {id: 200}}">
                <v-icon>mdi-pencil</v-icon>第94回選抜高校野球大会
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
              <router-link @click.native="reset()" :to="{name: 'analysis'}">
                <v-icon>mdi-magnify</v-icon>全ての戦力分析
              </router-link>
            </v-list-item-title>
          </v-list-item>

          <v-list-item>
            <v-list-item-title>
              <router-link :to="{name: 'watch_ays',params: {id: 1}}">
                <v-icon>mdi-magnify</v-icon>第91回選抜高校野球大会
              </router-link>
            </v-list-item-title>
          </v-list-item>

          <v-list-item>
            <v-list-item-title>
              <router-link :to="{name: 'watch_ays',params: {id: 117}}">
                <v-icon>mdi-magnify</v-icon>第93回選抜高校野球大会
              </router-link>
            </v-list-item-title>
          </v-list-item>

          <v-list-item>
            <v-list-item-title>
              <router-link :to="{name: 'watch_ays',params: {id: 34}}">
                <v-icon>mdi-magnify</v-icon>第101回全国高校野球選手権大会
              </router-link>
            </v-list-item-title>
          </v-list-item>

          <v-list-item>
            <v-list-item-title>
              <router-link :to="{name: 'watch_ays',params: {id: 84}}">
                <v-icon>mdi-magnify</v-icon>2020年甲子園高校野球交流試合
              </router-link>
            </v-list-item-title>
          </v-list-item>

          <v-list-item>
            <v-list-item-title>
              <router-link :to="{name: 'watch_ays',params: {id: 150}}">
                <v-icon>mdi-magnify</v-icon>第103回全国高校野球選手権大会
              </router-link>
            </v-list-item-title>
          </v-list-item>

          <v-list-item>
            <v-list-item-title>
              <router-link :to="{name: 'watch_ays',params: {id: 200}}">
                <v-icon>mdi-pencil</v-icon>第94回選抜高校野球大会
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
              <router-link @click.native="reset()" :to="{name: 'forecast'}">
                <v-icon>mdi-scale-balance</v-icon>全ての試合予想
              </router-link>
            </v-list-item-title>
          </v-list-item>

          <v-list-item>
            <v-list-item-title>
              <router-link :to="{name: 'watch_fcs',params: {id: 1}}">
                <v-icon>mdi-scale-balance</v-icon>第91回選抜高校野球大会
              </router-link>
            </v-list-item-title>
          </v-list-item>

          <v-list-item>
            <v-list-item-title>
              <router-link :to="{name: 'watch_fcs',params: {id: 117}}">
                <v-icon>mdi-scale-balance</v-icon>第93回選抜高校野球大会
              </router-link>
            </v-list-item-title>
          </v-list-item>

          <v-list-item>
            <v-list-item-title>
              <router-link :to="{name: 'watch_fcs',params: {id: 34}}">
                <v-icon>mdi-scale-balance</v-icon>第101回全国高校野球選手権大会
              </router-link>
            </v-list-item-title>
          </v-list-item>

          <v-list-item>
            <v-list-item-title>
              <router-link :to="{name: 'watch_fcs',params: {id: 84}}">
                <v-icon>mdi-scale-balance</v-icon>2020年甲子園高校野球交流試合
              </router-link>
            </v-list-item-title>
          </v-list-item>

          <v-list-item>
            <v-list-item-title>
              <router-link :to="{name: 'watch_fcs',params: {id: 150}}">
                <v-icon>mdi-scale-balance</v-icon>第103回全国高校野球選手権大会
              </router-link>
            </v-list-item-title>
          </v-list-item>

          <v-list-item>
            <v-list-item-title>
              <router-link :to="{name: 'watch_fcs',params: {id: 200}}">
                <v-icon>mdi-scale-balance</v-icon>第94回選抜高校野球大会
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
                <v-icon>mdi-crown</v-icon>第91回選抜高校野球大会
              </router-link>
            </v-list-item-title>
          </v-list-item>

          <v-list-item>
            <v-list-item-title>
              <router-link :to="{name: 'champion',params: {id: 117}}">
                <v-icon>mdi-crown</v-icon>第93回選抜高校野球大会
              </router-link>
            </v-list-item-title>
          </v-list-item>

          <v-list-item>
            <v-list-item-title>
              <router-link :to="{name: 'champion',params: {id: 34}}">
                <v-icon>mdi-crown</v-icon>第101回全国高校野球選手権大会
              </router-link>
            </v-list-item-title>
          </v-list-item>

          <v-list-item>
            <v-list-item-title>
              <router-link :to="{name: 'champion',params: {id: 84}}">
                <v-icon>mdi-crown</v-icon>2020年甲子園高校野球交流試合
              </router-link>
            </v-list-item-title>
          </v-list-item>

          <v-list-item>
            <v-list-item-title>
              <router-link :to="{name: 'champion',params: {id: 150}}">
                <v-icon>mdi-crown</v-icon>第103回全国高校野球選手権大会
              </router-link>
            </v-list-item-title>
          </v-list-item>

          <v-list-item>
            <v-list-item-title>
              <router-link :to="{name: 'champion',params: {id: 200}}">
                <v-icon>mdi-crown</v-icon>第94回選抜高校野球大会
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
                <v-icon>mdi-city</v-icon>第91回選抜高校野球大会
              </router-link>
            </v-list-item-title>
          </v-list-item>

          <v-list-item>
            <v-list-item-title>
              <router-link :to="{name: 'map',query: {tournament_id: 117}}">
                <v-icon>mdi-city</v-icon>第93回選抜高校野球大会
              </router-link>
            </v-list-item-title>
          </v-list-item>

          <v-list-item>
            <v-list-item-title>
              <router-link :to="{name: 'map',query: {tournament_id: 34}}">
                <v-icon>mdi-city</v-icon>第101回全国高校野球選手権大会
              </router-link>
            </v-list-item-title>
          </v-list-item>

          <v-list-item>
            <v-list-item-title>
              <router-link :to="{name: 'map',query: {tournament_id: 84}}">
                <v-icon>mdi-city</v-icon>2020年甲子園高校野球交流試合
              </router-link>
            </v-list-item-title>
          </v-list-item>

          <v-list-item>
            <v-list-item-title>
              <router-link :to="{name: 'map',query: {tournament_id: 150}}">
                <v-icon>mdi-city</v-icon>第103回全国高校野球選手権大会
              </router-link>
            </v-list-item-title>
          </v-list-item>

          <v-list-item>
            <v-list-item-title>
              <router-link :to="{name: 'map',query: {tournament_id: 200}}">
                <v-icon>mdi-city</v-icon>第94回選抜高校野球大会
              </router-link>
            </v-list-item-title>
          </v-list-item>
        </v-list-group>
      </v-list>
    </v-card>
  </div>
</template>
<script>
export default {
  methods: {
    reset() {
      this.$store.commit('increment')
    }
  }
}
</script>
