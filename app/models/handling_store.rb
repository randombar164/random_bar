class HandlingStore < ApplicationRecord
  has_many :concrete_ingredients_handling_stores
  has_many :concrete_ingredients, through: :concrete_ingredients_handling_stores
end
