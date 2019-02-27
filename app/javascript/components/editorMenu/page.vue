<template>
  <div class="component-example">
    <a @click="mainMenu" class="back">
      <i class="fa fa-arrow-circle-left"/>Go back
    </a>
    <VueNestable
      v-if="showPage"
      v-model="menus"
      :max-depth="2"
      children-prop="nested"
      @change="updateMenu()"
    >
      <template slot-scope="{ item }">
        <VueNestableHandle :item="item">
          <i class="fa fa-bars"/>
        </VueNestableHandle>
        <span>{{ item.title }}</span>
        <a @click="pageSeo(item)">SEO</a>
        <a @click="pageSetting(item)">Settings</a>
      </template>
    </VueNestable>
    <div v-else>
      <component v-bind:is="pageOption" :pageId="pageId"></component>
    </div>
  </div>
</template>

<script>
import EditorServices from "../../services/index";
import { VueNestable, VueNestableHandle } from "vue-nestable";
import SEO from "./page/seo.vue";
import PageSettings from "./page/settings.vue";
import _ from "lodash";

export default {
  props: ["template", "fb_page_id", "pages"],
  data() {
    return {
      menus: [],
      showPage: true,
      pageOption: "",
      pageId: ""
    };
  },
  methods: {
    pageSeo(page) {
      this.showPage = false;
      this.pageOption = "SEO";
      this.pageId = page.id;
    },
    pageSetting(page) {
      this.showPage = false;
      this.pageOption = "PageSettings";
      this.pageId = page.id;
    },
    mainMenu() {
      this.$emit("clicked-main-menu", "");
    },
    updateMenu() {
      EditorServices.updateMenu(this.fb_page_id, this.menus).then(resp => {
        document.getElementById("frame").contentWindow.location.reload();
      });
    }
  },

  created() {
    _.each(this.pages, page => {
      this.menus.push(page);
    });
  },
  components: {
    VueNestable,
    VueNestableHandle,
    SEO,
    PageSettings
  }
};
</script>

<style>
/*
* Style for nestable
*/
.component-example {
  position: relative;
  border-radius: 4px;
  box-shadow: 0 2px 3px 0 rgba(16, 17, 23, 0.1), 0 0 1px 0 rgba(16, 17, 23, 0.1);
  background-color: transparent;
  color: #49494d;
  /* padding: 1em; */
  flex: 1;
  /* margin: 1em; */
  overflow: hidden;
  width: 250px;
}
.component-example .back {
  padding: 20px 25px;
  display: flex;
  color: #818a97;
}
.component-example .back:hover {
  color: #00b289;
  background-color: black;
}
.component-example .back i {
  margin-right: 10px;
  color: #818a97;
  font-size: 1.1rem;
  display: flex;
  align-items: center;
}
.nestable-item {
  position: relative;
  padding: 20px 25px;
}
.nestable-item-content {
  display: flex;
  justify-content: space-between;
  align-items: center;
  color: #818a97;
}
.nestable-item-content .nestable-handle [draggable="true"] {
  padding-right: 1%;
}
.nestable-item-content a {
  color: #818a97;
}
.nestable-item-content .nestable-handle i {
  color: #818a97;
  font-size: 1.1rem;
}
.nestable-list li:hover {
  background-color: black;
  cursor: -webkit-grabbing;
  cursor: grabbing;
}

.nestable-list li .nestable-item-content a:hover {
  color: #00b289;
}
.nestable-list li .nestable-item-content .nestable-handle i:hover {
  color: #00b289;
  cursor: all-scroll;
}
/* 
.nestable {
  position: relative;
}
.nestable .nestable-list {
  margin: 0;
  padding: 0 0 0 40px;
  list-style-type: none;
}
.nestable > .nestable-list {
  padding: 0;
}
.nestable-item,
.nestable-item-copy {
  margin: 10px 0 0;
}
.nestable-item:first-child,
.nestable-item-copy:first-child {
  margin-top: 0;
}
.nestable-item .nestable-list,
.nestable-item-copy .nestable-list {
  margin-top: 10px;
} */

/* .nestable-item.is-dragging .nestable-list {
  pointer-events: none;
}
.nestable-item.is-dragging * {
  opacity: 0;
  filter: alpha(opacity=0);
}
.nestable-item.is-dragging:before {
  content: " ";
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: rgba(106, 127, 233, 0.274);
  border: 1px dashed rgb(73, 100, 241);
  -webkit-border-radius: 5px;
  border-radius: 5px;
}
.nestable-drag-layer {
  position: fixed;
  top: 0;
  left: 0;
  z-index: 100;
  pointer-events: none;
}
.nestable-drag-layer > .nestable-list {
  position: absolute;
  top: 0;
  left: 0;
  padding: 0;
  background-color: rgba(106, 127, 233, 0.274);
}
.nestable [draggable="true"] {
  cursor: move;
}
.nestable-handle {
  display: inline;
}
.blue-text-color {
  color: #415ad4;
}
.purple-text-color {
  color: #b43ceb;
}
.red-text-color {
  color: #e13a3a;
}

.fa {
  color: black;
} */
</style>