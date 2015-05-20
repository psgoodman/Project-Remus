class FixThingy < ActiveRecord::Migration
  def change
    remove_column :units, :class_id, :integer
    add_column :units, :unit_class_id, :integer
  end
end
