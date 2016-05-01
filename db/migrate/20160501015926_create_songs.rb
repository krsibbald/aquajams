class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :name
      t.references :artist, index: true, foreign_key: true
      t.integer :length_in_sec
      t.integer :year
      t.integer :top_billboard_spot
      t.decimal :billboard_weeks

      t.timestamps null: false
    end
  end
end
