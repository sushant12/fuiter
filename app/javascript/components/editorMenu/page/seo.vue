<template>
  <div>
    <textarea v-model="metaTags"></textarea>
    <textarea v-model="metaDescription"></textarea>
    <button @click="saveSeo()">Save</button>
  </div>
</template>
<script>
import _ from 'lodash';
import EditorService from '../../../services/index';

export default {
  props: ['pageId'],
  data() {
    return {
      metaTags: '',
      metaDescription: '',
    };
  },
  methods: {
    saveSeo() {
      let seo = {
        seo: {
          metaTags: this.metaTags,
          metaDescription: this.metaDescription,
        }
      }
      EditorService.savePage(this.pageId, seo);
    }
  },
  mounted() {
    EditorService.getPage(this.pageId)
    .then(({data}) => {
      if(!_.isNil(data.seo)){
        this.metaTags = data.seo.metaTags;
        this.metaDescription = data.seo.metaDescription;
      }
    });
  },
};
</script>