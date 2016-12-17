json.extract! venue, :id, :name, :address, :user_id, :search_label, :created_at, :updated_at
json.url venue_url(venue, format: :json)