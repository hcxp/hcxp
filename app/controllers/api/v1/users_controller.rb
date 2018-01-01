class Api::V1::UsersController < Api::V1Controller
  def me
    render json: current_user, adapter: :json_api
  end

  def signout
    sign_out
    head :ok
  end
end
