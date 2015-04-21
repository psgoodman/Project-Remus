class AddGmToGalaxy < ActiveRecord::Migration
  def change
    add_column :galaxies, :gm_id, :integer
  end
end
