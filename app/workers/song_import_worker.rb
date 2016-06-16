class SongImportWorker < ImportWorker
  include Sidekiq::Worker
  HEADERS = ["CD's ID", "___Song", "Time, as hh:mm:ss", '___Year', '___Artist', '___Billboard Position', '__+ Weeks at', 'BPM 1']

  def perform(file)
    row_num = 0
    cd = nil
    headers = []

    file_name = file_name_from_file(file)

    song_count = 0
    cd_count = 0
    artist_count = 0
    CSV.foreach(file_name, 'r:ISO-8859-15:UTF-8') do |row|
      row_num += 1
      if row_num == 1
        headers = row
      else
        info = Hash[*headers.zip(row).flatten] 
        if ! info["CD's ID"].blank?  #this row has cd information
          cd_code = info["CD's ID"]
          cd = Cd.where(code: cd_code).first
          unless cd
            cd_name = info["___Song"]
            cd = Cd.where(name: cd_name).first
            unless cd
              cd = Cd.new(name: cd_name, code: cd_code)
              if cd.save
                cd_count += 1
              end
            end
          end
        else #this row has song information
          song_name = info["___Song"]
          if cd && cd.songs.where(name: song_name).none?
            s = Song.new
            s.name = song_name
            t = info["Time, as hh:mm:ss"]
            if t && t.match(/\A[\d]?\d:\d\d:\d\d\z/)
              t_arr = t.split(':').map(&:to_i)
              s.length_in_sec = (((t_arr[0] * 60) + t_arr[1]) * 60) + t_arr[2] #hours + mins + seconds
            end
            s.year = info['___Year']

            artist_name = info['___Artist'].try(:strip)
            unless artist_name.blank?
              artist = Artist.find_by_name artist_name
              unless artist
                artist = Artist.new(name: artist_name)
                if artist.save
                  artist_count += 1
                end
              end
              s.artist = artist
            end

            s.top_billboard_spot = info['___Billboard Position']
            s.billboard_weeks = info['__+ Weeks at']
            s.cd_id = cd.try(:id) #cd is set during cd row processing
            s.bpm = info['BPM 1']
            if s.save!
              song_count += 1
              #Is it listed on any mix tracks? 
              mix_keys = []
              info.keys.each do |k|
                if k.match(/\A_+\d+\z/)
                  mix_keys << k
                end
              end
              mix_list = {}
              mix_keys.each do |k|
                if info[k] && (info[k] != 0) && (info[k] != '0')#not nil
                  mix_list[k] = info[k]
                end
              end
              mix_list.keys.each do |mix_name|
                mix_code = mix_name.match(/\A_+(\d+)\z/)[1].to_i
                mix = Mix.where(code: mix_code).first || Mix.create(code: mix_code)
                Track.create(mix: mix, song: s)
              end
            end
          end
        end
      end
    end
    "#{song_count} Songs, #{cd_count} CDs, and #{artist_count} Artists added"
  end
end