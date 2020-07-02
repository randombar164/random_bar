class CreateDrinkMethods < ActiveRecord::Migration[5.2]
  def change
    create_table :drink_methods do |t|
      t.string :name

      t.timestamps
    end
  end
end
