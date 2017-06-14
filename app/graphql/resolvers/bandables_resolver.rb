class Resolvers::BandablesResolver
  include Resolvers::ValidationResolver

  def call(obj, args, ctx)
    first_or_last_required!(args)

    col = obj ? obj.bandables : Bandable.all

    # col = col.search(args[:query]) if args[:query].present?
    # col = col.order(created_at: :desc)

    col
  end
end
