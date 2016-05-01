json.array!(@mixes) do |mix|
  json.extract! mix, :id, :name, :length_in_sec, :recorded_at, :description, :source, :music_type, :notes
  json.url mix_url(mix, format: :json)
end
