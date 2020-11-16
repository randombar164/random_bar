export const handlingStore = {
    namespaced: true,
    state: {
        handlingStoreIds: [1, 3]
    },
    getters: {
    },
    mutations: {
        addHandlingStoreIds(state, payload) {
            state.handlingStoreIds.push(payload.handlingStoreId);
        },
        removeHandlingStoreIds(state, payload) {
            state.handlingStoreIds = state.handlingStoreIds.filter((v) => v !== payload.handlingStoreId);
        }
    },
    actions: {
        setHandlingStoreId({ state, commit }, id) {
            !state.handlingStoreIds.includes(id) ? commit('addHandlingStoreIds', { handlingStoreId: id })
                : commit('removeHandlingStoreIds', { handlingStoreId: id });
        }
    }
}
