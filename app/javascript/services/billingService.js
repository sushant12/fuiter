import axios from 'axios';
const csrfToken = document.getElementsByTagName('meta')['csrf-token'].getAttribute("content");
const BillingServices = {

  getBillingHistory(fb_page_id) {
    return axios.get(`/billing/${fb_page_id}`,'',{headers: { 'X-CSRF-Token': csrfToken}});
  },

}

export default BillingServices;