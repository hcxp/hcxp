class Resolvers::BandsResolver
  include Resolvers::ValidationResolver

  def call(obj, args, ctx)
    first_or_last_required!(args)

    col = obj ? obj.bands : Band.all

    params = {
      query: args[:query],
      id_in: (args[:ids].split(',') if args[:ids])
    }

    service = BandsIndexService.new(col, params)
    service.call
  end
end
