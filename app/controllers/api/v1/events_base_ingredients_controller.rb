class Api::V1::EventsBaseIngredientsController < Api::V1::BaseController

  def update 
    response_bad_request unless params[:assigned_user_name].present?

    event = Event.find_by(uuid: params[:event_uuid])
    ebi = EventsBaseIngredient.find_by(event_id: event.id, base_ingredient_id: params[:base_ingredient_id])
    render status: 404, json: { status: 404, message: "#{params} Not Found" } unless ebi.present?

    ebi.assigned_user_name = params[:assigned_user_name]
    ebi.is_assigned = true
    event.save!

    render json: {event: event}, include: [:base_ingredients, cookable_base_drinks: {include: [:drink_method, :glass_type, :base_ingredients, base_drinks_base_ingredients: {include: [:base_ingredient, unit:{include: [:unit_conversion] }]}]}]
  end

end
