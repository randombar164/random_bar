class CreateGlassTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :glass_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
