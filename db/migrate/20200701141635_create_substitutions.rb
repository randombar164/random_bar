class CreateSubstitutions < ActiveRecord::Migration[5.2]
  def change
    create_table :substitutions do |t|
      t.integer :substituted_id
      t.integer :substituting_id

      t.timestamps
    end
    add_index :substitutions, :substituted_id
    add_index :substitutions, :substituting_id
  end
end
