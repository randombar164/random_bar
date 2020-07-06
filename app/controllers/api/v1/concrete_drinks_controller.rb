class Api::V1::ConcreteDrinksController < Api::V1::BaseController

  def index
    base_drink_id = params_base_drink_id
    base_drink = BaseDrink.includes(:drink_method, :glass_type, { base_drinks_base_ingredients: [:base_ingredient, :unit] } ).find_by(id: base_drink_id)

    concrete_ingredients = []
    concrete_ingredients_to_parse = params[:concrete_ingredients]

    if base_drink.validate_params(concrete_ingredients_to_parse)
      concrete_ingredients_to_parse.values.each do |concrete_ingredient|
        concrete_ingredients.push(ConcreteIngredient.find(concrete_ingredient[:concrete_ingredient_id]))
      end
    else
      base_drink.base_ingredients.each do |base_ingredient|
        a = rand(base_ingredient.substitutions.count)
        if a == 0
          concrete_ingredients.push(base_ingredient.concrete_ingredients[rand(base_ingredient.concrete_ingredients.count)])
        else
          if base_ingredient.substitutions.ids.empty?
            concrete_ingredients.push(base_ingredient.concrete_ingredients[rand(base_ingredient.concrete_ingredients.count)])
          else
            concrete_ingredients.push(base_ingredient.substitutions.third.concrete_ingredients[rand(base_ingredient.concrete_ingredients.count)])
          end
        end
      end
    end

    concrete_drink = ConcreteDrink.new(base_drink: base_drink, concrete_ingredients: concrete_ingredients)
    render json: {concrete_drink: concrete_drink.to_json}


  end

  private
  def params_base_drink_id
    base_drinks_count = BaseDrink.count
    params[:base_drink_id] ||= rand(base_drinks_count) + 1
  end

end
