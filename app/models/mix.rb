class Mix < ActiveRecord::Base
  has_many :tracks
  has_many :songs, through: :tracks 
  validates :code, presence: true, uniqueness: true
end
