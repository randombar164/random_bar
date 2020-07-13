class Substitution < ApplicationRecord
  belongs_to :substituted, class_name: "BaseIngredient"
  belongs_to :substituting, class_name: "BaseIngredient"
end
