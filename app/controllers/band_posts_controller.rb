class BandPostsController < ApplicationController
  def index
    @band = find_band
    @posts = find_posts
    @post = Post.new
  end

  def create
    authenticate_user!
    @band  = find_band
    @posts = find_posts

    @post      = Post.new(post_params)
    @post.user = current_user
    @post.bands << @band

    if @post.save
      redirect_to band_posts_path, notice: 'Post saved successfully'
    else
      render :index
    end
  end

  private

  def find_posts
    find_band.posts.includes(:user).newest_first
  end

  def find_band
    Band.friendly.find(params[:band_id])
  end

  def find_post
    Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:url)
  end
end