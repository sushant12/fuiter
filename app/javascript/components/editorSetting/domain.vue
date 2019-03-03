<template>
  <section>
    <a @click="settingMenu" class="back">
      <i class="fa fa-arrow-circle-left"/>Go back
    </a>
    <!-- <p class="menu-label" @click="settingMenu">&larr; Back</p> -->
    <div class="field">
      <h1 class="subtitle">Domains</h1>
      <h6>A domain name is the web address where your website is hosted (For example, yourbusiness.com)</h6>
      <input class="input" type="text" v-model="domainName" placeholder="example.fuitter.com">
      <h6>Your website is published at the domain above</h6>
      <button class="button is-info" @click="updateSetting">Custom URL</button>
    </div>
  </section>
</template>

<script>
import EditorServices from "../../services/index.js";

export default {
  props: ["fb_page_id", "template"],
  data() {
    return {
      domainName: ""
    };
  },
  methods: {
    settingMenu() {
      this.$emit("clicked-setting-menu", "");
    },
    updateSetting() {
      EditorServices.updateSetting(this.fb_page_id, {
        domain: this.domainName,
        fb_page_template_id: this.template.id
      });
      this.clear();
    },
    clear() {
      this.domainName = "";
    }
  },
  created() {
    EditorServices.showSetting(this.template.id).then(res => {
      const settingData = res.data;
      this.domainName = settingData.domain;
    });
  }
};
</script>

<style scoped>
.field {
  color: #fff;
  margin: 20px 15px;
  width: 280px;
}
.subtitle {
  color: #fff;
  margin-bottom: 20px;
}
h6 {
  font-size: 13px;
  margin: 14px 0;
  text-align: justify;
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

