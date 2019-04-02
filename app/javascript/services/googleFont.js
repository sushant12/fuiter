import RequestService from './requestService.js';

const GOOGLE_FONT_API_KEY = "AIzaSyBpaxYy_j9wX4Qjb8dHLTr-zwbO-9X-sIs";
const GOOGLE_FONT_URL = `https://www.googleapis.com/webfonts/v1/webfonts?sort=popularity&key=${GOOGLE_FONT_API_KEY}`

const FontServices = {
  getFonts() {
    return RequestService
      .get(GOOGLE_FONT_URL); 
  }
} 
export default FontServices;