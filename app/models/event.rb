class Event < ApplicationRecord
  before_create do
    self.uuid = SecureRandom.uuid
  end
  has_many :events_base_ingredients
  has_many :base_ingredients, through: :events_base_ingredients
  accepts_nested_attributes_for :events_base_ingredients, allow_destroy: true

end
