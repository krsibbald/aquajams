require 'csv'

class MixImportWorker < ImportWorker
  include Sidekiq::Worker

  HEADERS = ["___Prime, RoundDown (2)", 'One or Multiple?', '__Total Time', '___"Mix List" ID:  CD_mm-dd-yy.xls.', 'Date Recorded', '___Songs', 'Source', '___Music Type', '___Remarks']
  

  def perform(file)
    row_num = 0
    headers = []
    file_name = file_name_from_file(file)
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
          m.length_in_sec = (ttime.to_i * 60) unless ttime.blank?
          mix_list_date_str = info['___"Mix List" ID:  CD_mm-dd-yy.xls.']
          unless mix_list_date_str.blank?
            date_arr = mix_list_date_str.split('/').map(&:to_i)
            d = Date.new((2000 + date_arr[2]), date_arr[0], date_arr[1])
            m.date_for_mix_list = d
          end

          recorded_date_string = info['Date Recorded']
          unless recorded_date_string.blank?
            date_arr = recorded_date_string.split('/').map(&:to_i)
            d = Date.new((2000 + date_arr[2]), date_arr[0], date_arr[1])
            m.recorded_at = d
          end
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