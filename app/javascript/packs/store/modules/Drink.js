import axios from 'axios';
import qs from 'qs';

// 参照渡ししてないのが問題？
const getData = function(context, obj,  params) {
  const paramsSerializer = (params) => qs.stringify(params);
  console.log(params);
  axios.get(obj.url, { params, paramsSerializer})
  .then(res => {
    context.commit(obj.mutation, res['data']['concrete_drink'][obj.locate]);
  }).catch( error =>{
    console.error(error);
  });
};

const randomNum = function(){
  return Math.floor(Math.random()*60000);
};

const state = {
  baseDrink: null,
  concreteIngredients: {}
};

const mutations = {
  setBaseDrink(state, baseDrink){
    state.baseDrink = baseDrink;
  },
  setConcreteIngredients(state, concreteIngredients){
    state.concreteIngredients = concreteIngredients;
  },
};

const getters = {
  getDrink(state){
    return state.baseDrink;
  },
  getIngredients(state){
    return state.concreteIngredients;
  },
};

const actions = {
  async getBaseDrink ( context ) {
  //   const num = randomNum();
  //   await axios.get(`/api/v1/concrete_drinks?base_drink_id=${12}`)
  //   .then(res => {
  //     context.commit("setBaseDrink", res.base_drink);
  //     console.log(res);
  //   }).catch( error =>{
  //     console.error(error);
  //   });
    await getData(context,
      {
        mutation: 'setBaseDrink',
        locate: 'base_drink',
        url: `/api/v1/concrete_drinks`,
      },
      {
        base_drink_id: 164,
      }
    );
  },
  async getConcreteIngredients (context) {
    await getData (context,
      {
        mutation: 'setConcreteIngredients',
        locate: 'concrete_ingredients',
        url: `/api/v1/concrete_ingredient`
      },
      {
        base_drink_id: 164,
      }
    );
  }
};

export default {
  namespaced: true,
  state,
  mutations,
  getters,
  actions
};
