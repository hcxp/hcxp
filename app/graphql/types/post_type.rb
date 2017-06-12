Types::PostType = GraphQL::ObjectType.define do
  name "Post"

  field :id, !types.ID
  field :title, types.String
  field :body, types.String
  field :url, types.String
  field :thumbnail, types.String
  field :type, types.String
  field :user_id, types.Int
  field :bands_count, types.Int
  field :team_id, types.Int
  field :venue_id, types.Int
  field :event_id, types.Int

  field :occured_at, Types::DateTimeType
  field :crawled_at, Types::DateTimeType
  field :created_at, Types::DateTimeType
  field :updated_at, Types::DateTimeType

  field :user, Types::UserType
  
  connection :bands, Fields::BandsField
  connection :bandables, Fields::BandablesField
end
