<template>
  <div id="sidebar">
    <chrome-picker v-model="color" @input="changeColor"></chrome-picker>
    font family: <input type="text" v-model="font" @focusout='changeFont'> <br>
    site title: <input type="text" v-model="font" @focusout='changeTitle'> <br>
  </div>
</template>

<script>
import _ from 'lodash';
import { Chrome } from 'vue-color';

export default {
  props: ['template'],
  data() {
    return {
      color: {
        hex: '#194d33',
      },
      font: '',
      logo: '',
      title: '',
      tmpl: {},
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
    },
    changeFont(e){
      const font = e.target.value;
      const frame = document.getElementById('frame').contentDocument.body;
      frame.style.fontFamily = font;
    },
    changeTitle(e) {
      const title = e.target.value;
      const frame = document.getElementById('frame').contentDocument.head;
      frame.title = title;
    },
    updateProperty() {
      this.tmpl = {
        font: this.font,
        color: this.color,
        logo: this.logo,
        title: this.title
      };
    },

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

</style>