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
        <!-- <li class="legal-info-btn">
          <a @click="showSettingMenu('LegalInformation')">
            <i class="fa fa-balance-scale"/>
            Legal Information
          </a>
        </li>-->
        <li class="legal-info-btn">
          <a @click="showModal" id="show-modal">
            <i class="fa fa-balance-scale"/>
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
          :fb_page_name="fb_page_name"
          :domain="domain"
        ></component>
      </keep-alive>
    </div>
  </aside>
</template>

<script>
import _ from "lodash";
import EditorServices from "../../services/index.js";
import Domain from "../editorSetting/domain.vue";
import LegalInformation from "../editorSetting/legalInfo.vue";
import Social from "../editorSetting/social.vue";

export default {
  props: ["fb_page_id", "template", "fb_page_name"],
  data() {
    return {
      showParentMenu: true,
      currentMenu: "",
      domain: "example.fuitter.com",
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
    mainMenu() {
      this.$emit("clicked-main-menu", "");
    },
    showSettingMenu(settingMenu) {
      const sidebar = document.getElementById("menu-list");
      // sidebar.style.width = "420px";
      this.showParentMenu = false;
      frame.style.left = "10%";
      this.currentMenu = settingMenu;
    },
    resetSetting() {
      this.showParentMenu = true;
      this.currentMenu = "";
      frame.style.left = "0%";
    }
  },
  created() {
    EditorServices.showSetting(this.template.id).then(res => {
      if (!_.isNil(res.data)) {
        if (!_.isNil(res.data.domain)) {
          this.domain = res.data.domain;
        }
      }
    });
  },
  components: {
    Domain,
    LegalInformation,
    Social
  }
};
</script>

<style scoped>
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
#menu-list {
  width: 100%;
}
.modal {
  width: 100vw;
}
.modal .modal-close {
  left: 95vw;
}
</style>
