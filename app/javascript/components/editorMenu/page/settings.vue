<template>
  <div v-if="page.uri === 'home'">
    <input type="text" v-model="pageData['title']" name="title">
    <input type="radio" value="false" v-model="pageData['setting']['description']['enable']" @click="hideDescription()"> Choose description from facebook
    <input type="radio" value="true" v-model="pageData['setting']['description']['enable']" @click="showDescription()">
    <textarea v-if="pageData['setting']['description']['enable']" v-model="pageData['setting']['description']['value']"></textarea>
    <button @click="savePageSetting()">Save</button>
  </div>

  <div v-else-if="page.uri === 'contact'">
    <input type="text" v-model="pageData['title']" name="title">
    <input type="checkbox" name=""> Show map?
    <input type="email" name="email">
    <input type="text" name="location">
    <input type="number" name="contact">
    <button @click="savePageSetting()">Save</button>
  </div>

  <div v-else-if="page.uri === 'about'">
    <input type="text" name="title">
    <input type="radio" name="image" value="false" @click="hideImage()"> Choose image from facebook
    <input type="radio" name="image" value="true" @click="showImage()">
    <input v-if="pageData['setting']['image']['enable']" type="file" name="">
    <input type="radio" name="description" value="facebook" @click="hideDescription()"> Choose description from facebook
    <input type="radio" name="description" value="custom" @click="showDescription()">
    <textarea v-if="pageData['setting']['description']['enable']"></textarea>
    <button @click="savePageSetting()">Save</button>
  </div>

  <div v-else-if="page.uri === 'events'">
    <input type="text" name="title"  v-model="pageData['title']">
    <button @click="savePageSetting()">Save</button>
  </div>
  <div v-else-if="page.uri === 'gallery'">
    <input type="text" name="title">
    <button @click="savePageSetting()" v-model="pageData['title']">Save</button>
  </div>
  <div v-else-if="page.uri === 'news'">
    <input type="text" name="title">
    <button @click="savePageSetting()" v-model="pageData['title']">Save</button>
  </div>
</template>
<script>
import _ from 'lodash';
import EditorService from '../../../services/index';

export default {
props: ['pageId'],
  data() {
    return {
      page: '',
      pageData: {
        title: '',
        setting: {
          image: {
            value: "",
            enable: false
          },
          description: {
            value: "",
            enable: false
          }
        }
      },
    };
  },
  methods: {
    showDescription(){
      this.pageData['setting']['description']['enable'] = true;
    },
    hideDescription() {
      this.pageData['setting']['description']['enable'] = false;
    },
    showImage(){
      this.pageData['setting']['image']['enable'] = true;
    },
    hideImage() {
      this.pageData['setting']['image']['enable'] = false;
    },
    savePageSetting() {
      EditorService.savePage(this.pageId,this.pageData)
        .then(() => {
          document.getElementById('frame').contentWindow.location.reload();
        });
    }
  },
  created() {
    const that = this;
    EditorService.getPage(this.pageId)
    .then(({data}) => {
      that.page = data;
      that.pageData['title'] = data.title;
      that.pageData['setting']['description']['value'] = data.setting['description']['value'];
      that.pageData['setting']['description']['enable'] = data.setting['description']['enable'];
    })
  }
};
</script>