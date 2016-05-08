require 'csv'

class Song < ActiveRecord::Base
  belongs_to :artist

  def self.import(file_name)
    row_num = 0
    headers = []
    CSV.foreach(file_name) do |row|
      row_num += 1
      if row_num == 1
        headers = row
      else
        info = Hash[*headers.zip(row).flatten] 
        s = Song.new
        s.name = info["___Song's Name"]
        t = info["Time, as hh:mm:ss"]
        if t && t.match(/\A[\d]?\d:\d\d:\d\d\z/)
          t_arr = t.split(':').map(&:to_i)
          s.length_in_sec = (((t_arr[0] * 60) + t_arr[1]) * 60) + t_arr[2] #hours + mins + seconds
        end
        s.year = info['___Year']

        artist_name = info['___Artist'].try(:strip)
        unless artist_name.blank?
          artist = Artist.find_by_name artist_name
          artist = Artist.create(name: artist_name) unless artist
          s.artist = artist
        end

        s.top_billboard_spot = info['___Billboard Position']
        s.billboard_weeks = info['__+ Weeks at']
        s.save!
      end
    end
  end
end
