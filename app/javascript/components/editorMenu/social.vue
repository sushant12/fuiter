<template>
  <section>
    <a @click="mainMenu" class="back">
      <i class="fa fa-arrow-circle-left"/>Go back
    </a>
    <div class="field">
      <h1 class="subtitle">Social</h1>
      <h6 class="general-messages">Connect Social Media to your Website for better engagement</h6>
      <h6>Add social sites URL</h6>
      <div class="control">
        <div class="social-link-list">
          <i class="fab fa-instagram" />
          <input type="url" placeholder="Instagram URL" class="input sidebar-inputs" v-model="instagram">
        </div>
        <div class="social-link-list">
          <i class="fab fa-youtube" />
          <input type="url" placeholder="Youtube URL" class="input sidebar-inputs" v-model="youtube">
        </div>
        <div class="social-link-list">
          <i class="fab fa-twitter" />
          <input type="url" placeholder="Twitter URL" class="input sidebar-inputs" v-model="twitter">
        </div>
        <div class="social-link-list">
          <i class="fab fa-facebook" />
          <input type="url" placeholder="Facebook URL" class="input sidebar-inputs" v-model="facebook">
        </div>
        <div class="social-link-list">
          <i class="fab fa-linkedin" />
          <input type="url" placeholder="LinkedIn URL" class="input sidebar-inputs" v-model="linkedin">
        </div>
        <div class="social-link-list">
          <i class="fab fa-pinterest" />
          <input type="url" placeholder="Pinterest URL" class="input sidebar-inputs" v-model="pinterest">
        </div>
        <div class="social-link-list">
          <i class="fab fa-yelp" />
          <input type="url" placeholder="Yelp URL" class="input sidebar-inputs" v-model="yelp">
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
      facebook: '',
      twitter: '',
      instagram: '',
      youtube: '',
      linkedin: '',
      yelp: '',
      pinterest: '',
    };
  },
  methods: {
    mainMenu() {
      this.$emit("clicked-main-menu", "");
    },
    updateSetting() {
      EditorServices.updateSetting(this.fb_page_id, {
        social_media: {
          facebook: this.facebook,
          twitter: this.twitter,
          instagram: this.instagram,
          youtube: this.youtube,
          linkedin: this.linkedin,
          yelp: this.yelp,
          pinterest: this.pinterest,
        },
        fb_page_template_id: this.template.id
      })
      .then(resp => {
        document.getElementById("frame").contentWindow.location.reload();
      });
    },
  },
  created() {
    const that = this;
    EditorServices.showSetting(this.template.id)
    .then(({data}) => {
      const socialMedia = data.social_media;
      if (!_.isNil(socialMedia)) {
        that.facebook = socialMedia['facebook'];
        that.twitter = socialMedia['twitter'];
        that.instagram =  socialMedia['instagram'];
        that.youtube = socialMedia['youtube'];
        that.linkedin = socialMedia['linkedin'];
        that.yelp = socialMedia['yelp'];
        that.pinterest = socialMedia['pinterest'];
      }
    });
  }
};
</script>

<style scoped>
.field .subtitle{
  margin-bottom: 5px;
}
.field .general-messages{
  margin-top: 0;
}
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
  margin-bottom: 100px;
}
</style>
<style type="text/css">
  .child-menu{
    /* overflow-y: scroll; */
    overflow-x:hidden;
  }
</style>
