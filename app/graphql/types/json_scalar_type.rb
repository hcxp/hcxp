Types::JsonScalarType = GraphQL::ScalarType.define do
  name "JSON"

  coerce_input  -> (x, ctx) { x }
  coerce_result -> (x, ctx) { x }
end
