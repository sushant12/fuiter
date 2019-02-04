import axios from 'axios';

const EditorServices = {
  updateProperties(params, template_id, fb_page_id) {
    axios.put(`/${fb_page_id}/templates/${template_id}/properties`, params, {headers: { 'X-CSRF-Token': document.getElementsByTagName('meta')['csrf-token'].getAttribute("content") }})
    .then(function (response) {
      console.log(response);
    })
    .catch(function (error) {
      console.log(error);
    });
  },

  fbSync(url){
    axios.post(url,'', {headers: { 'X-CSRF-Token': document.getElementsByTagName('meta')['csrf-token'].getAttribute("content") }})
      .then((response) => {
        document.getElementById('frame').contentWindow.location.reload();
      })
      .catch((error) => {
        console.log(error);
      })
  },

  updateMenu(fb_page_id, params) {
    axios.put(`/editor/page/${fb_page_id}`, { "menu": params}, {headers: { 'X-CSRF-Token': document.getElementsByTagName('meta')['csrf-token'].getAttribute("content") }})
    .then(function (response) {
      console.log(response);
    })
    .catch(function (error) {
      console.log(error);
    });
  }
}

export default EditorServices;