class BaseDrinksBaseIngredient < ApplicationRecord
  belongs_to :base_ingredient
  belongs_to :base_drink
  belongs_to :unit

  def self.get_base_drink_ids_from_base_ingredient_ids params_base_ingredient_ids
    base_drink_ids = params_base_ingredient_ids.each_with_object([]) do |bi_id, base_drink_ids|
      base_drink_ids_candidate = self.where(base_ingredient_id: bi_id).group(:base_drink_id).having('count(base_drink_id)>=1').count.keys
      BaseIngredient.includes(:substitutings).find(bi_id).substitutings.ids.each do |s_id|
        base_drink_ids_candidate.concat self.where(base_ingredient_id: s_id).group(:base_drink_id).having('count(base_drink_id)>=1').count.keys
      end
      base_drink_ids.concat(base_drink_ids_candidate.uniq)
    end
    base_drink_ids.group_by(&:itself).select{ |k, v| v.length >= params_base_ingredient_ids.length}.keys
  end
end
