class CreateUnitClasses < ActiveRecord::Migration
  def change
    create_table :unit_classes do |t|
      t.string :name, null: false
      t.text :description
      t.integer :faction_id
    end

    add_column :units, :class_id, :integer
  end
end
