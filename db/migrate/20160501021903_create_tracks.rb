class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.references :mix, index: true, foreign_key: true
      t.references :song, index: true, foreign_key: true
      t.integer :ord

      t.timestamps null: false
    end
  end
end
