class BandsController < ApplicationController
  before_action :set_band, only: [:show, :player_code, :refetch_photo, :edit, :update, :destroy]

  # GET /venues
  # GET /venues.json
  def index
    @bands = bands_index(Band.includes(:events))
  end

  # GET /venues/1
  # GET /venues/1.json
  def show
    @events = events_index(@band.events)
  end

  def player_code
    code = cell(:post_player, @band.post_for_player).()
    render json: { code: code }
  end

  def edit
  end

  def create
    authenticate_user!
    @band = Band.new(band_params)
    @band.user = current_user

    if @band.save
      render 'api/v1/bands/_band', status: :created, location: @band, locals: { band: @band }
    else
      render json: { errors: @band.errors, full_error_messages: @band.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def refetch_photo
    authorize @band
    post = @band.posts.where('url LIKE ?', '%bandcamp.com%').order(id: :asc).last
    ScrapBandcampPhotoWorker.perform_async(@band.id, post.url) if post.present?

    redirect_to :back, notice: 'Refetching photo enqueued.'
  end

  private #---------------------------------------------------------------------

  # Use callbacks to share common setup or constraints between actions.
  def set_band
    @band = Band.friendly.find(params[:id]).decorate
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def band_params
    params.require(:band).permit(:name, :location)
  end
end
