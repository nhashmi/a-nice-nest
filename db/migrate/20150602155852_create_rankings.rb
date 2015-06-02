class CreateRankings < ActiveRecord::Migration
  def change
    create_table :rankings do |t|
      t.belongs_to :resident
      t.string :public_transportation
      t.string :own_baths
      t.string :own_beds
      t.integer :max_rent
      t.string :size
      t.string :bike_friendly
      t.string :parking
      t.timestamps
    end
  end
end
