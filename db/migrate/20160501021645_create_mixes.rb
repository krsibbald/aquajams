class CreateMixes < ActiveRecord::Migration
  def change
    create_table :mixes do |t|
      t.string :name
      t.integer :length_in_sec
      t.date :recorded_at
      t.text :description
      t.text :source
      t.text :music_type
      t.text :notes

      t.timestamps null: false
    end
  end
end
