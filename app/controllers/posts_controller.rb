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
    view  = @post.text? ? 'show_text' : 'show_link'
    @team = @post.team.decorate if @post.team_id.present?

    render view
  end

  def new_form
    @post = Post.new(type: 'text')
  end

  def edit
    if @post.body.present?
      render :new_form
    end
  end

  def create
    @post = Post.new(post_params)
    @post.type = 'text'
    @post.user = current_user

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

  def destroy
    authenticate_user!
    authorize @post

    @post.destroy!
    redirect_to root_path, notice: 'Post successfully removed'
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
