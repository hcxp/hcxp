if ENV['SENTRY_DSN'] != ''
  require 'raven'

  Raven.configure do |config|
    config.dsn = ENV['SENTRY_DSN']
  end
end
