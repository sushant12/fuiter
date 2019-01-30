<template>
  <div>
    <editor-nav></editor-nav>
    <editor-sidebar></editor-sidebar>
    <editor-preview></editor-preview>
  </div>
  <!-- <div class="sidenav">
    <div class = "sideContent">
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
  </div> -->
</template>

<script>
import _ from 'lodash';
import EditorServices from '../services/index.js';
import { Chrome } from 'vue-color';
import EditorNav from '../components/editorNav';
import EditorSidebar from '../components/editorSidebar';
import EditorPreview from '../components/editorPreview';
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
    'editor-nav': EditorNav,
    'editor-sidebar': EditorSidebar,
    'editor-preview': EditorPreview,
  }
};
</script>

<style scoped>
/*  .sidenav {
    height: 100%;
    width: 250px;
    position: fixed;
    z-index: 1;
    top: 0;
    left: 0;
    margin-top: 3.25rem; 
    background-color: #4c5764;
  }
  @media screen and (max-height: 450px) {
    .sidenav {padding-top: 15px;}
    .sidenav a {font-size: 18px;}
  }
  .p-label {
    color: white;
  }
  .sideContent{
    margin: 10px;
  }*/
</style>