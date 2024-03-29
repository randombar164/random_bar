/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

import Vue from 'vue';
import Vuex from 'vuex';
import VueRouter from 'vue-router';
import VueAnalytics from 'vue-analytics';
import vuetify from '../plugins/vuetify';
// import store from 'store';
import router from '../routes';
import App from '../app';
import store from '../store/store';


// import '../assets/css/application';

Vue.use(Vuex);
Vue.use(VueRouter);
Vue.use(VueAnalytics, {
  id: 'UA-176415991-1',
  router
});

document.addEventListener('DOMContentLoaded', () => {
  new Vue({
    el: '#application',
    store,
    vuetify,
    router,
    render: (h) => h(App),
  });
});
