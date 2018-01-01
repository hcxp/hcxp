class SyncUserDiscourseProfileJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    @user = User.find(user_id)

    resource = @user.oauth_resources.find_by!(provider: 'discourse')
    discourse_user = discourse.user(resource.username)

    avatar_url = URI::HTTPS.build(
      host: 'forum.hard-core.pl',
      path: discourse_user['avatar_template'].gsub('{size}', '120')
    ).to_s

    @user.update_attribute(:avatar_url, avatar_url)
  end

  private

  def discourse
    client = DiscourseApi::Client.new('https://forum.hard-core.pl')
    client.api_key = ENV['DISCOURSE_API_KEY']
    client.api_username = ENV['DISCOURSE_API_USERNAME']
    client
  end
end
