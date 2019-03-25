<template>
  <nav class="child-menu is-sidebar-translated" id="menu-list">
    <div v-if="showParentMenu" class="child-menu-inner">
      <ul class="sidebar-menu is-active animated" id="dashboard-menu">
        <li class="have-children">
          <a class="parent-link active" id="editor-design-menu" @click="showMenu('Design')">
            <i class="fa fa-paint-brush"/>
            Design
          </a>
        </li>
        <li class="have-children">
          <a class="parent-link" id="editor-page-menu" @click="showMenu('Page')">
            <i class="fa fa-file"/>
            Pages
          </a>
        </li>
        <li class="have-children">
          <a class="parent-link" id="editor-social-menu" @click="showMenu('Social')">
            <i class="fa fa-cogs"/>
            Social
          </a>
        </li>
        <li class="have-children">
          <a class="parent-link" id="editor-setting-menu" @click="showSetting(true)">
            <i class="fa fa-file"/>
            Settings
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
      this.showSetting(false);
      this.showParentMenu = false;
      this.currentMenu = menu;
    },
    resetMenu() {
      this.showParentMenu = true;
      this.currentMenu = "";
    },
    showSetting(state) {
      const iframe = document.getElementsByClassName("site-preview")[0];
      iframe.style.display = state ? "none" : "flex";

      if (state) {
        const elSetting = document.getElementById("editor-setting-menu");
        const elDesign = document.getElementById("editor-design-menu");
        elSetting.className += " active";
        elDesign.classList.remove("active");
      }
    }
  },
  components: {
    Design,
    Page,
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

