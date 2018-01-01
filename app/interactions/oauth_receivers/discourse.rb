class OauthReceivers::Discourse < ActiveInteraction::Base

  object :auth, class: OmniAuth::AuthHash

  attr_reader :user

  def execute
    resource.present? ? handle_resource_present : handle_resource_not_present
  end

  private

  def resource
    @resource ||= UserOauthResource.find_by(
      uid: auth.uid,
      provider: auth.provider
    )
  end

  def handle_resource_present
    resource.user.update_attributes!(
      email: auth.info.email,
      username: auth.info.nickname
    )

    resource.user
  end

  def handle_resource_not_present
    User.transaction do
      @user = User.create!(
        email: auth.info.email,
        password: Devise.friendly_token(20),
        username: auth.info.nickname
      )

      UserOauthResource.create!(
        user: user,
        uid: auth.uid,
        provider: auth.provider,
        username: auth.info.nickname
      )
    end

    user
  end

end
