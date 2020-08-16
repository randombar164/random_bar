class Api::V1::BaseIngredientsController < Api::V1::BaseController

  def base_drinks_count
    base_ingredient = BaseIngredient.find(params[:id])
    base_drinks_count = base_ingredient.base_drinks.count
    render json: {base_ingredient_id: base_ingredient.id, base_drinks_count: base_drinks_count}
  end

end
