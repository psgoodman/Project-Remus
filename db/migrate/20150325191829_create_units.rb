class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.string :name, null: false
      t.integer :system_id
      t.integer :destination_id
    end
  end
end
