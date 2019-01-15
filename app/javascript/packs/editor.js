// The above code uses Vue without the compiler, which means you cannot
// use Vue to target elements in your existing html templates. You would
// need to always use single file components.
// To be able to target elements in your existing html/erb templates,
// comment out the above code and uncomment the below
// Add <%= javascript_pack_tag 'hello_vue' %> to your layout
// Then add this markup to your html template:
//
// <div id='hello'>
//   {{message}}
//   <app></app>
// </div>


import Vue from 'vue/dist/vue.esm'
import Editor from '../views/editor'
import Preview from '../components/iframe'
import EditorHeader from '../components/editorHeader'
document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#editor',

    components: {
      Preview,
      Editor,
      EditorHeader,
    }
  })
})
