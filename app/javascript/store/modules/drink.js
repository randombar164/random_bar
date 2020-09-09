import axios from 'axios';
import qs from 'qs';

export const drinkData = {
  namespaced: true,
  state: {
    cocktailRecipe: null,
    drinkId: null,
    amazonUrl: null,
    amazonImage: null
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
    addAmazonUrl(state, payload){
      state.amazonUrl = payload.amazonUrl;
    },
    addAmazonImage(state, payload){
      state.amazonImage = payload.amazonImage;
    }
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
      const paramsSerializer = (params) => qs.stringify(params);
      console.log(paramsSerializer(searchParams));
      await axios
      .get("/api/v1/concrete_drinks", {params: searchParams, paramsSerializer})
      .then(res => {
        console.log(res);
        const baseDrink = res.data.concrete_drink.base_drink;
        recipe.id = baseDrink.id;
        recipe.name = baseDrink.name;
        baseDrink.base_drinks_base_ingredients.map((val, index)=>{
          const concreteIng = res.data.concrete_drink.concrete_ingredients.filter(v => v.base_ingredient_id == val.base_ingredient.id)[0];
          console.log(concreteIng);
          recipe.ingredients.push({
            "id": val.id,
            "baseIngredientId": val.base_ingredient_id,
            "baseIngredientName": val.base_ingredient.name,
            "additionalExp": val.additional_explanation || null,
            "amount": val.unit.unit_conversion? String(Number(val.unit.unit_conversion.amount)*Number(val.amount)) : val.amount,
            "concreteIngredientId": concreteIng.id,
            "name": concreteIng.name,
            "amazonUrl": concreteIng.tag.match(regexp_url)[0],
            "imageUrl": concreteIng.tag.match(regexp_url)[1]
          })
        })
        commit('addCocktail', {cocktailRecipe: recipe});
        commit('addDrinkId', {id: baseDrink.id});
      })
      .catch(err => {
        console.error(err);
      })
    },
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
