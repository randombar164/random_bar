class BaseDrink < ApplicationRecord
  belongs_to :drink_method
  belongs_to :glass_type
  has_many :base_drinks_base_ingredients
  has_many :base_ingredients, through: :base_drinks_base_ingredients

  def get_random_concrete_ingredients
    self.base_ingredients.each_with_object([]) do |base_ingredient, concrete_ingredients|
      substitutions = base_ingredient.substitutions
      substitutions_count = substitutions.count
      num = rand(substitutions_count + 1)
      num == substitutions_count ? \
        concrete_ingredients << base_ingredient.find_random_concrete_ingredient : \
        concrete_ingredients << substitutions[num].concrete_ingredients[rand(base_ingredient.substitutions[num].concrete_ingredients.count)]
    end
  end

  def get_concrete_ingredients_from_params(params_concrete_ingredients)
    params_concrete_ingredients.values.each_with_object([]) do |concrete_ingredient, concrete_ingredients|
      concrete_ingredients << ConcreteIngredient.includes(:handling_stores).find(concrete_ingredient[:concrete_ingredient_id])
    end
  end
end
