require_relative '../resolvers/events_resolver'

Fields::EventsField = GraphQL::Field.define do
  name 'events'
  description 'Events connection to fetch paginated events collection.'
  type Types::EventType.connection_type

  argument :query, types.String, 'Search query'
  argument :scope, types.String, 'Timing scope (`past`, `upcoming`, `all`). Default: `upcoming`'

  resolve(Resolvers::EventsResolver.new)
end
