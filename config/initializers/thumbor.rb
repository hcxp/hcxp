ThumborRails.setup do |config|
  config.server_url   = ENV['THUMBOR_SERVER_URL']
  config.security_key = ENV['THUMBOR_SECURITY_KEY']
end
