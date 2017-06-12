class Resolvers::VenuesResolver
  def call(obj, args, ctx)
    col = obj ? obj.venues : Venue.all

    params = {
      query: args[:query]
    }

    service = VenuesIndexService.new(col, params)
    service.call
  end
end
