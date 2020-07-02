class CreateBaseDrinks < ActiveRecord::Migration[5.2]
  def change
    create_table :base_drinks do |t|
      t.string :name
      t.float :strength
      t.text :cook_explanation
      t.references :drink_method, foreign_key: true
      t.references :glass_type, foreign_key: true

      t.timestamps
    end
  end
end
