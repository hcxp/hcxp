class Resolvers::PostsResolver
  include Resolvers::ValidationResolver

  def call(obj, args, ctx)
    first_or_last_required!(args)

    col = obj ? obj.posts : Post.all

    params = {
      query: args[:query]
    }

    service = PostsIndexService.new(col, params)
    service.call
  end
end
