class BandPostsController < ApplicationController
  def index
    @band = find_band
    @posts = Post.all
  end

  private

  def find_band
    Band.find(params[:band_id])
  end

  def find_post
    Post.find(params[:id])
  end
end