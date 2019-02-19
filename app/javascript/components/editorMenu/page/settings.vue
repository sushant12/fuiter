<template>
  <div v-if="page.uri === 'home'">
    <input type="text" name="title">
    <input type="radio" name="description" value="facebook"> Choose description from facebook
    <input type="radio" name="description" value="custom">
    <textarea></textarea>
    <button>Save</button>
  </div>
  <div v-else-if="page.uri === 'contact'">
    <input type="checkbox" name=""> Show map?
    <input type="text" name="title">
    <input type="email" name="email">
    <input type="text" name="location">
    <input type="number" name="contact">
  </div>
  <div v-else-if="page.uri === 'about'">
    <input type="text" name="title">
    <input type="radio" name="image" value="facebook"> Choose image from facebook
    <input type="radio" name="image" value="custom">
    <input type="file" name="">
    <input type="radio" name="description" value="facebook"> Choose description from facebook
    <input type="radio" name="description" value="custom">
    <textarea></textarea>
    <button>Save</button>
  </div>
  <div v-else-if="page.uri === 'events'">
    <input type="text" name="title">
  </div>
  <div v-else-if="page.uri === 'gallery'">
    <input type="text" name="title">
  </div>
  <div v-else-if="page.uri === 'news'">
    <input type="text" name="title">
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
    };
  },
  mounted() {
    const that = this;
    EditorService.getPage(this.pageId)
    .then(({data}) => {
      that.page = data;
    })
  }
};
</script>