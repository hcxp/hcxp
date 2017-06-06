HcxpSchema = GraphQL::Schema.define do
  query(Types::QueryType)

  rescue_from ActiveRecord::RecordNotFound, &:message

  object_from_id -> (id, ctx) { decode_object(id) }
  id_from_object -> (obj, type, ctx) { encode_object(obj, type) }
  resolve_type -> (object, _ctx) { RelaySchema.types[type_name(object)] }
end
