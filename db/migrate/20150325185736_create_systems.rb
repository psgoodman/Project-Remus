class CreateSystems < ActiveRecord::Migration
  def change
    create_table :systems do |t|
      t.string :name, null: false
      t.integer :galaxy_id, null: false

      t.integer :census
      t.integer :max_census
      t.integer :raw
      t.integer :infrastructure

      t.timestamps
    end
  end
end
