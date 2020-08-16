class GlassType < ApplicationRecord
  validates :name, uniqueness: true
end
