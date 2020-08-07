class BaseIngredient < ApplicationRecord
  has_many :base_drinks_base_ingredients
  has_many :concrete_ingredients
  has_many :base_drinks, through: :base_drinks_base_ingredients
  has_many :active_relationships,  class_name:  "Substitution",
                                   foreign_key: "substituting_id",
                                   dependent:   :destroy
  has_many :passive_relationships, class_name:  "Substitution",
                                   foreign_key: "substituted_id",
                                   dependent:   :destroy
  has_many :substitutings, through: :active_relationships, source: :substituted
  has_many :substitutions, through: :passive_relationships, source: :substituting

  def find_random_concrete_ingredient
    self.concrete_ingredients[rand(self.concrete_ingredients.count)]
  end

  def handling_store_ids_without_unavailable
    handling_stores_count = HandlingStore.count
    ingredients = Array(self.concrete_ingredients)
    self.substitutions.each do |substitution|
      ingredients.concat(Array(substitution.concrete_ingredients))
    end
    handling_store_ids = ingredients.each_with_object([]) do |ingredient, handling_store_ids|
      handling_store_ids.concat(Array(ingredient&.handling_store_ids)).uniq!
      return handling_store_ids - [4] if (handling_store_ids - [4]).length == (handling_stores_count - 1)
    end
    return handling_store_ids
  end

  def check_handling_store_ids handling_store_ids
    self.concrete_ingredients.each do |ci|
      return true if (handling_store_ids - ci.handling_store_ids).length != handling_store_ids.length
    end
    return false
  end
end
