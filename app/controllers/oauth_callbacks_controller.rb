class OauthCallbacksController < ApplicationController
  def discourse
    outcome = OauthReceivers::Discourse.new(auth: request.env['omniauth.auth'])

    if outcome.valid?
      user = outcome.execute
      sign_in user
      redirect_to root_path
    else
      redirect_to root_path, notice: 'Something went wrong while authenticating via discourse'
    end
  end
end
