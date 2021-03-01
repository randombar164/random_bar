class Api::V1::EventsController < Api::V1::BaseController

  def show
    event = Event.includes(:base_ingredients).find_by(uuid: params[:uuid])
    render json: { event: event }, include: [:base_ingredients, cookable_base_drinks: {include: [:drink_method, :glass_type, :base_ingredients, base_drinks_base_ingredients: {include: [:base_ingredient, unit:{include: [:unit_conversion] }]}]}]
  end

  def create
    event = Event.new(event_params)
    if params[:base_ingredient_ids]
      base_ingredients = BaseIngredient.where(id: params[:base_ingredient_ids])
      event.base_ingredients = base_ingredients
    end
    event.save!
    render json: {event: event}, include: [:base_ingredients, cookable_base_drinks: {include: [:drink_method, :glass_type, :base_ingredients, base_drinks_base_ingredients: {include: [:base_ingredient, unit:{include: [:unit_conversion] }]}]}]
  end

  def update 
    event = Event.find_by(uuid: params[:uuid])
    base_ingredients = BaseIngredient.where(id: params[:base_ingredient_ids])
    event.base_ingredients = base_ingredients
    event.save!
    render json: {event: event}, include: [:base_ingredients, cookable_base_drinks: {include: [:drink_method, :glass_type, :base_ingredients, base_drinks_base_ingredients: {include: [:base_ingredient, unit:{include: [:unit_conversion] }]}]}]
  end

  private
  def event_params
    params.require(:event).permit(:uuid, :name)
  end

end
