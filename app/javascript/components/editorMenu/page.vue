<template>
  <div class="component-example">
    <div v-if="showPage">
      <a @click="mainMenu" class="back">
        <i class="fa fa-arrow-circle-left"/>Go back
      </a>
      <p class="has-text-white p-label">
        Page Menu
        <span
          class="is-primary tooltip is-tooltip-top is-tooltip-warning"
          data-tooltip="Darg & Drop To Reorder"
        >
          <i class="fa fa-question-circle has-text-grey-lighter"/>
        </span>
      </p>
      <!-- <span class="is-primary tooltip is-tooltip-top" data-tooltip="Reorder Page Menus">
        <i class="fa fa-question-circle"/>
      </span>-->

      <VueNestable v-model="menus" :max-depth="2" children-prop="nested" @change="updateMenu()">
        <template slot-scope="{ item }">
          <VueNestableHandle :item="item">
            <i class="fa fa-arrows-alt"/>
          </VueNestableHandle>
          <span>{{ item.title }}</span>
          <div class="page-fa-icons">
            <a @click="pageSeo(item)">
              <div
                class="is-primary tooltip is-tooltip-left is-tooltip-warning"
                data-tooltip="Add Description for SEO "
              >
                <i class="fas fa-search"/>
              </div>
            </a>
            <a @click="hidePage(item)">
              <div
                class="is-primary tooltip is-tooltip-left is-tooltip-warning"
                data-tooltip="Hide Menu "
              >
                <i class="fas fa-eye" :class="[item.display ? 'page-visible' : 'page-hidden']"/>
              </div>
            </a>
            <a @click="pageSetting(item)">
              <div
                class="is-primary tooltip is-tooltip-left is-tooltip-warning"
                data-tooltip="Rename Page Menu"
              >
                <i class="fa fa-cog"/>
              </div>
            </a>
          </div>
        </template>
      </VueNestable>
    </div>
    <div v-else>
      <component v-bind:is="pageOption" :pageId="pageId" @clicked-page-menu="resetPage"></component>
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
    hidePage(page) {
      page.display = page.display ? false : true;
      this.updateMenu();
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
    },
    listMenus() {
      EditorServices.listMenus(this.fb_page_id).then(({ data }) => {
        _.each(data, page => {
          this.menus.push(page);
        });
      });
    },
    resetPage() {
      this.showPage = true;
      this.pageOption = "";
      this.menus = [];
      this.listMenus();
    }
  },

  created() {
    this.listMenus();
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
.nestable-item-content {
  display: flex;
  justify-content: space-between;
  width: 100%;
}
.page-fa-icons {
  display: flex;
  flex-flow: row;
  justify-content: space-around;
  width: 30%;
}
/*
* Style for nestable
*/
/* .tooltip {
  margin: 0 0 0 5px;
  width: 10px;
} */

.component-example {
  position: relative;
  border-radius: 4px;
  /* box-shadow: 0 2px 3px 0 rgba(16, 17, 23, 0.1), 0 0 1px 0 rgba(16, 17, 23, 0.1); */
  background-color: transparent;
  color: #49494d;
  /* padding: 1em; */
  flex: 1;
  /* margin: 1em; */
  overflow: hidden;
  width: 250px;
  height: 100vh;
}

.nestable-item {
  position: relative;
  padding: 10px 10px;
  color: #ededed;
  /* border: 1px dashed white; */
  width: 95%;
  margin: 5px;
  /* margin-top: 0.8rem; */
  /* box-shadow: 2px 2px 10px black; */
  /* background-color: #37414a; */
  /* border: 1px solid #778899; */
  border: 1px solid #525f6d;
}
.nestable-item ol .nestable-item {
  /* background-color: #3c4650; */
  padding: 10px;
  margin: 10px 0 10px 5px;
  font-size: 0.7rem;
}

.nestable-item ol .nestable-item:hover {
  background-color: #4d5a67;
  /* padding-left: 20px; */
}
.nestable-item ol .nestable-item span {
  font-size: 0.8rem;
}
.nestable-item-content {
  display: flex;
  /* justify-content: space-between; */
  align-items: center;
  color: #ededed;
}
.nestable-item-content span {
  display: flex;
  /* justify-content: space-between; */
  align-items: flex-start;
  flex-basis: 50%;
  color: white;
  padding-left: 10px;
  font-size: 0.9rem;
  font-weight: 200;
  text-transform: capitalize;
  font-family: "campton";
  padding-left: 20px;
}
.nestable-item-content .nestable-handle [draggable="true"] {
  padding-right: 1%;
}

.nestable-item-content {
  color: #818a97;
}
/* .nestable-item-content a:first-of-type {
  color: #818a97;
  display: flex;
  justify-content: flex-end;
  flex-basis: 40%;
  padding-right: 15px;
} */
.nestable-item-content .nestable-handle i {
  color: white;
  font-size: 1rem;
}

.nestable-item-content a .page-hidden {
  color: grey;
}

.nestable-item-content a i {
  color: white;
  font-size: 1rem;
}

.nestable-list li:hover {
  background-color: #292337;
  cursor: -webkit-grabbing;
  cursor: grabbing;
  border-color: #00b289;
}

.nestable-list li .nestable-item-content a i:hover {
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
} */
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
  /* -webkit-border-radius: 5px; */
  /* border-radius: 5px; */
}
.nestable-drag-layer {
  position: fixed;
  top: -80px;
  left: 0;
  z-index: 100;
  pointer-events: none;
  background-color: black;
}
.nestable-drag-layer > .nestable-list {
  position: absolute;
  /* margin-top: -20px; */
  /* transform: translate(-50%, -50%); */
  /* top: 0;
  left: 0;
  padding: 0; */
  box-shadow: 2px 2px 10px black;
  background-color: whitesmoke;
  padding: 10px 10px;
}
.nestable-drag-layer > .nestable-list span {
  color: #00b289;
}
.nestable-drag-layer > .nestable-list a {
  color: #00b289;
}
.nestable-drag-layer > .nestable-list i {
  color: #00b289;
}
/* 
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