require_relative '../resolvers/posts_resolver'

Fields::PostsField = GraphQL::Field.define do
  name 'posts'
  description 'Posts connection to fetch paginated posts collection.'
  type Types::PostType.connection_type

  argument :query, types.String, 'Search query'

  resolve(Resolvers::PostsResolver.new)
end
