import Vue from 'vue/dist/vue.esm';
import Billing from '../components/billing';

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#billing',
    components: {
      Billing,
    }
  })
})
