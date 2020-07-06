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
end
