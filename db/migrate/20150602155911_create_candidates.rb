class CreateCandidates < ActiveRecord::Migration
  def change
    create_table :candidates do |t|
      t.belongs_to :user
      t.string :zpid
      t.string :street
      t.string :baths
      t.string :beds
      t.string :size
      t.string :total_rent
      t.text :notes, default: ''
      t.string :public_transportation, default: 'none'
      t.string :bike_friendly, default: 'none'
      t.string :parking, default: 'none'
      t.integer :score, default: 0
      t.timestamps
    end
  end
end
