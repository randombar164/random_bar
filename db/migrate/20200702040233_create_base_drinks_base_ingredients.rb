class CreateBaseDrinksBaseIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :base_drinks_base_ingredients do |t|
      t.references :base_ingredient, foreign_key: true, index: { name: 'base_drinks_base_ingredients_i_index_name' }
      t.references :base_drink, foreign_key: true, index: { name: 'base_drinks_base_ingredients_d_index_name' }
      t.string :amount
      t.string :additional_explanation
      t.references :unit, foreign_key: true

      t.timestamps
    end
  end
end
