class CreateConcreteIngredientsHandlingStores < ActiveRecord::Migration[5.2]
  def change
    create_table :concrete_ingredients_handling_stores do |t|
      t.references :concrete_ingredient, foreign_key: true, index: { name: 'concrete_ingredients_handling_stores_c_index_name' }
      t.references :handling_store, foreign_key: true, index: { name: 'concrete_ingredients_handling_stores_h_index_name' }

      t.timestamps
    end
  end
end
