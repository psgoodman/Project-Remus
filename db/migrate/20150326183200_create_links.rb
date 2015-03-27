class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.integer :origin_system_id, null: false
      t.integer :destination_system_id, null: false

      t.timestamps
    end
  end
end
