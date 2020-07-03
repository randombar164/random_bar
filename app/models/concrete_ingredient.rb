class ConcreteIngredient < ApplicationRecord
  belongs_to :base_ingredient
  has_many :handling_stores, through: :concrete_ingredients_handling_stores
end
