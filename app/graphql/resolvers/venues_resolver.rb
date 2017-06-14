class Resolvers::VenuesResolver
  include Resolvers::ValidationResolver

  def call(obj, args, ctx)
    first_or_last_required!(args)

    col = obj ? obj.venues : Venue.all

    params = {
      query: args[:query]
    }

    service = VenuesIndexService.new(col, params)
    service.call
  end
end
