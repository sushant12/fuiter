import axios from 'axios';
const csrfToken = document.getElementsByTagName('meta')['csrf-token'].getAttribute("content");
const BillingServices = {

  updateProperties(params, template_id, fb_page_id) {
    return axios.put(`/${fb_page_id}/templates/${template_id}/properties`, params, {headers: { 'X-CSRF-Token': csrfToken }});
  },

  fbSync(url){
    return axios.post(url,'', {headers: { 'X-CSRF-Token': csrfToken }});
  },

  updateMenu(fb_page_id, params) {
    return axios.put(`/editor/page/${fb_page_id}`, { "menu": params}, {headers: { 'X-CSRF-Token': csrfToken }});
  },

  getBillingHistory(fb_page_id) {
    return axios.get(`/billing/${fb_page_id}`,'',{headers: { 'X-CSRF-Token': csrfToken}});
  },

  updateSetting(fb_page_id, params) {
    return axios.post(`/editor/setting/${fb_page_id}`, params, {headers: { 'X-CSRF-Token': csrfToken }})
  },

  showSetting(fb_page_template_id) {
    return axios.get(`/editor/setting/${fb_page_template_id}`, {headers: { 'X-CSRF-Token': csrfToken }});
  },
  
  cancelSubscription(fb_page_id) {
    return axios.put(`/cancel_subscription/${fb_page_id}`,{}, {headers: { 'X-CSRF-Token': csrfToken}});
  },
  saveFbPageTemplate(id, params) {
    return axios.put(`/fb_page_template/${id}`,params, {headers: { 'X-CSRF-Token': csrfToken}});
  },

  getPage(page_id) {
    return axios.get(`/pages/${page_id}`,'',{headers: { 'X-CSRF-Token': csrfToken}});
  },
  getFbPageTemplate(id) {
    return axios.get(`/fb_page_template/${id}`,'',{headers: { 'X-CSRF-Token': csrfToken}});
  },

}

export default BillingServices;