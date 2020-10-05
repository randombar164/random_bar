import axios from 'axios';
import qs from 'qs';
import ING_RECOMMEND from '../../packs/Ingrecommended.json';

const regexp_url = /((h?)(ttps?:\/\/[a-zA-Z0-9.\-_@:/~?%&;=+#',()*!]+))/g; // ']))/;

const getImageTag = (ingredients) => {
  const index =  Math.floor( Math.random() * ingredients.length ) ;
  const amazonImage = ingredients[index].tag.match(regexp_url)[1];
  return amazonImage;
};

async function getUrl(id){
  let amazonImage;
  await axios
  .get(` /api/v1/base_ingredients/${id}`)
  .then(res => {
    const ingredients = res.data.base_ingredient.concrete_ingredients;
    amazonImage = getImageTag(ingredients);
  })
  .catch(err => {
    console.error(err);
  });
  return amazonImage;
};

export const drinkData = {
  namespaced: true,
  state: {
    cocktailRecipe: {
      "id": null,
      "name": null,
      "ingredients": null
    },
    drinkId: null,
    ingredientCardsInfo: null,
    baseIngredientsList: null,
    registeredIngList: [],
    baseIngredientIds: [],
    handlingStoreIds: []
    // cockNum: null
  },
  getters: {

  },
  mutations: {
    addCocktail(state, payload){
      state.cocktailRecipe.id = payload.id;
      state.cocktailRecipe.name = payload.name;
      state.cocktailRecipe.ingredients = payload.ingredients;
      console.log(state.cocktailRecipe);
    },
    addDrinkId(state, payload){
      state.drinkId = payload.id;
    },
    addIngredientCardsInfo(state, payload){
      state.ingredientCardsInfo = payload.ingredientCardsInfo;
    },
    addBaseIngredientList(state, payload){
      state.baseIngredientsList = payload.baseIngredientsList;
    },
    addRegisteredIngList(state, payload){
      state.registeredIngList.push(payload.registeredIng);
    },
    removeRegisteredIngList(state, payload){
      console.log(payload.id);
      state.registeredIngList = state.registeredIngList.filter((v) => v.id !== payload.id);
      console.log(state.registeredIngList);
    },
    addBaseIngredientIds(state, payload){
      state.baseIngredientIds.push(payload.id);
    },
    removeBaseIngredientIds(state, payload){
      state.baseIngredientIds = state.baseIngredientIds.filter((v) => v.id !== payload.id);
    },
    addHandlingStoreIds(state, payload){
      state.handlingStoreIds.push(...payload.handlingStoreId);
    },
    removeHandlingStoreIds(state, payload){
      state.handlingStoreIds = state.handlingStoreIds.filter((v) => v !== payload.handlingStoreId);
    }
    // addCockNum(state, payload){
    //   state.cockNum = payload.count;
    // },
  },
  actions: {
    async getDrink({ commit }, searchParams){
      const paramsSerializer = (params) => qs.stringify(params);
      let recipe = [];
      console.log(searchParams);
      await axios
      .get("/api/v1/concrete_drinks", {params: searchParams, paramsSerializer})
      .then(res => {
        const baseDrink = res.data.concrete_drink.base_drink;
        const concreteIng = res.data.concrete_drink.concrete_ingredients;
        baseDrink.base_drinks_base_ingredients.map((val, index)=>{
          recipe.push({
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
        });
        console.log(recipe);
        commit('addCocktail', {id: baseDrink.id, name: baseDrink.name, ingredients: recipe});
        commit('addDrinkId', {id: baseDrink.id});
      })
      .catch(err => {
        console.error(err);
      })
    },

    getIngredietCards({commit}){
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

    getBaseIngList({commit}){
      axios
      .get("/api/v1/base_ingredients")
      .then(res => {
        console.log(res);
        commit('addBaseIngredientList', { baseIngredientsList: res.data.base_ingredients});
      })
      .catch(err => {
        console.error(err);
      })
    },

    setRegisteredIng({commit},obj){
      console.log(obj.id);
      const registerdIng = {
        "id": obj.id,
        "name": obj.name,
        "imageUrl": getImageTag(obj.concrete_ingredients)
      }
      commit('addRegisteredIngList', { registeredIng: registerdIng } );
      commit('addBaseIngredientIds', { id: obj.id });
    },

    removeRegisteredIng({commit}, id){
      console.log("called");
      commit('removeRegisteredIngList', { id: id });
      commit('removeBaseIngredientIds', { id: id });
    },

    setHandlingStoreId({commit}, id){
      commit('addHandlingStoreIds', {handlingStoreId: [id]} );
    },

    deleteHandlingStoreId({commit}, id){
      commit('removeHandlingStoreIds', { handlingStoreId: id });
    },

    setRecipe({ state }){
      const recipe = {
        cocktailRecipe: state.cocktailRecipe,
        handlingStore: state.handlingStore
      }
      localStorage.setItem('recipe', JSON.stringify(recipe));
    },

    setCocktailRecipe({ state }){
      const storageItem = JSON.parse(localStorage.getItem('recipe'));
      if(storageItem){
        storageItem.cocktailRecipe = state.cocktailRecipe;
        console.log(storageItem);
        localStorage.setItem('recipe', JSON.stringify(storageItem));
      };
    },

    getRecipe({state, commit }){
      const recipe =  JSON.parse(localStorage.getItem('recipe'));
      const cocktailRecipe = recipe.cocktailRecipe;
      commit('addCocktail', { id: cocktailRecipe.id, name: cocktailRecipe.name, ingredients: cocktailRecipe.ingredients });
      commit('addHandlingStore', { handlingStore: recipe.handlingStore });
      console.log(recipe);
      commit('addDrinkId', { id: state.cocktailRecipe.id});
    },

    removeCocktailRecipe(){
      const storageItem = JSON.parse(localStorage.getItem('recipe'));
      if(storageItem){
        delete storageItem.cocktailRecipe;
        localStorage.setItem('recipe', JSON.stringify(storageItem));
      };
    },
    removeRecipe(){
      localStorage.removeItem('recipe');
    }
  }
}
