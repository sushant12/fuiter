<template>
  <section class="pages-settings-box">
    <a @click="pageMenu" class="back">
      <i class="fa fa-arrow-circle-left"/>Go back
    </a>
    <div v-if="page.uri === 'home'" class="pages-settings field" style="margin-top:0;">
      <h5 class="pt-1 pb-1">Title</h5>
      <div>
        <input type="text" v-model="pageData['title']" name="title" class="input sidebar-inputs">
      </div>
      <h5 class="pt-1 pb-1">
        Description
        <span
          class="is-primary tooltip is-tooltip-top is-tooltip-warning"
          data-tooltip="Select Description Source"
        >
          <i class="fa fa-question-circle has-text-grey-lighter"/>
        </span>
      </h5>
      <div class="row-radio">
        <input
          type="radio"
          value="false"
          v-model="pageData['setting']['description']['enable']"
          @click="hideDescription()"
        >
        <span>Facebook</span>
      </div>
      <div class="pt-1 pb-1">
        <input
          type="radio"
          value="true"
          v-model="pageData['setting']['description']['enable']"
          @click="showDescription()"
        >
        <span>Custom</span>
      </div>

      <textarea
        placeholder="Write Custom Description"
        class="pages-setting-textarea"
        rows="6"
        v-if="pageData['setting']['description']['enable'] === 'true'"
        v-model="pageData['setting']['description']['value']"
      ></textarea>
    </div>
    <!--  -->
    <div v-else-if="page.uri === 'contact'" class="pages-settings field" style="margin-top:0;">
      <h5 class="pb-1">Title</h5>
      <div>
        <input class="input sidebar-inputs" type="text" v-model="pageData['title']" name="title">
      </div>
      <div class="mt-2 page-setting-partition-box">
        <span>Show map?</span>
        <input type="checkbox" value="true" v-model="map_enable">
      </div>

      <div class="mt-2 page-setting-partition-box">
        <span>Display email?</span>
        <input type="checkbox" value="true" v-model="email_enable">
      </div>
      <input class="input sidebar-inputs" type="email" name="email" v-model="email">

      <div class="mt-2 page-setting-partition-box">
        <span>Display address?</span>
        <input type="checkbox" value="true" v-model="location_enable">
      </div>
      <input class="input sidebar-inputs" type="text" name="location" v-model="location">

      <div class="mt-2 page-setting-partition-box">
        <span>Display contact?</span>
        <input type="checkbox" value="true" v-model="contact_enable">
      </div>
      <input class="input sidebar-inputs" type="number" name="contact" v-model="contact">
    </div>
    <!--  -->
    <div v-else-if="page.uri === 'about'" class="page-setting field" style="margin-top:0;">
      <h5>Title</h5>
      <input class="input sidebar-inputs" type="text" v-model="pageData['title']" name="title">
      <h5 class="mt-2">
        Main Image
        <span
          class="is-primary tooltip is-tooltip-top is-tooltip-warning"
          data-tooltip="Select Profile Picture Source"
        >
          <i class="fa fa-question-circle has-text-grey-lighter"/>
        </span>
      </h5>
      <div>
        <input
          type="radio"
          name="image"
          value="false"
          v-model="pageData['setting']['image']['enable']"
          @click="hideImage()"
        >
        <span>Facebook Profile Picture</span>
      </div>
      <div>
        <input
          type="radio"
          name="image"
          value="true"
          v-model="pageData['setting']['image']['enable']"
          @click="showImage()"
        >
        <span>Upload Image</span>
      </div>
      <picture-input
        v-if="pageData['setting']['image']['enable'] == 'true'"
        ref="pictureInput"
        @change="onChanged"
        @remove="onRemoved"
        width="200"
        height="200"
        margin="16"
        accept="image/jpeg, image/png"
        size="10"
        :prefill="aboutImage"
        :removable="true"
        button-class="btn"
        :custom-strings="{
            upload: '<h1>Bummer!</h1>',
            drag: 'Drag a 😺 GIF or GTFO'
          }"
      ></picture-input>
      <h5 class="mt-2">
        Description
        <span
          class="is-primary tooltip is-tooltip-top is-tooltip-warning"
          data-tooltip="Select Description in About page"
        >
          <i class="fa fa-question-circle has-text-grey-lighter"/>
        </span>
      </h5>
      <div>
        <input
          type="radio"
          value="false"
          v-model="pageData['setting']['description']['enable']"
          @click="hideDescription()"
        >
        <span>Facebook Description</span>
      </div>
      <div>
        <input
          type="radio"
          value="true"
          v-model="pageData['setting']['description']['enable']"
          @click="showDescription()"
        >
        <span>Custom</span>
      </div>

      <textarea
        rows="5"
        v-if="pageData['setting']['description']['enable'] === 'true'"
        v-model="pageData['setting']['description']['value']"
      ></textarea>
    </div>

    <div v-else-if="page.uri === 'events'" class="page-setting field" style="margin-top:0;">
      <h5>Title</h5>
      <input class="input sidebar-inputs" type="text" name="title" v-model="pageData['title']">
    </div>
    <div v-else-if="page.uri === 'gallery'" class="page-setting field" style="margin-top:0;">
      <h5>Title</h5>
      <input class="input sidebar-inputs" type="text" name="title" v-model="pageData['title']">
    </div>
    <div v-else-if="page.uri === 'news'" class="page-setting field" style="margin-top:0;">
      <h5>Title</h5>
      <input class="input sidebar-inputs" type="text" v-model="pageData['title']" name="title">
    </div>
    <button @click="savePageSetting()" class="button is-info">Save</button>
  </section>
