import Vue from 'vue/dist/vue.esm';
// import Editor from '../views/editor';
import Preview from '../components/editorPreview';
import EditorNav from '../components/editorNav';
import EditorSidebar from '../components/editorSidebar';
document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#editor',

    components: {
      Preview,
      // Editor,
      EditorNav,
      EditorSidebar,
    }
  })
})
