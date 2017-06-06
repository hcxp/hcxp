require_relative '../resolvers/bands_resolver'

Fields::BandsField = GraphQL::Field.define do
  name 'bands'
  description 'Bands connection to fetch paginated bands collection.'
  type Types::BandType.connection_type

  argument :query, types.String, 'Search query'

  resolve(Resolvers::BandsResolver.new)
end