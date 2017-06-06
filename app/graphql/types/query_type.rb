Types::QueryType = GraphQL::ObjectType.define do
  name "Query"
  # Add root-level fields here.
  # They will be entry points for queries on your schema.
  field :node, GraphQL::Relay::Node.field

  connection :events, Fields::EventsField
  connection :bands, Fields::BandsField
  connection :venues, Fields::VenuesField
end
