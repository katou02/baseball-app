<template>
  <v-app id="app"> <!-- 追加 -->
    <v-btn>Vuetifyのボタン</v-btn> <!-- 追加 -->
    <div>  <!-- 更新 -->
      <p>{{ message }}</p>
    </div>
  </v-app> <!-- 追加 -->
</template>

<script>
export default {
  data: function () {
    return {
      message: "Hello Vue"
    }
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
