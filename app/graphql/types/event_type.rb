Types::EventType = GraphQL::ObjectType.define do
  name "Event"
  description "All the events"

  field :id, !types.ID
  field :name, types.String
  field :price, types.String
  field :link, types.String
  field :ownership_type, types.String
  field :impressions_count, types.String, 'Views count'
  field :status, types.String
  field :poster, types.String

  field :name_or_bands, types.String do
    description 'Name of event or comma-separated list of bands if name is absent'
    resolve -> (obj, _args, _ctx) { obj.decorate.name_or_bands }
  end

  field :beginning_at, Types::DateTimeType
  field :created_at, Types::DateTimeType
  field :updated_at, Types::DateTimeType

  connection :bands, Fields::BandsField
  connection :bandables, Fields::BandablesField
  field :venue, Types::VenueType
end
