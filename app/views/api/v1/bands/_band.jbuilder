json.extract! band, :id, :name, :location, :search_label, :events_count, :created_at, :updated_at
json.url band_url(band, format: :json)

json.photo_url band.decorate.photo_url