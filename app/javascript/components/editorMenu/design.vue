<template>
  <div class="child-menu-inner">
    <a @click="mainMenu">Go back</a>
    <p class="p-label">Pick Color</p>
        <chrome-picker v-model="color" @input="changeColor">
        </chrome-picker>
      <hr />
      <p class="p-label">Site Title</p><input type="text" v-model="title" @focusout='changeTitle'>
      <hr />
      <p class="p-label">Font Family</p>
      <select v-model="selectedFont" @change='changeFont'>
        <option :value="null">Choose Font</option>
        <option 
          v-for="font in fonts" 
          :key="font" 
          :style="{fontFamily: font }"
          >
          {{font}}
        </option>
      </select>
      <hr />
      <div class="field">
        <div class="file is-info has-name is-boxed">
          <label class="file-label">
            <input class="file-input" type="file" name="resume" @change="handleImageUpload" ref="file">
            <span class="file-cta">
              <span class="file-icon">
                <i class="fas fa-cloud-upload-alt"></i>
              </span>
              <span class="file-label">
                Choose File
              </span>
            </span>
            <span class="file-name has-text-white">
              {{fileName}}
            </span>
          </label>
        </div>
      </div>
  </div>
</template>
<script>
import _ from 'lodash';
import { Chrome } from 'vue-color';
import EditorServices from '../../services/index.js';

export default {
  props: ['template'],
  data() {
    return {
      color: {
        hex: '',
      },
      font: '',
      logo: '',
      title: '',
      selectedFont: null,
      fonts: [
          'Arial',
          'Helvetica',
          'Times New Roman',
          'Times',
          'Courier New',
          'Courier',
          'Verdana'
       ],
       fileName: 'No file choosen',
    };
  },
  methods: {
    mainMenu() {
     this.$emit('clicked-main-menu', ''); 
    },
    handleImageUpload() {
      this.logo = this.$refs.file.files[0]
      this.fileName = this.logo.name;
      this.updateProperty()
    },
    changeColor(e){
      const color = this.color['hex'];
      const frame = document.getElementById('frame').contentDocument.body;
      const colorClass = frame.getElementsByClassName("fuitter-color");
      _.each(colorClass, (el) => {
        el.style.color = color;
      });
      this.updateProperty();
    },
    changeFont(e){
      const font = e.target.value;
      const frame = document.getElementById('frame').contentDocument.body;
      frame.style.fontFamily = font;
      this.updateProperty();
    },
    changeTitle(e) {
      const title = e.target.value;
      const frame = document.getElementById('frame').contentDocument.head;
      frame.title = title;
      this.updateProperty();
    },
    updateProperty() {
      const formData = new FormData();
      formData.append('template[logo]', this.logo || '');
      formData.append('template[properties][font]', this.selectedFont || '');
      formData.append('template[properties][color]', this.color['hex'] || '');
      formData.append('template[properties][title]', this.title || '');
      const template_id= this.template.id;
      const fb_page_id= this.template.fb_page_id;
      EditorServices.updateProperties(formData, template_id, fb_page_id);
    }
  },
  mounted() {
    if(!_.isNil(this.template['properties'])){
      this.font = this.template['properties']['font'];
      this.color = this.template['properties']['color'];
      this.logo = this.template['logo'];
      this.title = this.template['properties']['title'];
    }
  },
  components: {
    'chrome-picker': Chrome,
  }
};
</script>
