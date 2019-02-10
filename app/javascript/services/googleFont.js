const GOOGLE_FONT_API_KEY = "AIzaSyBpaxYy_j9wX4Qjb8dHLTr-zwbO-9X-sIs";
const GOOGLE_URL = `https://www.googleapis.com/webfonts/v1/webfonts?key=${GOOGLE_FONT_API_KEY}`
import RequestService from './requestService.js';

const FontServices = {
  getFonts() {
    return RequestService
      .get(GOOGLE_URL); 
  }
} 
export default FontServices;