class BaseDrink < ApplicationRecord
  belongs_to :drink_method
  belongs_to :glass_type
end
