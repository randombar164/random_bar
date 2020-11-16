import axios from 'axios';

export const registerIngredients = {
    namespaced: true,
    state: {
        baseIngredientsList: null,
        registeredIngredientList: [],
        baseIngredientIds: [],
    },
    getters: {

    },
    mutations: {
        addBaseIngredientList(state, payload){
        state.baseIngredientsList = payload.baseIngredientsList;
        },
        addRegisteredIngredientList(state, payload){
        state.registeredIngredientList.push(payload.registeredIng);
        },
        removeRegisteredIngredientList(state, payload){
        state.registeredIngredientList = state.registeredIngredientList.filter((v) => v.id != payload.id);
        },
        addBaseIngredientIds(state, payload){
        state.baseIngredientIds.push(payload.id);
        },
        removeBaseIngredientIds(state, payload){
        state.baseIngredientIds = state.baseIngredientIds.filter((v) => v != payload.id);
        }
    },
    actions: {
        getBaseIngredientsList({commit}){
        axios
        .get("/api/v1/base_ingredients")
        .then(res => {
            commit('addBaseIngredientList', { baseIngredientsList: res.data.base_ingredients});
        })
        .catch(err => {
            console.error(err);
        })
        },

        setIngredient({state, commit},obj){
        if(state.baseIngredientIds.includes(obj.id)){ return };
        const registeredIng = {
            "id": obj.id,
            "name": obj.name,
            "concrete_ingredients": obj.concrete_ingredients 
        }
        commit('addRegisteredIngredientList', { registeredIng: registeredIng } );
        commit('addBaseIngredientIds', { id: obj.id });
        },

        removeRegisteredIngredient({commit}, id){
        commit('removeRegisteredIngredientList', { id: id });
        commit('removeBaseIngredientIds', { id: id });
        }
    }
}
