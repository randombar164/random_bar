class ConcreteDrink
  include ActiveModel::Model

  def initialize(params)
    if params[:base_drink_id].present?
      @base_drink = BaseDrink.with_recipe.find(params[:base_drink_id])
      return if @base_drink.nil?
      @concrete_ingredients = @base_drink.get_concrete_ingredients_from_params(params[:concrete_ingredients])
    else
      if params[:filters].nil?
        @base_drink = BaseDrink.with_recipe.random
        @concrete_ingredients = @base_drink.get_random_concrete_ingredients()
      else
        # とりあえずOR
        cookable_base_drink_ids = params[:filters][:base_ingredient_ids].present? ? \
                              BaseDrinksBaseIngredient.get_base_drink_ids_from_base_ingredient_ids(params[:filters]) : \
                              Array(1..BaseDrink.last.id)
        return if cookable_base_drink_ids.empty?

        cookable_base_drink_ids.shuffle!
        @concrete_ingredients = []
        cookable_base_drink_ids.each do |bd_id|
          @base_drink = BaseDrink.with_recipe.find(bd_id)
          @base_drink.base_drinks_base_ingredients.each do |bd_bi|
            base_ingredient = bd_bi.base_ingredient
            concrete_ingredient = base_ingredient.choose_concrete_ingredient(params[:filters])
            @concrete_ingredients.clear and break if concrete_ingredient.nil?
            @concrete_ingredients << concrete_ingredient
          end
          break if @concrete_ingredients.any?
        end
      end
    end
  end

  def nil?
    if @base_drink.nil? || @concrete_ingredients.empty?
      return true
    else
      return false
    end
  end

  def to_json
    concrete_drink_json = {
      base_drink: JSON.parse(@base_drink.to_json(include: [:drink_method, :glass_type, :base_ingredients, base_drinks_base_ingredients: {include: [:base_ingredient, unit:{include: [:unit_conversion] }]}])),
      concrete_ingredients: JSON.parse(@concrete_ingredients.to_json(include: [:handling_stores, :base_ingredient]))
    }
  end
end
