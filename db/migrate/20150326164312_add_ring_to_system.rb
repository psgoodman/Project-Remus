class AddRingToSystem < ActiveRecord::Migration
  def change
    add_column :systems, :ring, :integer
    add_column :systems, :angle, :float
  end
end
