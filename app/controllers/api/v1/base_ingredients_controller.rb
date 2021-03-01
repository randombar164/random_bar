class Api::V1::BaseIngredientsController < Api::V1::BaseController

  def index
    ids = Array(params[:ids]&.values&.map(&:to_i))
    if ids.empty?
      base_ingredients = BaseIngredient.includes(:concrete_ingredients, :substitutions).all
    else
      base_ingredients = BaseIngredient.includes(:concrete_ingredients, :substitutions).find(ids)
    end
    render json: {base_ingredients: base_ingredients}, include: [:concrete_ingredients, :substitutions]
  end

  def show
    base_ingredient = BaseIngredient.includes(:concrete_ingredients, :substitutions).find(params[:id])
    render json: {base_ingredient: base_ingredient}, include: [:concrete_ingredients, :substitutions]
  end

  def base_drinks_count
    base_ingredient = BaseIngredient.find(params[:id])
    base_drinks_count = base_ingredient.base_drinks.count
    render json: {base_ingredient_id: base_ingredient.id, base_drinks_count: base_drinks_count}
  end

end
