class CreateEventsBaseIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :events_base_ingredients do |t|
      t.references :event, foreign_key: true, index: { name: 'event_base_ingredient_index_name_1' }
      t.references :base_ingredient, foreign_key: true, index: { name: 'event_base_ingredient_index_name_2' }

      t.timestamps
    end
  end
end
