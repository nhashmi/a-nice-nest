class CreateRankings < ActiveRecord::Migration
  def change
    create_table :rankings do |t|
      t.belongs_to :user
      t.string :resident_name, default: "A resident"
      t.string :public_transportation, default: 'low priority'
      t.string :own_baths, default: 'low priority'
      t.string :own_beds, default: 'low priority'
      t.integer :max_rent, default: 0
      t.string :size, default: 'low priority'
      t.string :bike_friendly, default: 'low priority'
      t.string :parking, default: 'low priority'
      t.timestamps
    end
  end
end
