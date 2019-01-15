<template>
  <div class="sidenav">
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
      </div>
   </div>
</template>

<script>
import _ from 'lodash';
import EditorServices from '../services/index.js';
import { Chrome } from 'vue-color';

export default {
  props: ['template','fbPageId'],
  data() {
    return {
      color: {
        hex: '#194d33',
      },
      font: '',
      logo: '',
      title: '',
      tmpl: {},
      selectedFont: null,
      fonts: [
          'Arial',
          'Helvetica',
          'Times New Roman',
          'Times',
          'Courier New',
          'Courier',
          'Verdana'
       ]
    };
  },
  methods: {
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
      this.tmpl = {
        font: this.selectedFont || '',
        color: this.color['hex'] || '',
        logo: this.logo || '',
        title: this.title || '',
        template_id: this.template.id,
        fb_page_id: this.fbPageId
      };
    EditorServices.updateProperties(this.tmpl)
    }

  },
  mounted() {
    if(!_.isNil(this.template)){
      this.font = this.template['font'];
      this.color = this.template['color'];
      this.logo = this.template['logo'];
      this.title = this.template['title'];

      const body = document.getElementById('frame').contentDocument.body;
      body.style.fontFamily = this.font;
      const colorClass = body.getElementsByClassName("fuitter-color");
      _.each(colorClass, (el) => {
        el.style.color = this.color;
      });
    }
  },
  components: {
    'chrome-picker': Chrome,
  }
};
</script>

<style scoped>
  .sidenav {
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
  }
</style>