</template>
<script>
import _ from "lodash";
import EditorService from "../../../services/index";
import PictureInput from "vue-picture-input";

export default {
  props: ["pageId", "template"],
  data() {
    return {
      page: "",
      aboutImage: "",
      pageData: {
        title: "",
        setting: {
          image: {
            value: "",
            enable: false
          },
          description: {
            value: "",
            enable: false
          }
        }
      },
      email: "",
      location: "",
      contact: "",
      email_enable: "",
      location_enable: "",
      contact_enable: "",
      map_enable: ""
    };
  },
  methods: {
    showDescription() {
      this.pageData["setting"]["description"]["enable"] = true;
    },
    hideDescription() {
      this.pageData["setting"]["description"]["enable"] = false;
    },
    showImage() {
      this.pageData["setting"]["image"]["enable"] = true;
    },
    hideImage() {
      this.pageData["setting"]["image"]["enable"] = false;
    },
    savePageSetting() {
      const that = this;
      const formData = new FormData();
      formData.append("title", this.pageData["title"]);
      formData.append("about_image", this.aboutImage);
      formData.append(
        "setting[image][enable]",
        this.pageData["setting"]["image"]["enable"]
      );

      formData.append(
        "setting[description][value]",
        this.pageData["setting"]["description"]["value"]
      );
      formData.append(
        "setting[description][enable]",
        this.pageData["setting"]["description"]["enable"]
      );

      EditorService.savePage(this.pageId, formData).then(() => {
        EditorService.saveFbPageTemplate(this.template['id'], {
          email: that.email,
          location: that.location,
          contact: that.contact,
          email_enable: that.email_enable,
          location_enable: that.location_enable,
          contact_enable: that.contact_enable,
          map_enable: that.map_enable
        }).then(() => {
          document.getElementById("frame").contentWindow.location.reload();
        });
      });
    },
    onChanged() {
      this.aboutImage = this.$refs.pictureInput.file;
    },
    onRemoved() {
      this.aboutImage = "";
    },
    pageMenu() {
      this.$emit("clicked-page-menu", "");
    }
  },
  created() {
    const that = this;
    EditorService.getPage(this.pageId).then(({ data }) => {
      that.page = data;
      that.pageData["title"] = data.title;
      that.pageData["setting"]["description"]["value"] =
        data.setting["description"]["value"];
      that.pageData["setting"]["description"]["enable"] =
        data.setting["description"]["enable"];
      that.pageData["setting"]["image"]["enable"] =
        data.setting["image"]["enable"];
      that.aboutImage = data.about_image.url;
    });
    EditorService.getFbPageTemplate(this.template['id']).then(({ data }) => {
      that.email = data.email;
      that.location = data.location;
      that.contact = data.contact;
      that.email_enable = data.email_enable;
      that.location_enable = data.location_enable;
      (that.contact_enable = data.contact_enable),
        (that.map_enable = data.map_enable);
    });
  },
  components: {
    PictureInput
  }
};
</script>
<style scoped>
.drag-info {
  display: none;
}
textarea {
  width: 100%;
  background-color: transparent;
  color: white;
  padding: 5px;
  margin-right: 10px;
}
textarea ::placeholder {
  color: darkgray;
}
span {
  color: white;
}
.input-partion {
  width: 90%;
}
.page-setting-partition-box {
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 100%;
}

/* .page-setting input {
  padding: 10px 10px;
  margin: 0 20px; */
/* border-bottom: 2px dashed #818a97; */
/* color: #878787; */
/* background-color: white; */
/* border-style: none none dashed none; */
/* font-size: 1.2rem;
  margin-bottom: 10px;
  border-radius: 5px; */
/* } */
input:focus {
  outline: none;
}
input[type="checkbox"],
input[type="radio"] {
  transform: scale(1.5);
  margin-right: 10px;
}

h6 {
  color: white;
  margin: 20px 20px;
  font-weight: inherit;
  font-style: inherit;
}

.button {
  width: 96%;
  margin: 0 2%;
  margin-bottom: 100px;
}
section:last-child {
  margin-bottom: 100px;
  /* height: 100vh; */
  /* overflow-y: scroll; */
}
section {
  overflow-y: auto;
  height: 100vh;
  /* padding-right: 20px; */
}
::-webkit-scrollbar {
  width: 2px;
}
</style>