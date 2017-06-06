require_relative '../resolvers/bandables_resolver'

Fields::BandablesField = GraphQL::Field.define do
  name 'bandables'
  description 'Bandables connection to fetch paginated bandables collection.'
  type Types::BandableType.connection_type

  argument :query, types.String, 'Search query'

  resolve(Resolvers::BandablesResolver.new)
end