require 'rails_helper'

RSpec.describe Song, type: :model do
  
  describe "import" do
    let(:csv){"#{Rails.root}/spec/support/songs_for_import.csv"}
    let!(:cd1958){FactoryGirl.create :cd, name: "1958, The Rock 'n' Roll Era", code: 1}
    it "should import" do
      expect(Song.count).to eq 0
      expect(Cd.count).to eq 1
      Song.import(csv)
      expect(Song.count).to eq 18
      expect(Cd.count).to eq 2
    end
    it "new artist, cd exists" do
      Song.import(csv)
      blues_song = Song.where(name: 'Summertime Blues').first
      expect(blues_song).to_not be_nil
      expect(blues_song.length_in_sec).to eq 118
      expect(blues_song.artist.try(:name)).to eq "Eddie Cochran"
      expect(blues_song.year).to eq 1958
      expect(blues_song.cd.try(:name)).to eq "1958, The Rock 'n' Roll Era"
    end
    it "artist already exists, new cd" do
      FactoryGirl.create :artist, name: 'Huey Lewis And the News'
      Song.import(csv)
      stuck_song = Song.where(name: 'Stuck With You').first
      expect(stuck_song).to_not be_nil
      expect(stuck_song.artist.try(:name)).to eq "Huey Lewis And the News"
      expect(stuck_song.year).to eq 1986
      expect(stuck_song.top_billboard_spot).to eq 1
      expect(stuck_song.billboard_weeks).to eq 1.03
      expect(stuck_song.cd.try(:name)).to eq "1986, Billboard Top Hits"
    end
    it "creates cds" do
      Song.import(csv)
      bad_song = Song.where(name: '1986, Billboard Top Hits').first
      expect(bad_song).to be_nil
      good_cd = Cd.where.where(name: '1986, Billboard Top Hits').first
      expect(good_cd).to_not be_nil
    end
  end
end
