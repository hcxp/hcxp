Types::VenueType = GraphQL::ObjectType.define do
  name "Venue"

  field :id, !types.ID
  field :name, types.String
  field :address, types.String
  field :lat, types.Float
  field :lng, types.Float
  field :country_code, types.String
  field :street_name, types.String
  field :street_number, types.String
  field :slug, types.String

  field :created_at, Types::DateTimeType
  field :updated_at, Types::DateTimeType

  connection :events, Fields::EventsField
end
