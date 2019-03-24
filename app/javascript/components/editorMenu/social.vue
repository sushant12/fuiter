<template>
  <section>
    <a @click="mainMenu" class="back">
      <i class="fa fa-arrow-circle-left"/>Go back
    </a>
    <div class="field">
      <h1 class="subtitle">Social</h1>
      <h6>Connecting to social services enables you to push or pull data, and allow visitors to connect with you via those services.</h6>
      <h6>Add social sites URL</h6>
      <div class="control" v-for="(option, index) in social" :key="index">
        <div class="social-link-list">
          <!-- <div class="social-icon"> -->
          <i :class="option.icon"/>
          <!-- </div> -->
          <!-- <div class="social-link"> -->
          <input
            class="input sidebar-inputs"
            type="text"
            v-model="option.name"
            :placeholder="option.placeholder"
          >
          <!-- </div> -->
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
        {
          name: "",
          placeholder: " Facebook URL",
          icon: "fab fa-facebook",
          class: "fontAwesome"
        },
        { name: "", placeholder: "Instagram URL", icon: "fab fa-instagram" },
        { name: "", placeholder: "Youtube URL", icon: "fab fa-youtube" },
        { name: "", placeholder: "Twitter URL", icon: "fab fa-twitter" },
        { name: "", placeholder: "LinkedIn URL", icon: "fab fa-linkedin" },
        { name: "", placeholder: "Pinterest URL", icon: "fab fa-pinterest" },
        { name: "", placeholder: "Yelp URL", icon: "fab fa-yelp" }
      ]
    };
  },
  methods: {
    mainMenu() {
      this.$emit("clicked-main-menu", "");
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
        this.social[1].placeholder = "Instagram URL";
        this.social[2].placeholder = "Youtube URL";
        this.social[3].placeholder = "Twitter URL";
        this.social[4].placeholder = "Linkedin URL";
        this.social[5].placeholder = "Pinterest URL";
        this.social[6].placeholder = "Yelp URL";
      }
    },
    addSocialIcon(settingData) {
      if (!_.isNil(settingData)) {
        this.social = settingData.socail_media.social;
        this.social[0].icon = "fa fa-facebook";
        this.social[1].icon = "fa fa-instagram";
        this.social[2].icon = "fa fa-youtube";
        this.social[3].icon = "fa fa-twitter";
        this.social[4].icon = "fa fa-linkedin";
        this.social[5].icon = "fa fa-pinterest";
        this.social[6].icon = "fa fa-yelp";
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
.social-link-list {
  width: 100%;
  justify-content: space-between;
}

h6 {
  text-align: justify;
}
.social-link-list {
  display: flex;
  flex-flow: row;
  align-items: center;
  margin-bottom: 10px;
}
.social-link-list i {
  color: FloralWhite;
}
.field {
  width: 100%;
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
  width: 90%;
}
.column.is-1 {
  width: 2%;
}
.button {
  width: 100%;
}
</style>

