import axios from 'axios';
import qs from "qs";

const regexp_url = /((h?)(ttps?:\/\/[a-zA-Z0-9.\-_@:/~?%&;=+#',()*!]+))/g; // ']))/;

export default class Cocktail{
    constructor(obj){
        this.init();
        console.log(obj);
        obj && this.getCocktail({
            filters: {
                base_ingredient_ids: [...obj.baseIngredientIds],
                handling_store_ids: [...obj.handlingStoreIds],
            }
        });
        console.log(this.ingredients);
    };
    init(){
        this.id = null;
        this.name = null;
        this.ingredients = null;
    };
    async getCocktail(params){
        const paramsSerializer = (params) => qs.stringify(params);
        await axios
        .get("/api/v1/concrete_drinks", {params: params, paramsSerializer})
        .then(res => {
            console.log(res);
            const baseDrink = res.data.concrete_drink.base_drink;
            const concreteIng = res.data.concrete_drink.concrete_ingredients;
            const concreteIngredients = baseDrink.base_drinks_base_ingredients.map((val, index)=>({
                id: val.id,
                baseIngredientId: val.base_ingredient_id,
                baseIngredientName: val.base_ingredient.name,
                additionalExp: val.additional_explanation || null,
                amount: val.unit.unit_conversion? String(Number(val.unit.unit_conversion.amount)*Number(val.amount)) : val.amount,
                unit: val.unit.unit_conversion? "ml" : val.unit.name,
                concreteIngredientId:concreteIng[index].id,
                name:concreteIng[index].name,
                amazonUrl: concreteIng[index].tag.match(regexp_url)[0],
                imageUrl: concreteIng[index].tag.match(regexp_url)[1]
            }));
            console.log(concreteIngredients);
            this.id = baseDrink.id;
            this.name = baseDrink.name;
            this.ingredients = [...concreteIngredients];
        })
        .catch(err => {
            console.error(err);
        })
    };
    
}