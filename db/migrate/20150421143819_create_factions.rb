class CreateFactions < ActiveRecord::Migration
  def change
    create_table :factions do |t|
      t.string :name, null: false
      t.integer :user_id, null: false
      t.integer :galaxy_id, null: false
    end
    add_index :factions, [:name, :galaxy_id], unique: true
  end
end
