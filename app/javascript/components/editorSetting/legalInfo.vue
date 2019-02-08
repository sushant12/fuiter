<template>
  <section>
    <p class="menu-label" @click="settingMenu">&larr; Back</p>
    <div class="field">        
      <h1 class="subtitle">Legal Information</h1>
      <h6>This is the legal name of your business. It will appear on all invoices and emails sent to your customers.</h6>
      <input class="input" type="text" v-model="legalInfo" placeholder="Add legal information">
      <button class="button is-info" @click="updateSetting">Save Info</button>
    </div> 
  </section>
</template>

<script>
import EditorServices from '../../services/index.js';

export default {
  props: ['fb_page_id', 'template'],
  data() {
    return {
      legalInfo: '',
    }
  },
  methods: {
    settingMenu() {
      this.$emit('clicked-setting-menu', ''); 
    },
    updateSetting() {
      EditorServices.updateSetting(this.fb_page_id, {
        legal_info: this.legalInfo,
        fb_page_template_id: this.template.id
      });
      this.clear();
    },
    clear() {
      this.legalInfo = '';
    }
  },
  created() {
    EditorServices.showSetting(this.template.id).then((response) => {
      const settingData = response.data;
      this.legalInfo = settingData.legal_info;
    })
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
.button {
  margin: 14px 0;
}
h6 {
  font-size: 13px;
  margin: 14px 0;
}
</style>

