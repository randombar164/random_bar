class ConcreteIngredientsHandlingStore < ApplicationRecord
  belongs_to :concrete_ingredient
  belongs_to :handling_store

  def self.get_base_drink_ids_from_handling_store_ids handling_store_ids
    self.where(handling_store_id: handling_store_ids).group(:concrete_ingredient_id).having('count(concrete_ingredient_id)=?',handling_store_ids.length).count.keys
  end
end
