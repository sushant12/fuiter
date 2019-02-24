<template>
  <div v-if="page.uri === 'home'">
    <input type="text" v-model="pageData['title']" name="title">
    <input type="radio" value="false" v-model="pageData['setting']['description']['enable']" @click="hideDescription()"> Choose description from facebook
    <input type="radio" value="true" v-model="pageData['setting']['description']['enable']" @click="showDescription()">
    <textarea v-if="pageData['setting']['description']['enable'] === 'true'" v-model="pageData['setting']['description']['value']"></textarea>
    <button @click="savePageSetting()">Save</button>
  </div>

  <div v-else-if="page.uri === 'contact'">
    <input type="text" v-model="pageData['title']" name="title">
    <input type="checkbox" value="true" v-model="map_enable"> Show map?
    <input type="checkbox" value="true" v-model="email_enable">
    <input type="email" name="email" v-model="email">
    <input type="checkbox" value="true" v-model="location_enable"> Show map?
    <input type="text" name="location" v-model="location">
    <input type="checkbox" value="true" v-model="contact_enable"> Show map?
    <input type="number" name="contact" v-model="contact">
    <button @click="savePageSetting()">Save</button>
  </div>

  <div v-else-if="page.uri === 'about'">
    <input type="text" v-model="pageData['title']" name="title">
    <input type="radio" name="image" value="false" 
    v-model="pageData['setting']['image']['enable']"
    @click="hideImage()"> Choose image from facebook
    <input type="radio" name="image" value="true" 
    v-model="pageData['setting']['image']['enable']"
    @click="showImage()">
    <picture-input 
      v-if="pageData['setting']['image']['enable'] == 'true'"
      ref="pictureInput"
      @change="onChanged"
      @remove="onRemoved"
      width="200" 
      height="200" 
      margin="16" 
      accept="image/jpeg,image/png" 
      size="10"
      :prefill="aboutImage" 
      :removable="true"
      button-class="btn"
      :custom-strings="{
        upload: '<h1>Bummer!</h1>',
        drag: 'Drag a 😺 GIF or GTFO'
      }"
      >
    </picture-input>
    <input type="radio"  value="false" 
    v-model="pageData['setting']['description']['enable']" @click="hideDescription()"> Choose description from facebook

    <input type="radio"  value="true" 
    v-model="pageData['setting']['description']['enable']"
    @click="showDescription()">

    <textarea v-if="pageData['setting']['description']['enable'] === 'true'"
    v-model="pageData['setting']['description']['value']"></textarea>
    <button @click="savePageSetting()">Save</button>
  </div>

  <div v-else-if="page.uri === 'events'">
    <input type="text" name="title"  v-model="pageData['title']">
    <button @click="savePageSetting()">Save</button>
  </div>
  <div v-else-if="page.uri === 'gallery'">
    <input type="text" name="title" v-model="pageData['title']">
    <button @click="savePageSetting()">Save</button>
  </div>
  <div v-else-if="page.uri === 'news'">
    <input type="text" v-model="pageData['title']" name="title">
    <button @click="savePageSetting()">Save</button>
  </div>
</template>
<script>
import _ from 'lodash';
import EditorService from '../../../services/index';
import PictureInput from 'vue-picture-input';

export default {
props: ['pageId'],
  data() {
    return {
      page: '',
      aboutImage: '',
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
      email: '',
      location: '',
      contact: '',
      email_enable: '',
      location_enable: '',
      contact_enable: '',
      map_enable: '',
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
      const that = this;
      const formData = new FormData();
      formData.append('title', this.pageData['title']);
      formData.append('about_image', this.aboutImage);
      formData.append('setting[image][enable]', this.pageData['setting']['image']['enable']);

      formData.append('setting[description][value]', this.pageData['setting']['description']['value']);
      formData.append('setting[description][enable]', this.pageData['setting']['description']['enable']);

      EditorService.savePage(this.pageId,formData)
        .then(() => {
          EditorService.saveFbPageTemplate(this.pageId, {
            email: that.email,
            location: that.location,
            contact: that.contact,
            email_enable: that.email_enable,
            location_enable: that.location_enable,
            contact_enable: that.contact_enable,
            map_enable: that.map_enable,
          });
          document.getElementById('frame').contentWindow.location.reload();
        });
    },
    onChanged() {
      this.aboutImage = this.$refs.pictureInput.file;
    },
    onRemoved() {
       this.aboutImage = '';
    },
  },
  created() {
    const that = this;
    EditorService.getPage(this.pageId)
    .then(({data}) => {
      that.page = data;
      that.pageData['title'] = data.title;
      that.pageData['setting']['description']['value'] = data.setting['description']['value'];
      that.pageData['setting']['description']['enable'] = data.setting['description']['enable'];
      that.pageData['setting']['image']['enable'] = data.setting['image']['enable'];
      that.aboutImage = data.about_image.url
    });
    EditorService.getFbPageTemplate(this.pageId)
      .then(({data}) => {
        that.email = data.email;
        that.location = data.location;
        that.contact = data.contact;
        that.email_enable = data.email_enable;
        that.location_enable = data.location_enable;
        that.contact_enable = data.contact_enable,
        that.map_enable = data.map_enable;
      });
  },
  components: {
    PictureInput
  },
};
</script>