module Resolvers::ValidationResolver
  def first_or_last_required!(args)
    raise GraphQL::ExecutionError.new(
      'You must provide a `first` or `last` value to properly paginate this connection.'
    ) if (!args[:first].present? && !args[:last].present?)
  end
end
