class CreateConcreteIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :concrete_ingredients do |t|
      t.references :base_ingredient, foreign_key: true
      t.string :name
      t.string :url

      t.timestamps
    end
  end
end
