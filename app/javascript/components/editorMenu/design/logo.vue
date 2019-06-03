<template>
  <div class="icon-select" id="inner-menu">
    <a @click="designMenu" class="back">
      <i class="fa fa-arrow-circle-left"/>Go back
    </a>
    <span class="p-label ">Site Title</span>
    <span
      class="font-icon tooltip is-tooltip-bottom is-tooltip-warning"
      data-tooltip="Set title of website"
    >
      <i class="fa fa-question-circle has-text-grey-lighter" aria-hidden="true" id="icon"></i>
    </span>
    <div class="border-wrap">
      <div class="form-control">
        <input class="input siteTitle" type="text" v-model="siteTitle">
      </div>
    </div>

    <p class="p-label pt-10">Add your logo to your site</p>
    <div class="x border-wrap file-upload">
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
            size="1"
            :prefill="logo"
            :removable="true"
            button-class="btn"
            :custom-strings="{
                upload: '<h1>Bummer!</h1>',
                drag: 'Drag a 😺 GIF or GTFO'
              }"
          ></picture-input>
          <span  class="button is-info choose-file">Choose a file</span>
          <p class="p-label"> file format: GIF, GTIF </p>
        </label>
      </div>
    </div>

    <p class="p-label pt-10">Add your favicon to your site</p>
    <div class="x border-wrap file-upload">
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
            size="1"
            :prefill="favicon"
            :removable="true"
            button-class="btn"
            :custom-strings="{
                upload: '<h1>Bummer!</h1>',
                drag: 'Drag a 😺 GIF or GTFO'
              }"
          ></picture-input>
          <span class="button is-info choose-file">Choose a file</span>
          <p class="p-label"> file format: GIF, GTIF </p>

        </label>
      </div>
    </div>
    <button class="button is-info submit-btn" @click="updateProperty">Save</button>
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
      formData.append("template[title]", this.siteTitle || '');
      formData.append("template[logo]", this.logo);
      formData.append("template[favicon]", this.favicon);
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
    const that = this;
    EditorServices.getFbPageTemplate(this.template['id'])
      .then(({data}) => {
        that.siteTitle = data['title'];
        that.logo = data['logo']['url'];
        that.favicon = data['favicon']['url'];
      });
  },
  components: {
    PictureInput,
  },
};
</script>

<style scoped>

.siteTitle{
  width:95%;
  margin-left: 8px;
}
.main-sidebar{
  width:100%;
}
.p-label{
  color:darkgray;
  font-size: 14px;
  text-align:center;
}
.pt-10{
  padding-top:10px;
}
.is-boxed{
  width: 100%;
}
label{
  width: inherit;
}
.file-label{
  padding: 20px;

}
.file-label .choose-file{
  margin: 10px 18px 10px 18px;
  padding-top: 10px;
}

</style>
<style>
.picture-inner .picture-inner-text{
  color: darkgray;
}
.preview-container{
  width: 128px;
  height: 128px;
}
.choose-file{
  padding: 20px;
}
.submit-btn{
  width:210px;
  margin:5px 20px 100px 20px;
}
.picture-input{
  margin-bottom: 10px;
}
</style>
