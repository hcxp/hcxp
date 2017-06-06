class Resolvers::BandablesResolver
  def call(obj, args, ctx)
    col = obj ? obj.bandables : Bandable.all

    # col = col.search(args[:query]) if args[:query].present?
    # col = col.order(created_at: :desc)

    col
  end
end
