event = (event.class == EventDecorator) ? event : event.decorate

json.extract! event, :id, :name, :name_or_bands, :search_label, :beginning_at, :venue_id, :created_at, :updated_at

json.url event_url(event, format: :json)

if event.venue.present?
  json.venue do
    json.partial! "venues/venue", venue: event.venue
  end
end