import Vue from 'vue'
import Vuex from 'vuex'
import createPersistedState from 'vuex-persistedstate';
import {registerIngredients} from './modules/registerIngredients';
import {handlingStore} from './modules/handlingStore'; 

Vue.use(Vuex)

export default new Vuex.Store({
    modules: {
        registerIngredients,
        handlingStore
    },
    plugins: [createPersistedState({
        key: 'gachaOptions',
        path: [
            'registerIngredients',
            'handlingStore'
        ]
    })],
})
