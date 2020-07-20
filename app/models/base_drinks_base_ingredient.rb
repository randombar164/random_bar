class BaseDrinksBaseIngredient < ApplicationRecord
  belongs_to :base_ingredient
  belongs_to :base_drink
  belongs_to :unit

  def self.get_base_drink_ids_from_base_ingredient_ids params_base_ingredient_ids
    self.where(base_ingredient_id: params_base_ingredient_ids).group(:base_drink_id).having('count(base_drink_id)>=?',params_base_ingredient_ids.length).count.keys
  end
end
