class AddFactionToUnits < ActiveRecord::Migration
  def change
    add_column :units, :faction_id, :integer, null: false
  end
end
