class Api::V1::BandsController < Api::V1Controller
  def create
    authenticate_user!
    @band = Band.new(band_params)
    @band.user = current_user

    if @band.save
      render @band, status: :created, location: @band
    else
      render json: { errors: @band.errors, full_error_messages: @band.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def band_params
    params.require(:band).permit(:name, :location)
  end

end