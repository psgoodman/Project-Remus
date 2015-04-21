class AddFactionToSystems < ActiveRecord::Migration
  def change
    add_column :systems, :faction_id, :integer, null: false
  end
end
