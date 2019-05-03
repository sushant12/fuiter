<!-- <template>
  <div>
    <a @click="designMenu" class="back">
      <i class="fa fa-arrow-circle-left"/>Go back
    </a>
    <span class="p-label">Background Color</span>
    <span
      class="is-primary tooltip is-tooltip-right is-tooltip-warning"
      data-tooltip="Select color for texts, buttons and overlays"
    >
      <i class="fa fa-question-circle has-text-grey-lighter"/>
    </span>
    <div class="border-wrap">
      <p class="p-inner-label">Suggested Colors</p>
      <compact-picker :value="bgColor" v-model="bgColor" :palette="suggestedBgColor"></compact-picker>
      <div class="custom">
        <span class="palette" @click="showColorPicker" tabindex="0" @blur="hideColorPicker">
          <div class="dropdown" id="custom-bg-color">
          
          <div class="dropdown-trigger">
            <span aria-hidden="true" aria-haspopup="true" aria-controls="dropdown-menu">
              <i class="fa fa-angle-down has-text-white"></i>
            </span>
          </div>
            <div class="dropdown-menu" id="dropdown-menu" role="menu" style="min-width: 100px;">
              <chrome-picker v-model="bgColor" ></chrome-picker>
            </div>&nbsp;
          <span class="label-color palette">Select a custom color</span>
        </div>
        </span>
        
      </div>
    </div>

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

    <span class="p-label">Font Color</span>
    <span
      class="is-primary tooltip is-tooltip-right is-tooltip-warning"
      data-tooltip="Select color for texts, buttons and overlays"
    >
      <i class="fa fa-question-circle has-text-grey-lighter"/>
    </span>
    <div class="border-wrap">
      <p class="p-inner-label">Suggested Colors</p>
      <compact-picker :value="fontColor" v-model="fontColor" :palette="suggestedFontColor"></compact-picker>
      <div class="custom">
        <span class="palette" @click="showColorPicker" tabindex="0" @blur="hideColorPicker">
          <div class="dropdown" id="custom-font-color">
          
          <div class="dropdown-trigger">
            <span aria-hidden="true" aria-haspopup="true" aria-controls="dropdown-menu">
              <i class="fa fa-angle-down has-text-white"></i>
            </span>
          </div>
            <div class="dropdown-menu" id="dropdown-menu" role="menu" style="min-width: 100px;">
              <chrome-picker v-model="fontColor" ></chrome-picker>
            </div>&nbsp;
          <span class="label-color palette">Select a custom color</span>
        </div>
        </span>
        
      </div>
    </div>

    <span class="p-label">Font Size</span>
    <span
      class="font-icon tooltip is-tooltip-bottom is-tooltip-warning"
      data-tooltip="Set title of website"
    >
      <i class="fa fa-question-circle has-text-grey-lighter" aria-hidden="true" id="icon"></i>
    </span>
    <div class="border-wrap">
      <div class="form-control">
        <input class="input" type="text" v-model="fontSize">
      </div>
    </div>

    <button class="button is-info" @click="updateProperty">Save</button>
  </div>
</template>

<script>
import _ from "lodash";
import { Chrome, Compact } from "vue-color";
import EditorServices from "../../../services/index.js";
import FontServices from "../../../services/googleFont.js";

export default {
  props: ["template", "defaultTemplateValue"],
  data(){
    return {
      // color: {
      //   hex: ""
      // },
      // suggestedColor: [],
      selectedFont: null,
      suggestedFonts: [],
      googleFonts: [],
      customTemplateProperties: {},

      // body: {
      //   color: {
      //     hex: ""
      //   },
      //   suggested_bg_color: [],
      //   suggested_hover_color:  [],
      //   suggested_font: [],
      // }

      bgColor: {
        hex: ""
      },
      fontColor: {
        hex: ""
      },
      suggestedBgColor: [],
      suggestedFontColor:  [],
      fontSize: 12,
    };
  },

  methods: {
    showColorPicker(e) {
      e.stopPropagation();
      const el = document.getElementById(e.currentTarget.firstChild.id);
      const notColorPicker = e.target.classList.contains("palette") || e.target.classList.contains("fa-angle-down")
      if(notColorPicker){
        el.classList.toggle('is-active');
      }
    },
    hideColorPicker(e){
      const el = document.getElementById(e.currentTarget.firstChild.id);
      el.classList.remove("is-active");
    },
    updateProperty() {
      const formData = new FormData();
      const navbarDesign = !_.isNil(this.customTemplateProperties) && !_.isNil(this.customTemplateProperties['nav']);
      // since we are updating the same json
      // we do not want to overrid the json data for the body
      // so we are checking it here to make sure it is not overridden
      if(navbarDesign){
        formData.append("template[properties][nav][bg_color]", this.customTemplateProperties['nav']['bg_color']);
        formData.append("template[properties][nav][font_color]", this.customTemplateProperties['nav']['font_color']);
        formData.append("template[properties][nav][hover_color]", this.customTemplateProperties['nav']['hover_color']);
        formData.append("template[properties][nav][font_size]", this.customTemplateProperties['nav']['font_size']);
        formData.append("template[properties][nav][font]", this.customTemplateProperties['nav']['font']);
      }
      formData.append("template[properties][body][bg_color]", this.bgColor["hex"] || this.bgColor);
      formData.append("template[properties][body][font_color]", this.fontColor["hex"] || this.fontColor);
      formData.append("template[properties][body][font_size]", this.fontSize);
      formData.append("template[properties][body][font]", this.selectedFont || "");
      EditorServices.updateProperties(
        formData, 
        this.template.id,
        this.template.fb_page_id
      )
      .then(() => {
        document.getElementById("frame").contentWindow.location.reload();
      });
    },
    designMenu() {
      this.$emit("clicked-design-menu", "");
    }
  },
  mounted() {
    const that = this;
    // this.suggestedColor = this.defaultTemplateValue["properties"]["suggested_color"];
    // this.suggestedFonts = this.defaultTemplateValue["properties"]["suggested_font"];
    const defaultBodyValue = this.defaultTemplateValue["properties"]["body"];
    this.suggestedBgColor = defaultBodyValue["suggested_bg_color"];
    this.suggestedFonts = defaultBodyValue["suggested_font"];
    this.suggestedFontColor = defaultBodyValue["suggested_font_color"];

    FontServices.getFonts()
      .then(({data}) => {
        data.items.forEach(item => {
          that.googleFonts.push(item.family);
        });
      });

    EditorServices.getFbPageTemplate(this.template['id'])
      .then(({data}) => {
        that.customTemplateProperties = data["properties"];
        if (!_.isNil(this.customTemplateProperties) && !_.isNil(data["properties"]) && !_.isNil(data["properties"]['body'])) {
          that.selectedFont = data["properties"]['body']["font"];
          that.bgColor = data["properties"]['body']["bg_color"];
          that.fontColor = data["properties"]['body']["font_color"];
          that.fontSize = data["properties"]['body']["font_size"];
        }
      });
  },
  components: {
    "chrome-picker": Chrome,
    "compact-picker": Compact
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


 -->