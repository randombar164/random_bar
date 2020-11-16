// src/plugins/vuetify.js

import Vue from 'vue'
import Vuetify from 'vuetify'
import 'vuetify/dist/vuetify.min.css'
// import '@mdi/font/css/materialdesignicons.css'

Vue.use(Vuetify)

export default new Vuetify({
  theme: {
    themes: {
      light: {
        primary: "#FF6749",
        secondary: "#FCFAF1",
        accent: "#8c9eff",
        error: "#b71c1c",
      },
    },
  },
});
