class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :facebook_event_id, :start_at, :city, :country_code
end
