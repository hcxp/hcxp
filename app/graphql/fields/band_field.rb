Fields::BandField = GraphQL::Field.define do
  name 'band'
  type Types::BandType

  argument :id, !types.ID

  resolve -> (_obj, args, _ctx) {
    Band.find(args[:id]).decorate
  }
end
