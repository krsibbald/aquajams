json.array!(@songs) do |song|
  json.extract! song, :id, :name, :artist_id, :length_in_sec, :year, :top_billboard_spot, :billboard_weeks
  json.url song_url(song, format: :json)
end
