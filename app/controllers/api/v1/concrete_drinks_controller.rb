class Api::V1::ConcreteDrinksController < Api::V1::BaseController

  def index
    q_params = QueryParamsDecoder.new(params).decode
    q_params = QueryParamsValidator.new(q_params).validate
    concrete_drink = ConcreteDrink.new(q_params)
    response_not_found("drink") and return if concrete_drink.nil?
    render json: {concrete_drink: concrete_drink.to_json}
  end

end
