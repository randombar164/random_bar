class DrinkMethod < ApplicationRecord
  validates :name, uniqueness: true
end
