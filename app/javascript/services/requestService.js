import axios from 'axios';

const RequestService = {
  get(resource){
    return axios  
      .get(`${resource}`)
      .catch(({ response }) => {
        throw new Error(response.data.errors);
      })
  }
}
export default RequestService;