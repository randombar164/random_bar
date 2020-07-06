class Api::V1::ConcreteDrinksController < Api::V1::BaseController

  def index
    base_drink_id = get_base_drink_id

    base_drink = BaseDrink.includes(:drink_method, :glass_type, { base_drinks_base_ingredients: [:base_ingredient, :unit] } ).find_by(id: base_drink_id)
    concrete_ingredients = get_concrete_ingredients(base_drink)

    concrete_drink = ConcreteDrink.new(base_drink: base_drink, concrete_ingredients: concrete_ingredients)
    render json: {concrete_drink: concrete_drink.to_json}
  end


  private

  def get_base_drink_id
    base_drinks_count = BaseDrink.count
    random_base_drink_id = rand(base_drinks_count) + 1
    return random_base_drink_id if params[:base_drink_id].to_i > base_drinks_count
    return params[:base_drink_id]
  end

  def get_concrete_ingredients(base_drink)
    return get_concrete_ingredients_from_params if base_drink.params_valid?(params[:concrete_ingredients])
    return get_random_concrete_ingredients(base_drink)
  end

  def get_concrete_ingredients_from_params
    concrete_ingredients = []
    concrete_ingredients_to_parse = params[:concrete_ingredients]

    concrete_ingredients_to_parse.values.each do |concrete_ingredient|
      concrete_ingredients.push(ConcreteIngredient.includes(:handling_stores).find(concrete_ingredient[:concrete_ingredient_id]))
    end
    return concrete_ingredients
  end

  def get_random_concrete_ingredients(base_drink)
    concrete_ingredients = []
    base_drink.base_ingredients.each do |base_ingredient|
      substitutions = base_ingredient.substitutions
      num = rand(substitutions.count)
      if num == 0
        concrete_ingredients.push(base_ingredient.find_random_concrete_ingredient)
      else
        if substitutions.ids.empty?
          concrete_ingredients.push(base_ingredient.find_random_concrete_ingredient)
        else
          # random性を出す
          concrete_ingredients.push(substitutions[num].concrete_ingredients[rand(base_ingredient.concrete_ingredients.count)])
        end
      end
    end
    return concrete_ingredients
  end

end
