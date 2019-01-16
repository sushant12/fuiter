import axios from 'axios';

const EditorServices = {
  updateProperties(params, template_id, fb_page_id) {
    axios.put(`/${fb_page_id}/templates/${template_id}/properties`, params)
    .then(function (response) {
      console.log(response);
    })
    .catch(function (error) {
      console.log(error);
    });
  }
  
}

export default EditorServices;