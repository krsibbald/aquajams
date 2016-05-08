require 'csv'

class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :cd

  def self.import(file)
    row_num = 0
    cd = nil
    headers = []
    file_name = file.respond_to?(:path) ? file.path : file
    CSV.foreach(file_name) do |row|
      row_num += 1
      if row_num == 1
        headers = row
      else
        info = Hash[*headers.zip(row).flatten] 
        if ! info["CD's ID"].blank?  #this row has cd information
          cd_code = info["CD's ID"]
          cd = Cd.where(code: cd_code).first
          unless cd
            cd_name = info["___Song's Name"]
            cd = Cd.where(name: cd_name).first
            unless cd
              cd = Cd.create(name: cd_name, code: cd_code)
            end
          end
        else #this row has song information
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
          s.cd_id = cd.try(:id) #cd is set during cd row processing
          s.bpm = info['BPM 1']
          s.save!
        end
      end
    end
  end
end
