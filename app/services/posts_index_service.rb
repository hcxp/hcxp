class PostsIndexService
  def initialize(col = Post.all, params = {})
    @col    = col
    @params = params
  end

  def call
    posts = @col
    posts = posts.search(@params[:query]) if @params[:query].present?

    posts
  end
end
