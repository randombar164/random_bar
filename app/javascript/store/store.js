import Vue from 'vue'
import Vuex from 'vuex'

import {drinkData} from './modules/drink';

Vue.use(Vuex)

export default new Vuex.Store({
    modules: {
        drinkData: drinkData
    }
})
