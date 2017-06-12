class Resolvers::PostsResolver
  def call(obj, args, ctx)
    col = obj ? obj.posts : Post.all

    params = {
      query: args[:query]
    }

    service = PostsIndexService.new(col, params)
    service.call
  end
end
