<template>
  <div class="field" style="margin-top:0;">
    <a @click="pageMenu" class="back">
      <i class="fa fa-arrow-circle-left"/>Go back
    </a>
    <p class="p-label has-text-white">
      Meta Keywords
      <span
        class="is-primary tooltip is-tooltip-bottom is-tooltip-warning"
        data-tooltip="Separated by commas ' , ' "
      >
        <i class="fa fa-question-circle has-text-grey-lighter"/>
      </span>
    </p>
    <textarea class="pages-setting-textarea" rows="8" v-model="metaTags"></textarea>
    <p class="p-label has-text-white">Meta Descriptions</p>
    <textarea class="pages-setting-textarea" rows="8" v-model="metaDescription"></textarea>
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
    }
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
textarea {
  width: 100%;
  background-color: transparent;
  color: white;
  padding: 5px;
}
textarea ::placeholder {
  color: darkgray;
}
/* div {
  display: flex;
  flex-flow: column;
} */
/* textarea {
  margin: 10px 10px;
  padding: 5px;
} */
.button {
  width: 98%;
  margin: 10px 1%;
}
</style>
