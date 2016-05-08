class AddCDtoSong < ActiveRecord::Migration
  def change
    add_reference :songs, :cd, index: true
  end
end
