Fields::UserField = GraphQL::Field.define do
  name 'user'
  description 'Lookup a user by username'
  type Types::UserType

  argument :username, !types.String

  resolve -> (_obj, args, _ctx) {
    User.find_by!(username: args[:username]).decorate
  }
end
