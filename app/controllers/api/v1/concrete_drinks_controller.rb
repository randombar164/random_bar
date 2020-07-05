class Api::V1::ConcreteDrinksController < Api::V1::BaseController
  def index
    params[:base_drink_id] ||= rand(BaseDrink.count)
    base_drink = BaseDrink.includes(:drink_method, :glass_type, { base_drinks_base_ingredients: [:base_ingredient, :unit] } ).find_by(id: params[:base_drink_id])

    if base_drink.nil?
      response_not_found('base_drink')
    else

      concrete_ingredients = []
      concrete_ingredients_to_parse = params[:concrete_ingredients]

      if base_drink.validate_params(concrete_ingredients_to_parse)
        concrete_ingredients_to_parse.values.each do |concrete_ingredient|
          concrete_ingredients.push(ConcreteIngredient.find(concrete_ingredient[:concrete_ingredient_id]))
        end
      else
        base_drink.base_ingredients.each do |base_ingredient|
          concrete_ingredients.push(base_ingredient.concrete_ingredients[rand(base_ingredient.concrete_ingredients.count)])
        end
      end

      concrete_drink = ConcreteDrink.new(base_drink: base_drink, concrete_ingredients: concrete_ingredients)
      render json: {concrete_drink: concrete_drink.to_json}
    end

  end

end
