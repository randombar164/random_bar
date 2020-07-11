class Api::V1::ConcreteDrinksController < Api::V1::BaseController

  def index
    base_drink_id = get_base_drink_id
    base_drink = BaseDrink.includes(:drink_method, :glass_type, { base_drinks_base_ingredients: [:base_ingredient, :unit] } ).find_by(id: base_drink_id)
    concrete_ingredients = params_valid?(base_drink) ? \
      base_drink.get_concrete_ingredients_from_params(params[:concrete_ingredients]) : base_drink.get_random_concrete_ingredients

    concrete_drink = ConcreteDrink.new(base_drink: base_drink, concrete_ingredients: concrete_ingredients)
    render json: {concrete_drink: concrete_drink.to_json}
  end


  private

  def get_base_drink_id
    check_params_base_drink_id
    params[:base_drink_id] ||= rand(BaseDrink.count) + 1
  end

  def check_params_base_drink_id
    if params[:base_drink_id].blank? || params[:base_drink_id]&.to_i > BaseDrink.count
      params.delete(:concrete_ingredients)
      params.delete(:base_drink_id)
    end
  end

  def params_valid?(base_drink)
    return false unless params[:concrete_ingredients].present?
    return false unless check_params_base_ingredient_ids_with_concrete_ingredient_ids
    return false if !check_params_base_ingredient_ids(base_drink) && !check_substitutions(base_drink)
    return true
  end

  def check_params_base_ingredient_ids_with_concrete_ingredient_ids
    params[:concrete_ingredients].values.each do |concrete_ingredient|
      return false if concrete_ingredient[:base_ingredient_id].nil? || concrete_ingredient[:concrete_ingredient_id].nil?
      return false if concrete_ingredient[:base_ingredient_id].to_i != ConcreteIngredient.find(concrete_ingredient[:concrete_ingredient_id]).base_ingredient_id
    end
    return true
  end

  def check_params_base_ingredient_ids base_drink
    params_base_ingredient_ids, params_concrete_ingredient_ids = get_ingredient_ids_from_params
    base_drink.base_ingredients.each_with_index do |base_ingredient, idx|
      return false unless base_ingredient.id == params_base_ingredient_ids[idx]
    end
    return true
  end

  def check_substitutions base_drink
    params_base_ingredient_ids, params_concrete_ingredient_ids = get_ingredient_ids_from_params
    flag = true
    base_drink.base_ingredients.each_with_index do |base_ingredient,idx|
      if base_ingredient.id != params_base_ingredient_ids[idx]
        # do not return here! throw a segmentation fault.
        flag = false if !base_ingredient.substitutions.ids.include? params_base_ingredient_ids[idx]
      end
    end
    return flag
  end

  def get_ingredient_ids_from_params
    base_ingredient_ids = []
    concrete_ingredient_ids = []
    params[:concrete_ingredients].values.each do |concrete_ingredient|
      base_ingredient_ids << concrete_ingredient[:base_ingredient_id].to_i
      concrete_ingredient_ids << concrete_ingredient[:concrete_ingredient_id].to_i
    end
    return base_ingredient_ids, concrete_ingredient_ids
  end

end
