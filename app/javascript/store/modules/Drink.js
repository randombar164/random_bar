import axios from 'axios';


export function getDrink({ params }){
  let cocktailRecipe = {
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
      cocktailRecipe.id = baseDrink.id;
      cocktailRecipe.name = baseDrink.name;
      baseDrink.base_drinks_base_ingredients.map((val, index)=>{
        cocktailRecipe.ingredients.push({
          "id":val.id,
          "baseIngredientId":val.base_ingredient_id,
          "amount":val.amount,
          "unit":val.unit.name,
          "concreteIngredientId":concreteIng[index].id,
          "ingredient":concreteIng[index].name,
          "url":"#",
        })
      })
      console.log(cocktailRecipe)
    })
    .catch(err => {
      console.error(err);
    })
    return cocktailRecipe;
}

export function setRecipe(cocktailRecipe){
  if(!localStorage.getItem('cocktailRecipe')){
    localStorage.setItem('cocktailRecipe', JSON.stringify(cocktailRecipe));
  }
}

export function getRecipe(){
  const cocktailRecipe = localStorage.getItem('cocktailRecipe');
  return JSON.parse(cocktailRecipe);
}

export function removeRecipe(){
  if(localStorage.getItem('cocktailRecipe')){
    localStorage.removeItem('cocktailRecipe');
  }
}
