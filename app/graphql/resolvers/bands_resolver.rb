class Resolvers::BandsResolver
  def call(obj, args, ctx)
    col = obj ? obj.bands : Band.all

    col = col.search(args[:query]) if args[:query].present?
    # col = col.order(created_at: :desc)

    col
  end
end
