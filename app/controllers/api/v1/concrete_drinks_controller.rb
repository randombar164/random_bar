class Api::V1::ConcreteDrinksController < Api::V1::BaseController
  def show
    base_drink = BaseDrink.includes(:drink_method, :glass_type, { base_drinks_base_ingredients: [:base_ingredient, :unit] } ).find(params[:base_drink_id])
    concrete_ingredient_ids = []
    base_drink.base_ingredients.each do |base_ingredient|
      concrete_ingredient_ids.push(base_ingredient.concrete_ingredients.first.id)
    end
    concrete_ingredients = ConcreteIngredient.includes(:handling_stores).find(concrete_ingredient_ids)
    concrete_drink = ConcreteDrink.new(base_drink: base_drink, concrete_ingredients: concrete_ingredients)
    render json: {concrete_drink: concrete_drink.to_json}
  end
end
