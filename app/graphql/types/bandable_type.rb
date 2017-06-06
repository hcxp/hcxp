Types::BandableType = GraphQL::ObjectType.define do
  name "Bandable"

  field :id, !types.ID
  field :bandable_id, !types.ID
  field :bandable_type, !types.String
  field :band_id, !types.ID

  field :created_at, Types::DateTimeType
  field :updated_at, Types::DateTimeType

  field :band, Types::BandType
end
