/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import "bulma/bulma";
import 'bulma-tooltip';

// import 'bulma-helpers/css/bulma-helpers.min.css';
import "../styles/application.css";
import "../styles/dashboard.scss";
import "../scripts/main.js";
import "vue-wysiwyg/dist/vueWysiwyg.css";
require.context('../images', true);
require.context('../fonts', true)
