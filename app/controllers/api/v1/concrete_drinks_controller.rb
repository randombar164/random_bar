class Api::V1::ConcreteDrinksController < Api::V1::BaseController
  def index
    base_drink = BaseDrink.includes(:drink_method, :glass_type, { base_drinks_base_ingredients: [:base_ingredient, :unit] } ).find_by(id: params[:base_drink_id])

    if base_drink.nil?
      response_not_found('base_drink')

    else
      if params[:concrete_ingredients].present?

      else
        concrete_ingredients = []
        base_drink.base_ingredients.each do |base_ingredient|
          concrete_ingredients.push(base_ingredient.concrete_ingredients[rand(base_ingredient.concrete_ingredients.count)])
        end
      end
      concrete_drink = ConcreteDrink.new(base_drink: base_drink, concrete_ingredients: concrete_ingredients)
      render json: {concrete_drink: concrete_drink.to_json}
    end
    # if params[:concrete_ingredients].present?
    #   for params[:concrete_ingredients].each do |concrete_ingredient|
    #     if params_valid?
    #     end
    #   end
    # else

  end

  def params_concrete_ingredients_valid?(concrete_ingredients)

  end
end
