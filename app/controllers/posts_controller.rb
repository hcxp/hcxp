class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /venues
  # GET /venues.json
  def index
    @posts = posts_index(Post.all)
  end

  # GET /venues/1
  # GET /venues/1.json
  def show
    view   = @post.text? ? 'show_text' : 'show_link'
    @team  = @post.team.decorate if @post.team_id.present?
    @event = @post.event.decorate if @post.event_id.present?

    render view
  end

  def new_form
    authenticate_user!
    @post = Post.new(type: 'text')
  end

  def edit
    authenticate_user!
    authorize @post

    if @post.body.present?
      render :new_form
    end
  end

  def create
    authenticate_user!

    @post = Post.new(post_params)
    @post.type  = 'text'
    @post.user  = current_user
    @post.actor = current_user

    if @post.save
      redirect_to @post, notice: 'Post created successfully!'
    else
      render :new_form
    end
  end

  def update
    @post.actor = current_user

    if @post.update_attributes(post_params)
      redirect_to @post, notice: 'Post updated successfully'
    else
      render :new_form
    end
  end

  private #---------------------------------------------------------------------

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id]).decorate
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  # @todo Move band_ids parsing to checkbox
  def post_params
    params[:post][:band_ids] = params[:post][:band_ids].split(',') if params[:post] && params[:post][:band_ids] && params[:post][:band_ids].include?(',')
    params.require(:post).permit(:url, :title, :body, :type, :event_id, :team_id, :occured_at, :band_ids => [])
  end
end
