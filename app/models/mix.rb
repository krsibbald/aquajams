class Mix < ActiveRecord::Base
  has_many :tracks
  has_many :songs, through: :tracks
end
