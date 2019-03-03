<template>
  <div class="child-menu-inner" id="inner-menu">
    <a @click="mainMenu" class="back">
      <i class="fa fa-arrow-circle-left"/>Go back
    </a>
    <br>
    <span class="p-label">Color</span>
    <span class="font-icon tooltip is-tooltip-right" data-tooltip="Select color of texts">
      <i class="fa fa-question-circle" aria-hidden="true" id="icon"></i>
    </span>
    <div class="border-wrap">
      <p class="p-inner-label">Suggested Colors</p>
      <compact-picker v-model="color" @input="changeColor" :palette="palette"></compact-picker>
      <div class="custom">
        <span class="palette">
          <div class="dropdown is-hoverable">
            <div class="dropdown-trigger">
              <span aria-hidden="true" aria-haspopup="true" aria-controls="dropdown-menu">
                <i class="fa fa-angle-down" style="color: white;"></i>
              </span>
            </div>
            <div class="dropdown-menu" id="dropdown-menu" role="menu" style="min-width: 100px;">
              <chrome-picker v-model="color" @input="changeColor"></chrome-picker>
            </div>
          </div>
        </span>
        <span class="label-color palette">Select a custom color</span>
      </div>
    </div>
    <span class="p-label">Site Title</span>
    <span class="font-icon tooltip is-tooltip-right" data-tooltip="Set title of website">
      <i class="fa fa-question-circle" aria-hidden="true" id="icon"></i>
    </span>
    <div class="border-wrap">
      <div class="form-control">
        <input class="input" type="text" v-model="title">
        <button class="button title-button is-link" @click="changeTitle(title)">Save</button>
      </div>
    </div>

    <span class="p-label">Font</span>
    <span class="font-icon tooltip is-tooltip-right" data-tooltip="Select font of website">
      <i class="fa fa-question-circle" aria-hidden="true" id="icon"></i>
    </span>
    <div class="border-wrap">
      <p class="p-inner-label">Suggested Font</p>
      <select class="select-font" v-model="selectedFont" @change="changeFont">
        <option value="null" class="option-font">Choose Font</option>
        <option
          class="option-font"
          v-for="font in fonts"
          :key="font"
          :style="{fontFamily: font }"
        >{{font}}</option>
      </select>
      <p class="p-inner-label">Google Font</p>
      <select class="select-font" v-model="selectedFont" @change="changeFont">
        <option value="null" class="option-font">Choose Font</option>
        <option
          class="option-font"
          v-for="font in googlefonts"
          :key="font"
          :style="{fontFamily: font }"
        >{{font}}</option>
      </select>
    </div>

    <p class="p-label">Logo</p>
    <div class="field border-wrap file-upload">
      <div class="file has-name is-boxed">
        <label class="file-label">
          <img id="blah" :src="image" alt="your image">
          <input
            class="file-input"
            type="file"
            name="resume"
            @change="handleImageUpload"
            ref="file"
          >
          <span class="has-text-white">{{fileName}}</span>
          <span class="choose-file">Choose a file</span>
        </label>
      </div>
    </div>
  </div>
</template>
<script>
import _ from "lodash";
import { Chrome, Compact } from "vue-color";
import EditorServices from "../../services/index.js";
import FontServices from "../../services/googleFont.js";
export default {
  props: ["template"],
  data() {
    return {
      image: "http://placehold.it/180",
      color: {
        hex: ""
      },
      logo: null,
      palette: [
        "#B0BC00",
        "#68BC00",
        "#16A5A5",
        "#009CE0",
        "#7B64FF",
        "#FA28FF"
      ],
      title: "",
      selectedFont: null,
      fonts: [
        "Arial",
        "Helvetica",
        "Times New Roman",
        "Times",
        "Courier New",
        "Courier",
        "Verdana"
      ],
      googlefonts: []
    };
  },
  created() {
    FontServices.getFonts().then(response => {
      response.data.items.forEach(item => {
        this.googlefonts.push(item.family);
      });
    });
  },
  methods: {
    mainMenu() {
      this.$emit("clicked-main-menu", "");
    },
    handleImageUpload(input) {
      this.logo = this.$refs.file.files[0];
      // this.fileName = this.logo.name;
      this.image = URL.createObjectURL(this.logo);
      const frame = document.getElementById("frame").contentDocument;
      const fuitterLogo = frame.getElementById("fuitter-logo");
      fuitterLogo.src = this.image;
      this.updateProperty();
    },
    changeColor(e) {
      const color = this.color["hex"];
      const frame = document.getElementById("frame").contentDocument.body;
      const colorClass = frame.getElementsByClassName("fuitter-color");
      _.each(colorClass, el => {
        el.style.color = color;
      });
      this.updateProperty();
    },
    changeFont(e) {
      const font = e.target.value;
      const frame = document.getElementById("frame").contentDocument.body;
      frame.style.fontFamily = font;
      this.updateProperty();
    },
    changeTitle(title) {
      const frame = document.getElementById("frame").contentDocument;
      const titleClass = frame.getElementById("fuitter-title");
      titleClass.innerHTML = title;
      this.updateProperty();
    },
    updateProperty() {
      const formData = new FormData();
      formData.append("template[logo]", this.logo || "");
      formData.append("template[properties][font]", this.selectedFont || "");
      formData.append("template[properties][color]", this.color["hex"] || "");
      formData.append("template[properties][title]", this.title || "");
      const template_id = this.template.id;
      const fb_page_id = this.template.fb_page_id;
      EditorServices.updateProperties(formData, template_id, fb_page_id);
    }
  },
  mounted() {
    if (!_.isNil(this.template["properties"])) {
      this.selectedFont = this.template["properties"]["font"];
      this.color = this.template["properties"]["color"];
      // this.logo = this.template['logo'].url;
      this.image = this.template["logo"].url;
      this.title = this.template["properties"]["title"];
    }
  },
  components: {
    "chrome-picker": Chrome,
    "compact-picker": Compact
  }
};
</script>
<style scoped>
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
  padding: 10px;
  margin: 0;
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
.back {
  padding: 20px 25px;
  display: flex;
  color: #818a97;
}
.back:hover {
  color: #00b289;
  background-color: black;
}
.back i {
  margin-right: 10px;
  color: #818a97;
  font-size: 1.1rem;
  display: flex;
  align-items: center;
}
</style>
