require 'rails_helper'

RSpec.describe Song, type: :model do
  
  describe "import" do
    let(:csv){"#{Rails.root}/spec/support/songs_for_import.csv"}
    it "should import" do
      expect(Song.count).to eq 0
      Song.import(csv)
      expect(Song.count).to eq 10

      blues_song = Song.where(name: 'Summertime Blues').first
      expect(blues_song).to_not be_nil
      expect(blues_song.time_in_sec).to eq 118
      expect(blues_song.artist.try(:name)).to eq "Eddie Cochran"
      expect(blues_song.year).to eq 1958
      
    end
  end
end
