<template>
<nav class="child-menu is-dark is-sidebar-translated">
  <div v-if="showParentMenu" class="child-menu-inner">
    <ul class="sidebar-menu is-active animated" id="dashboard-menu">
      <li class="have-children">
        <a class="parent-link active" @click="showMenu('Design')">Design</a>
      </li>
      <li class="have-children">
        <a class="parent-link " @click="showMenu('Page')">Pages</a>
      </li>
      <li class="have-children">
        <a class="parent-link " href="/">Settings</a>
      </li>
    </ul>
  </div>
  <div v-else>
    <keep-alive>
      <component 
      v-bind:is="currentMenu"
      @clicked-main-menu='resetMenu'
      :template='template'
      :pages='pages'
      :fb_page_id='fb_page_id'>
      </component>
    </keep-alive>
  </div>
</nav>
</template>
<script>
import Design from './editorMenu/design.vue';
import Page from './editorMenu/page.vue';

export default {
  props: ['template', 'pages', 'fb_page_id'],
  data() {
    return {
      showParentMenu: true,
      currentMenu: '',
    };
  },
  methods: {
    showMenu(menu) {
      this.showParentMenu = false;
      this.currentMenu = menu;
    },
    resetMenu() {
      this.showParentMenu = true;
      this.currentMenu = '';
    },
  },
  components: {
    Design,
    Page,
  },
};
</script>
<style scoped>
  .child-menu-inner {
    height: 550px;
    overflow-x: hidden;
    overflow-y: auto;
    padding-right: 5px;
  }
</style>

