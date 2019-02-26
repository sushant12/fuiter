<template>
  <section>
    <a @click="settingMenu" class="back">
      <i class="fa fa-arrow-circle-left"/>Go back
    </a>
    <div class="field">
      <h1 class="subtitle">Social</h1>
      <h6>Connecting to social services enables you to push or pull data, and allow visitors to connect with you via those services.</h6>
      <h6>Add social sites URL</h6>
      <div class="control" v-for="(option, index) in social" :key="index">
        <div class="columns">
          <div class="column is-1">
            <i :class="option.icon"/>
          </div>
          <div class="column">
            <input
              class="input"
              type="text"
              v-model="option.name"
              :placeholder="option.placeholder"
            >
          </div>
        </div>
      </div>
      <button class="button is-info" @click="updateSetting">Save</button>
    </div>
  </section>
</template>

<script>
import EditorServices from "../../services/index.js";
export default {
  props: ["fb_page_id", "template"],
  data() {
    return {
      social: [
        { name: "", placeholder: "Facebook URL", icon: "fa fa-facebook" },
        { name: "", placeholder: "LinkedIn URL", icon: "fa fa-linkedin" },
        { name: "", placeholder: "Twitter URL", icon: "fa fa-twitter" },
        { name: "", placeholder: "Youtube URL", icon: "fa fa-youtube" },
        { name: "", placeholder: "Instagram URL", icon: "fa fa-instagram" },
        { name: "", placeholder: "Pinterest URL", icon: "fa fa-pinterest" }
      ]
    };
  },
  methods: {
    settingMenu() {
      this.$emit("clicked-setting-menu", "");
    },
    updateSetting() {
      this.social.forEach((item, index) => {
        delete item.placeholder;
        delete item.icon;
      });
      EditorServices.updateSetting(this.fb_page_id, {
        socail_media: { social: this.social },
        fb_page_template_id: this.template.id
      }).then(resp => {
        document.getElementById("frame").contentWindow.location.reload();
        this.addPlaceholder(resp.data);
        this.addSocialIcon(resp.data);
      });
    },
    addPlaceholder(settingData) {
      if (!_.isNil(settingData)) {
        this.social = settingData.socail_media.social;
        this.social[0].placeholder = "Facebook URL";
        this.social[1].placeholder = "LinkedIn URL";
        this.social[2].placeholder = "Twitter URL";
        this.social[3].placeholder = "Youtube URL";
        this.social[4].placeholder = "Instagram URL";
        this.social[5].placeholder = "Pinterest URL";
      }
    },
    addSocialIcon(settingData) {
      if (!_.isNil(settingData)) {
        this.social = settingData.socail_media.social;
        this.social[0].icon = "fa fa-facebook";
        this.social[1].icon = "fa fa-linkedin";
        this.social[2].icon = "fa fa-twitter";
        this.social[3].icon = "fa fa-youtube";
        this.social[4].icon = "fa fa-instagram";
        this.social[5].icon = "fa fa-pinterest";
      }
    }
  },
  created() {
    EditorServices.showSetting(this.template.id).then(res => {
      this.addPlaceholder(res.data);
      this.addSocialIcon(res.data);
    });
  }
};
</script>

<style scoped>
.field {
  color: #fff;
  margin: 20px 15px;
}
.subtitle {
  color: #fff;
  margin-bottom: 20px;
}
h6 {
  font-size: 13px;
  margin: 14px 0;
}
input {
  margin-bottom: 10px;
}
.column.is-1 {
  width: 2%;
}
i {
  color: #fff;
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

