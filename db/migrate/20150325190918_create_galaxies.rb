class CreateGalaxies < ActiveRecord::Migration
  def change
    create_table :galaxies do |t|
      t.string :name, null: false, unique: true
    end
  end
end
