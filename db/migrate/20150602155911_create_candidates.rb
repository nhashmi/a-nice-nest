class CreateCandidates < ActiveRecord::Migration
  def change
    create_table :candidates do |t|
      t.belongs_to :user
      t.string :zpid
      t.text :notes, default: ""
      t.timestamps
    end
  end
end
