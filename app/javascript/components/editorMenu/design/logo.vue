<template>
  <div>
    <a @click="designMenu" class="back">
      <i class="fa fa-arrow-circle-left"/>Go back
    </a>
    <span class="p-label">Site Title</span>
    <span
      class="font-icon tooltip is-tooltip-bottom is-tooltip-warning"
      data-tooltip="Set title of website"
    >
      <i class="fa fa-question-circle has-text-grey-lighter" aria-hidden="true" id="icon"></i>
    </span>
    <div class="border-wrap">
      <div class="form-control">
        <input class="input" type="text" v-model="siteTitle">
      </div>
    </div>

    <p class="p-label">Logo</p>
    <div class="field border-wrap file-upload">
      <div class="file has-name is-boxed">
        <label class="file-label">
          <picture-input
            ref="logoInput"
            @change="onChangedLogo"
            @remove="onRemovedLogo"
            width="200"
            height="200"
            margin="16"
            accept="image/jpeg, image/png"
            size="10"
            :prefill="logo"
            :removable="true"
            button-class="btn"
            :custom-strings="{
                upload: '<h1>Bummer!</h1>',
                drag: 'Drag a 😺 GIF or GTFO'
              }"
          ></picture-input>
          <span class="choose-file">Choose a file</span>
        </label>
      </div>
    </div>

    <p class="p-label">Favico</p>
    <div class="field border-wrap file-upload">
      <div class="file has-name is-boxed">
        <label class="file-label">
          <picture-input
            ref="faviconInput"
            @change="onChangedFavicon"
            @remove="onRemovedFavicon"
            width="200"
            height="200"
            margin="16"
            accept="image/ico, image/png"
            size="10"
            :prefill="favicon"
            :removable="true"
            button-class="btn"
            :custom-strings="{
                upload: '<h1>Bummer!</h1>',
                drag: 'Drag a 😺 GIF or GTFO'
              }"
          ></picture-input>
          <span class="choose-file">Choose a file</span>
        </label>
      </div>
    </div>
    <button class="button is-info" @click="updateProperty">Save</button>
  </div>  
</template>

<script>
import PictureInput from "vue-picture-input";
import EditorServices from "../../../services/index.js";

export default{
  props: ["template", "defaultTemplateValue"],

  data(){
    return {
      siteTitle: '',
      logo: '',
      favicon: '',
    };
  },
  methods: {
    onChangedLogo() {
      this.logo = this.$refs.logoInput.file;
    },
    onRemovedLogo() {
      this.logo = "";
    },
    onChangedFavicon() {
      this.favicon = this.$refs.faviconInput.file;
    },
    onRemovedFavicon() {
      this.favicon = "";
    },
    updateProperty(){
      const formData = new FormData();
      formData.append("template[title]", this.siteTitle);
      formData.append("template[logo]", this.logo);
      formData.append("template[favicon]", this.favicon);
      debugger
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
  mounted(){
    EditorServices.getFbPageTemplate(this.template['id'])
      .then(({data}) => {
        this.siteTitle = data['title'];
        this.logo = data['logo']['url'];
        this.favicon = data['favicon']['url'];
      });
  },
  components: {
    PictureInput,
  },
};
</script>

<style>
  
</style>