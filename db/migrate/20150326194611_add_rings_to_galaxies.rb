class AddRingsToGalaxies < ActiveRecord::Migration
  def change
    add_column :galaxies, :rings, :integer
  end
end
