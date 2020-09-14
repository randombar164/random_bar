class CreateUnitConversions < ActiveRecord::Migration[5.2]
  def change
    create_table :unit_conversions do |t|
      t.references :unit, foreign_key: true
      t.float :amount

      t.timestamps
    end
  end
end
