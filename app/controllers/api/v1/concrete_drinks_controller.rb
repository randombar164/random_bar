class Api::V1::ConcreteDrinksController < Api::V1::BaseController

  def index
    base_drink = BaseDrink.find_by_params(params)
    response_not_found("base_drink") and return if base_drink.nil?
    concrete_ingredients = base_drink.concrete_ingredients(params)

    concrete_drink = ConcreteDrink.new(base_drink: base_drink, concrete_ingredients: concrete_ingredients)
    render json: {concrete_drink: concrete_drink.to_json}
  end

end
