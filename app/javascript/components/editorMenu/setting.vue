<template>
  <aside class="menu is-info">
    <div v-if="showParentMenu">
      <p class="menu-label" @click="mainMenu">&larr; Back</p>
      <ul class="menu-list">
        <li>
          <a @click="showSettingMenu('Domain')">Domains</a>
        </li>
        <li>
          <a @click="showSettingMenu('LegalInformation')">Legal Information</a>
        </li>
        <li>
          <a @click="showSettingMenu('Social')">Social</a>
        </li>
      </ul>
    </div>
    <div v-else>
      <keep-alive>
        <component
          v-bind:is="currentMenu"
          @clicked-setting-menu="resetSetting"
          :fb_page_id='fb_page_id'
          :template='template'>
        </component>
      </keep-alive>
    </div>
  </aside>
</template>

<script>
import Domain from '../editorSetting/domain.vue';
import LegalInformation from '../editorSetting/legalInfo.vue';
import Social from '../editorSetting/social.vue';

export default { 
  props: ['fb_page_id', 'template'],
  data() {
    return {
      showParentMenu: true,
      currentMenu: '',
    }
  },
  methods: {
    mainMenu() {
     this.$emit('clicked-main-menu', ''); 
    },
    showSettingMenu(settingMenu) {
      this.showParentMenu = false;
      this.currentMenu = settingMenu;
    },
    resetSetting() {
      this.showParentMenu = true;
      this.currentMenu ='';
    }
  },
  components: {
    Domain,
    LegalInformation,
    Social,
  },
}
</script>

