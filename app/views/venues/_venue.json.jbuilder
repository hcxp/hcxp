json.extract! venue, :id, :name, :address, :user_id, :search_label, :created_at, :updated_at
json.url venue_url(venue, format: :json)

json.static_map_url do
  json.medium venue.decorate.static_map_url(538, 200).to_s
end