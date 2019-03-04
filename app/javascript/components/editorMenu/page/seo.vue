<template>
  <div>
    <a @click="pageMenu" class="back">
      <i class="fa fa-arrow-circle-left"/>Go back
    </a>
    <textarea rows="8" v-model="metaTags"></textarea>
    <textarea rows="8" v-model="metaDescription"></textarea>
    <button class="button is-info" @click="saveSeo()">Save</button>
  </div>
</template>
<script>
import _ from "lodash";
import EditorService from "../../../services/index";

export default {
  props: ["pageId"],
  data() {
    return {
      metaTags: "",
      metaDescription: ""
    };
  },
  methods: {
    saveSeo() {
      let seo = {
        seo: {
          metaTags: this.metaTags,
          metaDescription: this.metaDescription
        }
      };
      EditorService.savePage(this.pageId, seo);
    },
    pageMenu() {
      this.$emit("clicked-page-menu", "");
    },
  },
  mounted() {
    EditorService.getPage(this.pageId).then(({ data }) => {
      if (!_.isNil(data.seo)) {
        this.metaTags = data.seo.metaTags;
        this.metaDescription = data.seo.metaDescription;
      }
    });
  }
};
</script>
<style scoped>
div {
  display: flex;
  flex-flow: column;
}
textarea {
  margin: 10px 10px;
  padding: 5px;
}
button {
  margin: 0 20px;
}
</style>
