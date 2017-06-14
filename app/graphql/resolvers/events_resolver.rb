class Resolvers::EventsResolver
  include Resolvers::ValidationResolver

  def call(obj, args, ctx)
    first_or_last_required!(args)

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
