import axios from 'axios';
const csrfToken = document.getElementsByTagName('meta')['csrf-token'].getAttribute("content");
const BillingServices = {

  getBillingHistory(fb_page_id) {
    return axios.get(`/fb_page/${fb_page_id}/billing`,'',{headers: { 'X-CSRF-Token': csrfToken}});
  },

  cancelSubscription(fb_page_id) {
    return axios.delete(`/fb_page/${fb_page_id}/subscription/cancel`, {headers: { 'X-CSRF-Token': csrfToken}})
  }

}

export default BillingServices;