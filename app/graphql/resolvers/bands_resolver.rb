class Resolvers::BandsResolver
  def call(obj, args, ctx)
    col = obj ? obj.bands : Band.all

    params = {
      query: args[:query],
      id_in: (args[:ids].split(',') if args[:ids])
    }

    service = BandsIndexService.new(col, params)
    service.call
  end
end
