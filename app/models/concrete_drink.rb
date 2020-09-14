class ConcreteDrink
  include ActiveModel::Model

  def initialize(params)
    if params[:base_drink_id].present?
      @base_drink = BaseDrink.with_recipe.find(params[:base_drink_id])
      return if @base_drink.nil?
      @concrete_ingredients = @base_drink.get_concrete_ingredients_from_params(params[:concrete_ingredients])
    else
      @base_drink = BaseDrink.get_random(params[:filters])
      return if @base_drink.nil?
      @concrete_ingredients = @base_drink.get_random_concrete_ingredients(params[:filters])
    end
  end

  def nil?
    if @base_drink.nil?
      return true
    else
      return false
    end
  end

  def to_json
    concrete_drink_json = {
      base_drink: JSON.parse(@base_drink.to_json(include: [:drink_method, :glass_type, :base_ingredients, base_drinks_base_ingredients: {include: [:base_ingredient, unit:{include: [:unit_conversion] }]}])),
      concrete_ingredients: JSON.parse(@concrete_ingredients.to_json(include: [:handling_stores]))
    }
  end
end
