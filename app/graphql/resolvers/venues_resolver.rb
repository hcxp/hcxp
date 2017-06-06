class Resolvers::VenuesResolver
  def call(obj, args, ctx)
    col = obj ? obj.venues : Venue.all

    col = col.search(args[:query]) if args[:query].present?
    # col = col.order(created_at: :desc)

    col
  end
end
