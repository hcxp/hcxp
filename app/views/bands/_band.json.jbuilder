json.extract! band, :id, :name, :location, :search_label, :created_at, :updated_at
json.url band_url(band, format: :json)