json.array!(@tracks) do |track|
  json.extract! track, :id, :mix_id, :song_id, :ord
  json.url track_url(track, format: :json)
end
