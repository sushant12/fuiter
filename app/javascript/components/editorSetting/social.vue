<template>
  <section>
    <p class="menu-label" @click="settingMenu">&larr; Back</p>
    <div class="field">      
      <h1 class="subtitle">Social</h1>
      <h6>Connecting to social services enables you to push or pull data, and allow visitors to connect with you via those services.</h6>
      <h6>Add social sites URL</h6>
      <div class="control" v-for="(option, index) in social" :key="index">
        <input class="input" type="text" v-model="option.name" :placeholder="option.placeholder">
      </div>
      <button class="button is-info" @click="updateSetting">Save</button>      
    </div>
  </section>
</template>

<script>
import EditorServices from '../../services/index.js';
export default { 
  props: ['fb_page_id', 'template'],
  data() {
    return {
      social: [
        { name: '', placeholder: 'Facebook URL' },
        { name: '', placeholder: 'LinkedIn URL' },
        { name: '', placeholder: 'Twitter URL' },
        { name: '', placeholder: 'Youtube URL' },
      ],
    }
  },
  methods: {
    settingMenu() {
      this.$emit('clicked-setting-menu', ''); 
    },
    updateSetting() {
      this.social.forEach((item, index) => {
        delete item.placeholder
      });
      EditorServices.updateSetting(this.fb_page_id, {
        socail_media: { social: this.social },
        fb_page_template_id: this.template.id       
      }).then((resp) => {
        document.getElementById('frame').contentWindow.location.reload();
      });
      this.clear();
    },
    clear() {
      this.social = [
        { name: '', placeholder: 'Facebook URL' },
        { name: '', placeholder: 'LinkedIn URL' },
        { name: '', placeholder: 'Twitter URL' },
        { name: '', placeholder: 'Youtube URL' },
      ]
    }
  },
  created() {
    EditorServices.showSetting(this.template.id)
      .then((res) => {
        const settingData = res.data;
        this.social = settingData.socail_media.social;
      });
  },
}
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
</style>

