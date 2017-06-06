Types::BandType = GraphQL::ObjectType.define do
  name "Band"

  field :id, !types.ID
  field :name, types.String
  field :location, types.String
  field :lat, types.Float
  field :lng, types.Float
  field :city, types.String
  field :country_code, types.String
  field :events_count, types.Int
  field :slug, types.String
  field :photo, types.String

  field :created_at, Types::DateTimeType
  field :updated_at, Types::DateTimeType

  connection :events, Fields::EventsField
end
