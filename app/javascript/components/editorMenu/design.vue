<template>
  <div v-if="showDesign" class="child-menu-inner" id="inner-menu">
    <a @click="mainMenu" class="back">
      <i class="fa fa-arrow-circle-left"/>Go back
    </a>
    <span class="p-label">Template</span>
    <a
      class="button is-marginless has-text-centered level-item is-primary"
      :href="templates_url"
    >Choose templates</a>
    <br>
    <a @click="designOption('NavbarDesign')">Navbar Color/Font</a>
    <a @click="designOption('BodyDesign')">Body Color/Font</a>
    <a @click="designOption('LogoDesign')">Site Title/Logo</a>
  </div>
  <div v-else>
    <component
      v-bind:is="designComponent"
      :template="template"
      :templatesUrl="templates_url"
      :defaultTemplateValue="default_template_value"
      @clicked-design-menu="resetDesignPage">
    </component>
  </div>
</template>
<script>
import NavbarDesign from './design/navbarDesign';
import BodyDesign from './design/bodyDesign';
import LogoDesign from './design/logo';

export default {
  props: ["template", "templates_url", "default_template_value"],
  data() {
    return {
      showDesign: true,
      designComponent: "",
    };
  },
  methods: {
    mainMenu() {
      this.$emit("clicked-main-menu", "");
    },
    designOption(design){
      this.showDesign = false;
      this.designComponent = design;
    },
    resetDesignPage() {
      this.showDesign = true;
    }
  },
  components: {
    NavbarDesign,
    BodyDesign,
    LogoDesign,
  }
};
</script>
<style scoped>
.child-menu-inner {
  overflow-y: scroll;
  width: 100%;
  padding-bottom: 40px;
}
#inner-menu {
  padding: 0 4px;
}
.label-color {
  color: #8c9caf;
}
.custom {
  border-top: 1px solid #6f8092;
  padding: 12px 8px 12px 10px;
}
.border-wrap {
  border: 1px solid #6f8092;
  min-height: 40px;
  border-radius: 4px 4px 4px 4px;
  padding: 10px 0 0;
  margin-bottom: 10px;
}
.vc-compact {
  background-color: transparent;
  box-shadow: 0 0 0;
  padding: 10px;
  width: 200px;
}

.p-label {
  color: #c6cdd4;
}
.p-inner-label {
  padding-left: 10px;
  color: #8c9caf !important;
}
.font-icon {
  padding-left: 5px;
}
#icon {
  color: #9a9a9a;
}
#blah {
  width: 100%;
}
.title-button {
  width: 100%;
  display: block;
  background: #2f82c9;
  color: white;
  margin-top: 5px;
  border: none;
  text-shadow: 0px 0px 0px;
  box-shadow: 0 0 0 rgba(0, 0, 0, 0);
  border-radius: 5px 5px 5px 5px;
}

.form-control {
  padding: 8px;
}
input.input {
  background: transparent;
  color: white;
}
.select-font {
  background: transparent;
  color: white;
  padding: 5px;
  margin: 8px !important;
  width: 93%;
}
.option-font {
  background-color: #344258;
  color: white;
}
.choose-file {
  background: #13a1ee;
  border: none;
  padding: 8px 0;
  color: #fff;
  font-size: 14px;
  margin-bottom: 10px;
  line-height: 1;
  text-align: center;
}
.file-upload {
  /* padding: 10px; */
  /* margin: 0; */
  width: 220px;
  margin: 10px 5px 100px 5px;
}
.file-label {
  width: 100%;
}
</style>
<style>
.vc-chrome {
  transform: translate(-8px, -10px);
}
.vc-compact-color-item {
  /* border: 2px solid #6f8092; */
  width: 25px;
  height: 25px;
  margin-right: 4px;
  margin-bottom: 10px;
  border: 1.5px solid white;
  border-radius: 4px;
}
::-webkit-scrollbar {
  width: 2px;
}
</style>
