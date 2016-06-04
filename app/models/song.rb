class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :cd
  #songs are unique to name, cd & artist
  validates_uniqueness_of :name, :scope => [:cd_id, :artist_id]

end
