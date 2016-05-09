class SongsUniqueConstraint < ActiveRecord::Migration
  def change
    add_index :songs, [:name, :cd_id, :artist_id], unique: true
  end
end
