import Vue from 'vue/dist/vue.esm';
// import Editor from '../views/editor';
import Preview from '../components/editorPreview';
import EditorNav from '../components/editorNav';
import EditorSidebar from '../components/editorSidebar';
import Setting from '../components/editorMenu/setting';
import wysiwyg from "vue-wysiwyg";
Vue.use(wysiwyg, {
  hideModules: {
    "image": true,
    "table": true,
    "removeFormat": true,
    "separator": true,
    "code": true,
  }
});
document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#editor',

    components: {
      Preview,
      EditorNav,
      EditorSidebar,
      Setting,
    }
  })
})
