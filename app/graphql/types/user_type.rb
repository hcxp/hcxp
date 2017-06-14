Types::UserType = GraphQL::ObjectType.define do
  name "User"

  field :id, !types.ID
  field :username, types.String

  connection :events, Fields::EventsField do
    description 'Events added by this user'
  end

  connection :posts, Fields::PostsField do
    description 'Posts added by this user'
  end

  connection :bands, Fields::BandsField do
    description 'Bands added by this user'
  end

  connection :venues, Fields::VenuesField do
    description 'Venues added by this user'
  end
end
