json.array!(@cds) do |cd|
  json.extract! cd, :id, :name, :code, :time_in_sec
  json.url cd_url(cd, format: :json)
end
