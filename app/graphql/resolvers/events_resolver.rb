class Resolvers::EventsResolver
  def call(obj, args, ctx)
    col = obj ? obj.events : Event.all

    params = {
      query: args[:query],
      order: args[:order],
      s:     args[:scope]
    }

    service = EventsIndexService.new(col, params)
    service.call
  end
end
