<template>
  <aside class="menu is-info">
    <div v-if="showParentMenu" class="settings">
      <a @click="mainMenu" class="back">
        <i class="fa fa-arrow-circle-left"/>Go back
      </a>
      <ul class="settings-list">
        <li>
          <a @click="showSettingMenu('Domain')">
            <i class="fa fa-globe"/>
            Domains
          </a>
        </li>
        <li>
          <a @click="showSettingMenu('LegalInformation')">
            <i class="fa fa-balance-scale"/>
            Legal Information
          </a>
        </li>
        <li>
          <a @click="showSettingMenu('Social')">
            <i class="fa fa-comments"/>
            Social
          </a>
        </li>
      </ul>
    </div>
    <div v-else>
      <keep-alive>
        <component
          v-bind:is="currentMenu"
          @clicked-setting-menu="resetSetting"
          :fb_page_id="fb_page_id"
          :template="template"
        ></component>
      </keep-alive>
    </div>
  </aside>
</template>
<style scoped>
.settings .back {
  padding: 20px 25px;
  display: flex;
  color: #818a97;
}
.settings .back:hover {
  color: #00b289;
  background-color: black;
}
.settings .back i {
  margin-right: 10px;
  color: #818a97;
  font-size: 1.1rem;
}
.settings-list li {
  position: relative;
  padding: 20px 25px;
}
.settings-list li a {
  color: #818a97;
  font-size: 1rem;
}
.settings-list li a i {
  margin-right: 10px;
  color: #818a97;
  font-size: 1.1rem;
}
.settings-list li:hover {
  background-color: black;
}
.settings-list li:hover a {
  color: #00b289;
}
.settings-list li:hover i {
  color: #00b289;
}
</style>
<script>
import Domain from "../editorSetting/domain.vue";
import LegalInformation from "../editorSetting/legalInfo.vue";
import Social from "../editorSetting/social.vue";

export default {
  props: ["fb_page_id", "template"],
  data() {
    return {
      showParentMenu: true,
      currentMenu: ""
    };
  },
  methods: {
    mainMenu() {
      this.$emit("clicked-main-menu", "");
    },
    showSettingMenu(settingMenu) {
      this.showParentMenu = false;
      this.currentMenu = settingMenu;
    },
    resetSetting() {
      this.showParentMenu = true;
      this.currentMenu = "";
    }
  },
  components: {
    Domain,
    LegalInformation,
    Social
  }
};
</script>

