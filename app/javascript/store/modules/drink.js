import axios from 'axios';
import qs from 'qs';
import ING_RECOMMEND from '../../packs/Ingrecommended.json';

const regexp_url = /((h?)(ttps?:\/\/[a-zA-Z0-9.\-_@:/~?%&;=+#',()*!]+))/g; // ']))/;

export const drinkData = {
  namespaced: true,
  state: {
    cocktailRecipe: null,
    drinkId: null,
    ingredientCardsInfo: null
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
    addIngredientCardsInfo(state, payload){
      state.ingredientCardsInfo = payload.ingredientCardsInfo;
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
      const paramsSerializer = (params) => qs.stringify(params);
      await axios
      .get("/api/v1/concrete_drinks", {params: searchParams, paramsSerializer})
      .then(res => {
        const baseDrink = res.data.concrete_drink.base_drink;
        const concreteIng = res.data.concrete_drink.concrete_ingredients;
        recipe.id = baseDrink.id;
        recipe.name = baseDrink.name;
        baseDrink.base_drinks_base_ingredients.map((val, index)=>{
          recipe.ingredients.push({
            "id": val.id,
            "baseIngredientId": val.base_ingredient_id,
            "baseIngredientName": val.base_ingredient.name,
            "additionalExp": val.additional_explanation || null,
            "amount": val.unit.unit_conversion? String(Number(val.unit.unit_conversion.amount)*Number(val.amount)) : val.amount,
            "unit": val.unit.unit_conversion? "ml" : val.unit.name,
            "concreteIngredientId":concreteIng[index].id,
            "name":concreteIng[index].name,
            "amazonUrl": concreteIng[index].tag.match(regexp_url)[0],
            "imageUrl": concreteIng[index].tag.match(regexp_url)[1]
          })
        })
        commit('addCocktail', {cocktailRecipe: recipe});
        commit('addDrinkId', {id: baseDrink.id});
      })
      .catch(err => {
        console.error(err);
      })
    },
    getIngredietCards({commit}){
      async function getUrl(id){
        let amazonImage;
          await axios
            .get(` /api/v1/base_ingredients/${id}`)
            .then(res => {
              const ingredients = res.data.base_ingredient.concrete_ingredients;
              const index =  Math.floor( Math.random() * ingredients.length ) ;
              amazonImage = ingredients[index].tag.match(regexp_url)[1];
            })
            .catch(err => {
              console.error(err);
            });
            return amazonImage;
      };
      let cardsInfo = [];
      ING_RECOMMEND.option.map( v => {
        let ingredients = [];
        v.ingredients.map( async(k) => {
          const amazonImage = await getUrl(k.id);
          ingredients.push({
            "id": k.id,
            "name": k.name,
            "amazonImage": amazonImage
          });
        });
        cardsInfo.push({
          "id": v.id,
          "category": v.category,
          "ingredients": ingredients
        });
      });
      commit('addIngredientCardsInfo', {ingredientCardsInfo: cardsInfo});
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
