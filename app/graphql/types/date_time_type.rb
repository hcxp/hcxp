Types::DateTimeType = GraphQL::ScalarType.define do
  name "DateTime"

  coerce_input  -> (x, _ctx) { x }
  coerce_result -> (x, _ctx) { x.iso8601 }
end