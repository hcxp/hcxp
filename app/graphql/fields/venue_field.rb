Fields::VenueField = GraphQL::Field.define do
  name 'venue'
  type Types::VenueType

  argument :id, !types.ID

  resolve -> (_obj, args, _ctx) {
    Venue.find(args[:id]).decorate
  }
end
