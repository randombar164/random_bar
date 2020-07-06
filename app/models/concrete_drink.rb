class ConcreteDrink
  include ActiveModel::Model
  attr_accessor :base_drink, :concrete_ingredients

  def to_json
    concrete_drink_json = {
      base_drink: JSON.parse(@base_drink.to_json(include: [:drink_method, :glass_type, :base_ingredients, base_drinks_base_ingredients: {include: [:base_ingredient, :unit]}])),
      concrete_ingredients: JSON.parse(@concrete_ingredients.to_json(include: [:handling_stores]))
    }
  end
end
