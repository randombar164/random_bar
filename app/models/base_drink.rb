class BaseDrink < ApplicationRecord
  belongs_to :drink_method
  belongs_to :glass_type
  has_many :base_drinks_base_ingredients
  has_many :base_ingredients, through: :base_drinks_base_ingredients


  def params_valid?(concrete_ingredients_to_parse)
    return false if concrete_ingredients_to_parse.blank?
    concrete_ingredients = concrete_ingredients_to_parse.values
    return false if self.base_ingredients.count != concrete_ingredients.length
    return false if !check_concrete_ingredients(concrete_ingredients)
    return true
  end

  def check_concrete_ingredients(concrete_ingredients)
    concrete_ingredient_ids = []
    base_ingredient_ids = []
    concrete_ingredients.each do |concrete_ingredient|
      concrete_ingredient_ids.push concrete_ingredient[:concrete_ingredient_id].to_i
      base_ingredient_ids.push concrete_ingredient[:base_ingredient_id].to_i
    end
    return true if self.base_ingredients.ids == base_ingredient_ids
    return false if self.base_ingredients.ids.length != base_ingredient_ids.length

    self.base_ingredients.each_with_index do |base_ingredient, idx|
      if base_ingredient.id == base_ingredient_ids[idx]
        next
      end
      return false if base_ingredient.substitutions.ids.empty?
      return false unless base_ingredient.substitutions.ids.include?(base_ingredient_ids[idx])
      return false unless BaseIngredient.find(base_ingredient_ids[idx]).concrete_ingredients.ids.include?(concrete_ingredient_ids[idx])
    end
    return true
  end

end
