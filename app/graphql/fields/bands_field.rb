require_relative '../resolvers/bands_resolver'

Fields::BandsField = GraphQL::Field.define do
  name 'bands'
  description 'Bands connection to fetch paginated bands collection.'
  type Types::BandType.connection_type

  argument :query, types.String, 'Search query'
  argument :ids, types.String, 'Comma-separated list of band ids'

  resolve(Resolvers::BandsResolver.new)
end
