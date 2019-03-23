<template>
  <nav class="child-menu is-sidebar-translated" id="menu-list">
    <div v-if="showParentMenu" class="child-menu-inner">
      <ul class="sidebar-menu is-active animated" id="dashboard-menu">
        <li class="have-children">
          <a class="parent-link active" @click="showMenu('Design')">
            <i class="fa fa-paint-brush"/>
            Design
          </a>
        </li>
        <li class="have-children">
          <a class="parent-link" @click="showMenu('Page')">
            <i class="fa fa-file"/>
            Pages
          </a>
        </li>
        <li class="have-children">
          <a class="parent-link" @click="showMenu('Domain')">
            <i class="fa fa-cogs"/>
            Domain
          </a>
        </li>
        <li class="have-children">
          <!-- <a class="parent-link" @click="showMenu('LegalInformation')"> -->
          <a @click="showModal" id="show-modal">
            <i class="fa fa-cogs"/>
            Legal Information
          </a>
        </li>
        <div class="modal" v-bind:class="{'is-active':showForm}">
          <div class="modal-background"></div>
          <div class="modal-content">
            <div class="box">
              <h1 class="subtitle has-text-grey">Legal Information</h1>
              <LegalInformation/>
            </div>
          </div>
          <button @click="close" class="modal-close"></button>
        </div>

        <li class="have-children">
          <a class="parent-link" @click="showMenu('Social')">
            <i class="fa fa-cogs"/>
            Social
          </a>
        </li>
      </ul>
    </div>
    <div v-else>
      <keep-alive>
        <component
          v-bind:is="currentMenu"
          @clicked-main-menu="resetMenu"
          :template="template"
          :pages="pages"
          :fb_page_id="fb_page_id"
          :fb_page_name="fb_page_name"
          :templates_url="templates_url"
        ></component>
      </keep-alive>
    </div>
  </nav>
</template>
<script>
import Design from "./editorMenu/design.vue";
import Page from "./editorMenu/page.vue";
import Domain from "./editorMenu/domain.vue";
import LegalInformation from "./editorMenu/legalInfo.vue";
import Social from "./editorMenu/social.vue";

export default {
  props: ["template", "pages", "fb_page_id", "fb_page_name", "templates_url"],
  data() {
    return {
      showParentMenu: true,
      currentMenu: "",
      showForm: false
    };
  },
  methods: {
    showModal() {
      this.showForm = true;
    },
    close() {
      this.showForm = false;
    },
    showMenu(menu) {
      this.showParentMenu = false;
      this.currentMenu = menu;
    },
    resetMenu() {
      this.showParentMenu = true;
      this.currentMenu = "";
    }
  },
  components: {
    Design,
    Page,
    Domain,
    LegalInformation,
    Social
  }
};
</script>
<style scoped>
.child-menu-inner {
  /* height: 100vh; */
  /* overflow-x: auto; */
  /* overflow-y: scroll; */
  padding-right: 5px;
  position: fixed;
  width: 250px;
  background-color: #373751;
  /* @media screen and (min-width: 768) {
    background-color: red;
  } */
}
#menu-list {
  width: 100%;
}
/* .child-menu {
  overflow-y: auto;
} */
</style>
<style>
.modal {
  width: 100vw;
}
.modal .modal-close {
  left: 95vw;
}
</style>

