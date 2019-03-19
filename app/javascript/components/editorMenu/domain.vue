<template>
  <section>
    <a @click="mainMenu" class="back">
      <i class="fa fa-arrow-circle-left"/>Go back
    </a>    
    <div class="field">
      <h1 class="subtitle">Add Domain</h1>      
      <input class="input" type="text" v-model="domain" placeholder="example.fuitter.com">
      <h6>Your website is published at the domain above</h6>
      <h1 class="subtitle">Add Subdomain</h1>      
      <input class="input" type="text" v-model="subDomain" placeholder="app">
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
      domain: "",
      subDomain: ""
    };
  },
  methods: {
    mainMenu() {
      this.$emit("clicked-main-menu", "");
    },
    updateSetting() {
      EditorServices.updateSetting(this.fb_page_id, {
        subdomain: this.subDomain,
        fb_page_template_id: this.template.id
      });
      this.clear();
    },
    clear() {
      this.domain = "";
      this.subDomain = "";
    }
  },
  created() {
    EditorServices.showSetting(this.template.id).then(res => {
      const settingData = res.data;
      this.subDomain = settingData.subdomain;
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

