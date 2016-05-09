require 'csv'

class Mix < ActiveRecord::Base
  has_many :tracks
  has_many :songs, through: :tracks

  def self.import(file)
    row_num = 0
    headers = []
    file_name = file.respond_to?(:path) ? file.path : file
    mix_count = 0
    CSV.foreach(file_name, 'r:ISO-8859-15:UTF-8') do |row|
      row_num += 1
      if row_num == 1
        headers = row
      else
        info = Hash[*headers.zip(row).flatten] 

        mix_code = info["___Prime, RoundDown (2)"]
        if Mix.where(code: mix_code).none?
          m = Mix.new(code: mix_code)
          m.multiple = (info['One or Multiple?'] == 'm')
          ttime = info['__Total Time']
          # m.length_in_sec = (ttime * 60) unless ttime.blank?
          m.date_for_mix_list = info['___"Mix List" ID:  CD_mm-dd-yy.xls.']
          m.recorded_at = info['Date Recorded']
          m.description = info['___Songs']
          m.source = info['Source']
          m.music_type = info['___Music Type']
          m.notes = info['___Remarks']
          if m.save
            mix_count += 1
          end
        end
      end
    end
    "#{mix_count} Mixes added"
  end
end
