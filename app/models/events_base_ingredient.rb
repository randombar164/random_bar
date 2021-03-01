class EventsBaseIngredient < ApplicationRecord
  belongs_to :event
  belongs_to :base_ingredient
end
