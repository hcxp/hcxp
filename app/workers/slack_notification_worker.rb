class SlackNotificationWorker
  include Sidekiq::Worker

  def perform(post = {}, opts = {})
    return unless ENV['SLACK_NOTIFICATION_URL'].present?

    notifier = Slack::Notifier.new ENV['SLACK_NOTIFICATION_URL'] do
      defaults channel:  ENV['SLACK_NOTIFICATION_CHANNEL'] || '#hcxp',
               username: 'hcxp'
    end

    notifier.post post
  end
end