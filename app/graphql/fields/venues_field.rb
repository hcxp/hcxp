require_relative '../resolvers/venues_resolver'

Fields::VenuesField = GraphQL::Field.define do
  name 'venues'
  description 'Venues connection to fetch paginated venues collection.'
  type Types::VenueType.connection_type

  argument :query, types.String, 'Search query'

  resolve(Resolvers::VenuesResolver.new)
end