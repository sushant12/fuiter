import axios from 'axios';

const EditorServices = {
  updateProperties(params) {
    axios.put(`/${params.fb_page_id}/templates/${params.template_id}/properties`, 
    { 
      template: {
        properties: { 
          font: params.font,
          color: params.color,
          logo: params.logo,
          title: params.title
        } 
      }
    })
    .then(function (response) {
      console.log(response);
    })
    .catch(function (error) {
      console.log(error);
    });
  }
  
}

export default EditorServices;