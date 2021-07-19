<template>
  <div class="contents row mx-auto pt-5">
    <h2 class="text-primary font-weight-bold">プロフィールの編集</h2>
    <p>※ゲストユーザーは編集できません</p>
    <v-divider></v-divider>
    <div class="profile">
      <form @submit.prevent="editUser">
        <!-- <select name="input_pref" v-model="prefecture" class="form-control input-lg">
          <option v-for="(item, index) in getPref" :value="item.name">{{item.name}}</option>
        </select> -->
        <v-select
          v-model="prefecture"
          item-text="name"
          item-value="name"
          :items="pref"
          label="お住まい"
          solo>
        </v-select>
        <v-textarea v-model="text" type="text" label="自己紹介" outlined></v-textarea>
        <p v-if="!!errors['text']" style="color: red;">{{ errors['text'][0]}}</p>
        <div class="s3">
        </div>
        <!-- <input v-if="!image.url && !url" type="file" label="画像" @change="setImage" ref="preview" accept="image/png, image/jpeg, image/bmp"> -->
        <label v-if="!url && !image.url" class="photo w-25">
          ＋写真を選択
          <input type="file" id="file_photo" style="display:none;"  @change="setImage" ref="preview" accept="image/png, image/jpeg, image/bmp">
        </label>
        <div v-if="url">
          <img :src="url" class="w-100" width="320px" height="300px">
          <v-btn color="error" type="submit" @click="deleteImage">削除</v-btn>
        </div>
        <div v-if="image.url">
          <img :src="image.url" class="w-100" width="320px" height="300px">
          <v-btn color="error" type="submit" @click="deleteUserImage">削除</v-btn>
        </div>
        <v-btn type="submit" color="primary" class="text-white mt-5 mb-5">編集する</v-btn>
      </form>
    </div>
  </div>
</template>
<script>
import axios from 'axios';
export default {
  data: function() {
    return {
      text: '',
      prefecture: '',
      image: '',
      url: '',
      n: '',
      errors: '',
      pref: [{"no":"1","name":"\u5317\u6d77\u9053"},{"no":"2","name":"\u9752\u68ee\u770c"},{"no":"3","name":"\u5ca9\u624b\u770c"},{"no":"4","name":"\u5bae\u57ce\u770c"},{"no":"5","name":"\u79cb\u7530\u770c"},{"no":"6","name":"\u5c71\u5f62\u770c"},{"no":"7","name":"\u798f\u5cf6\u770c"},{"no":"8","name":"\u8328\u57ce\u770c"},{"no":"9","name":"\u6803\u6728\u770c"},{"no":"10","name":"\u7fa4\u99ac\u770c"},{"no":"11","name":"\u57fc\u7389\u770c"},{"no":"12","name":"\u5343\u8449\u770c"},{"no":"13","name":"\u6771\u4eac\u90fd"},{"no":"14","name":"\u795e\u5948\u5ddd\u770c"},{"no":"15","name":"\u65b0\u6f5f\u770c"},{"no":"16","name":"\u5bcc\u5c71\u770c"},{"no":"17","name":"\u77f3\u5ddd\u770c"},{"no":"18","name":"\u798f\u4e95\u770c"},{"no":"19","name":"\u5c71\u68a8\u770c"},{"no":"20","name":"\u9577\u91ce\u770c"},{"no":"21","name":"\u5c90\u961c\u770c"},{"no":"22","name":"\u9759\u5ca1\u770c"},{"no":"23","name":"\u611b\u77e5\u770c"},{"no":"24","name":"\u4e09\u91cd\u770c"},{"no":"25","name":"\u6ecb\u8cc0\u770c"},{"no":"26","name":"\u4eac\u90fd\u5e9c"},{"no":"27","name":"\u5927\u962a\u5e9c"},{"no":"28","name":"\u5175\u5eab\u770c"},{"no":"29","name":"\u5948\u826f\u770c"},{"no":"30","name":"\u548c\u6b4c\u5c71\u770c"},{"no":"31","name":"\u9ce5\u53d6\u770c"},{"no":"32","name":"\u5cf6\u6839\u770c"},{"no":"33","name":"\u5ca1\u5c71\u770c"},{"no":"34","name":"\u5e83\u5cf6\u770c"},{"no":"35","name":"\u5c71\u53e3\u770c"},{"no":"36","name":"\u5fb3\u5cf6\u770c"},{"no":"37","name":"\u9999\u5ddd\u770c"},{"no":"38","name":"\u611b\u5a9b\u770c"},{"no":"39","name":"\u9ad8\u77e5\u770c"},{"no":"40","name":"\u798f\u5ca1\u770c"},{"no":"41","name":"\u4f50\u8cc0\u770c"},{"no":"42","name":"\u9577\u5d0e\u770c"},{"no":"43","name":"\u718a\u672c\u770c"},{"no":"44","name":"\u5927\u5206\u770c"},{"no":"45","name":"\u5bae\u5d0e\u770c"},{"no":"46","name":"\u9e7f\u5150\u5cf6\u770c"},{"no":"47","name":"\u6c96\u7e04\u770c"}]
    }
  },
  mounted() {
    this.UserCheck()
    axios
      .get(`/api/v1/users/${this.$route.params.id}.json`)
      .then(response =>{
        this.prefecture = response.data.prefecture
        this.text = response.data.text
        this.image = response.data.image
      })
  },
  methods: {
    UserCheck() {
      axios
        .get(`/api/v1/users/${this.$route.params.id}/edit.json`)
        .then(response => {
          if(response.data.current_user===null || response.data.current_user.id != this.$route.params.id) {
            this.$router.push({ name: 'top'});
          }
        })
    },
    editUser() {
      let formData = new FormData()
      const config = {
        headers: {"content-type": "multipart/form-data",}
      }
      if (this.image !== null && this.n==1) {
        formData.append("image", this.image);
      }
      if (this.prefecture !== null) {
        formData.append("prefecture", this.prefecture)
      }
      if (this.text !== null) {
        formData.append("text", this.text)
      }
      axios
        .patch(`/api/v1/users/${this.$route.params.id}`,formData,config)
        .then(response =>{
          this.$emit('parent-event')
        //   this.$router.push({ name: 'user-show',params: {id: this.$route.params.id}})
        })
        .catch(error => {
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
        });
    },
    setImage(e){
      this.n = 1
      e.preventDefault();
      this.image = e.target.files[0];
      const file = this.$refs.preview.files[0];
      this.url = URL.createObjectURL(file)
      this.$refs.preview.value = "";
    },
    deleteImage(){
      this.url = '';
      URL.revokeObjectURL(this.url);
      this.image = ''
    },
    deleteUserImage(){
      this.n = 1
      this.image = ''
    }
  },
  computed: {
    getPref: {
        get: function () {
            var self = this;
            return self.pref.filter(function (item) {
                return item;
            });
        },
        set: function (v) {
            this.pref = v;
        }
    }
  }
}
</script>