class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /venues
  # GET /venues.json
  def index
    @posts = Post.all
  end

  # GET /venues/1
  # GET /venues/1.json
  def show
    view  = @post.text? ? 'show_text' : 'show_link'
    @team = @post.team.decorate if @post.team_id.present?

    render view
  end

  private #---------------------------------------------------------------------

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:url, :title, :body)
  end
end
