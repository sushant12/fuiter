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
    <span class="p-label">Font</span>
    <span
      class="font-icon tooltip is-tooltip-right is-tooltip-warning"
      data-tooltip="Select font of website"
    >
      <i class="fa fa-question-circle has-text-grey-lighter" aria-hidden="true" id="icon"></i>
    </span>
    <div class="border-wrap">
      <p class="p-inner-label">Suggested Font</p>
      <select class="select-font" v-model="selectedFont">
        <option value="null" class="option-font">Choose Font</option>
        <option
          class="option-font"
          v-for="font in suggestedFonts"
          :style="{fontFamily: font }"
        >{{font}}</option>
      </select>
      <p class="p-inner-label">Google Font</p>
      <select class="select-font" v-model="selectedFont">
        <option value="null" class="option-font">Choose Font</option>
        <option
          class="option-font"
          v-for="font in googleFonts"
          :style="{fontFamily: font }"
        >{{font}}</option>
      </select>
    </div>
    <span class="p-label">Theme Color</span>
    <span
      class="font-icon tooltip is-tooltip-right is-tooltip-warning"
      data-tooltip="Select font of website"
    >
      <i class="fa fa-question-circle has-text-grey-lighter" aria-hidden="true" id="icon"></i>
    </span>
    <div class="border-wrap">
      <div v-for="themeColor in themeColors">
        <input type="radio" :value="themeColor['name']" v-model="selectedThemeColor">
        <label>{{ themeColor['name'] }}</label>
        <div v-for="colors in themeColor['options']">
          {{ colors }}
        </div>
      </div>
    </div>
    <button class="button is-info" @click="updateProperty">Save</button>
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
import EditorServices from "../../services/index.js";
import FontServices from "../../services/googleFont.js";
import LogoDesign from './design/logo';

export default {
  props: ["template", "templates_url", "default_template_value"],
  data() {
    return {
      showDesign: true,
      designComponent: "",
      selectedFont: null,
      suggestedFonts: [],
      googleFonts: [],
      themeColors: [],
      selectedThemeColor: null
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
    },
    updateProperty() {
      EditorServices.saveFbPageTemplate(
        this.template['id'],{
          properties: {
            theme: {
              font: this.selectedFont,
              color: this.selectedThemeColor
            }
          }
        }
      )
      .then(() => {
        document.getElementById("frame").contentWindow.location.reload();
      });
    }
  },
  mounted() {
    const that = this;
    const themeDefault = this.default_template_value['properties']['theme'];
    this.themeColors = themeDefault['color'];
    this.suggestedFonts = themeDefault['font'];
    FontServices.getFonts()
      .then(({data}) => {
        data.items.forEach(item => {
          that.googleFonts.push(item.family);
        });
      });

    EditorServices.getFbPageTemplate(this.template['id'])
      .then(({data}) => {
        const theme = data['properties']['theme'];
        that.selectedFont =  theme['font'];
        that.selectedThemeColor = theme['color'];
      });
  },
  components: {
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
