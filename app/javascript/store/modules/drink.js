import axios from 'axios';
import qs from 'qs';

export const drinkData = {
  namespaced: true,
  state: {
    cocktailRecipe: null,
    drinkId: null,
    // cockNum: null
  },
  getters: {

  },
  mutations: {
    addCocktail(state, payload){
      state.cocktailRecipe = payload.cocktailRecipe;
    },
    addDrinkId(state, payload){
      state.drinkId = payload.id;
    },
    // addCockNum(state, payload){
    //   state.cockNum = payload.count;
    // },
  },
  actions: {
    async getDrink({ commit }, searchParams){
      let recipe = {
        "id":null,
        "name":null,
        "ingredients":[]
      };
      const regexp_url = /((h?)(ttps?:\/\/[a-zA-Z0-9.\-_@:/~?%&;=+#',()*!]+))/g; // ']))/;
      let concreteIng = null;
      let baseDrink = null;
      const paramsSerializer = (params) => qs.stringify(params);
      await axios
      .get("/api/v1/concrete_drinks", {params: searchParams, paramsSerializer})
      .then(res => {
        baseDrink = res.data.concrete_drink.base_drink;
        concreteIng = res.data.concrete_drink.concrete_ingredients;
        recipe.id = baseDrink.id;
        recipe.name = baseDrink.name;
        baseDrink.base_drinks_base_ingredients.map((val, index)=>{
          recipe.ingredients.push({
            "id":val.id,
            "baseIngredientId":val.base_ingredient_id,
            "amount":val.amount,
            "unit":val.unit.name,
            "concreteIngredientId":concreteIng[index].id,
            "name":concreteIng[index].name,
            "amazonUrl":concreteIng[index].tag.match(regexp_url)[0],
            "imageUrl":concreteIng[index].tag.match(regexp_url)[1]
          })
        })
        commit('addCocktail', {cocktailRecipe: recipe});
        commit('addDrinkId', {id: baseDrink.id});
      })
      .catch(err => {
        console.error(err);
      })
    },
    // countCocktail({ commit }, base_drink_id){
    //   let count;
    //   axios.get(` /api/v1/base_ingredients/${base_drink_id}/base_drinks_count`)
    //   .then(res => {
    //     count = res.data.base_drinks_count;
    //     console.log(res);
    //   })
    //   .catch(err => {
    //     console.error(err);
    //   })
    //   commit('addCockNum', {count: count});
    //   },
    // foundId({ commit, state }){
    //   commit('addDrinkId', state.cocktailRecipe.id);
    // },
    setRecipe({ state }){
      localStorage.setItem('cocktailRecipe', JSON.stringify(state.cocktailRecipe));
    },
    getRecipe({state, commit }){
      commit('addCocktail', {cocktailRecipe: JSON.parse(localStorage.getItem('cocktailRecipe'))});
      commit('addDrinkId', { id: state.cocktailRecipe.id});
    },
    removeRecipe(){
      localStorage.removeItem('cocktailRecipe');
    },
  }
}
