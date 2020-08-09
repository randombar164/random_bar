import axios from 'axios';

export const drinkData = {
  namespaced: true,
  state: {
    cocktailRecipe: {},
    drinkId: null,
    ingredientId: null,
    cockNum: null
  },
  getters: {

  },
  mutations: {
    addCocktail(state, cocktailRecipe){
      state.cocktailRecipe = cocktailRecipe;
    },
    addDrinkId(state, id){
      state.drinkId = id;
    },
    addIngredientId(state, id){
      state.ingredientId = id;
    },
    addCockNum(state, count){
      state.cockNum = count;
    },
  },
  actions: {
    getDrink({ commit }, params){
      let recipe = {
        "id":null,
        "name":null,
        "ingredients":[]
      };
      let concreteIng = null;
      let baseDrink = null;
      axios
        .get("/api/v1/concrete_drinks", params)
        .then(res => {
          console.log(res);
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
              "url":"#",
            })
          })
          console.log(recipe);
        })
        .catch(err => {
          console.error(err);
        })
        commit('addCocktail', recipe);
    },
    countCocktail({ commit }, base_drink_id){
      let count;
      axios.get(` /api/v1/base_ingredients/${base_drink_id}/base_drinks_count`)
           .then(res => {
             count = res.data.base_drinks_count;
           })
           .catch(err => {
             console.error(err);
           })
           commit('addCockNum', count);
    },
    foundId({ commit, state }){
      commit('addDrinkId', state.cocktailRecipe.id);
    },
    setRecipe(state){
      if(!localStorage.getItem('cocktailRecipe')){
        localStorage.setItem('cocktailRecipe', JSON.stringify(state.cocktailRecipe));
      }
    },
    getRecipe(){
      const cocktailRecipe = localStorage.getItem('cocktailRecipe');
      commit('addCocktail', cocktailRecipe);
    },
    removeRecipe(){
      if(localStorage.getItem('cocktailRecipe')){
        localStorage.removeItem('cocktailRecipe');
      }
  }
}
}
