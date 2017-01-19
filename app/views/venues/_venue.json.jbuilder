json.extract! venue, :id, :name, :address, :search_label, :created_at, :updated_at
json.url venue_url(venue, format: :json)