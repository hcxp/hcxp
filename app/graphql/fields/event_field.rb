Fields::EventField = GraphQL::Field.define do
  name 'event'
  type Types::EventType

  argument :id, !types.ID

  resolve -> (_obj, args, _ctx) {
    Event.find(args[:id]).decorate
  }
end
